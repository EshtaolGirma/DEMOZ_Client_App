import 'package:date_field/date_field.dart';
import 'package:demoz_client/bills/bloc/bill_detail_bloc.dart';
import 'package:demoz_client/bills/bloc/bill_detail_event.dart';
import 'package:demoz_client/bills/bloc/bill_detail_state.dart';
import 'package:demoz_client/bills/bloc/bills_bloc.dart';
import 'package:demoz_client/bills/bloc/bills_event.dart';
import 'package:demoz_client/navigation_bar/navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BillsDetailScreen extends StatelessWidget {
  final int id;
  BillsDetailScreen({Key? key, required this.id}) : super(key: key);

  DateTime today = new DateTime.now();
  late String title_value;
  late String description_value;
  late double amount_value;
  late int frequency_value;
  late DateTime startDate_value;

  late double deposit_amount;
  late DateTime deposit_date;
  late String deposit_desc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formDepositKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _pageBuilder(),
    );
  }

  Widget _pageBuilder() {
    return SafeArea(
      child: Scaffold(
        key: this._scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // here the desired height
          child: CustomAppBar(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: BlocBuilder<BillDetailBloc, BillDetailState>(
              builder: (context, state) {
                print(state);
                final billDetialBloc = BlocProvider.of<BillDetailBloc>(context);
                if (state is BillDetailLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      _billTitleBuilder(),
                      _billDetailBuilder(),
                      SizedBox(
                        height: 80,
                      ),
                      Center(child: Text('Next pay Date')),
                      Center(child: _remainingDaysConuterBuilder()),
                      SizedBox(
                        height: 30,
                      ),
                      _depositTitleBuilder(state.id),
                      _depositeList(),
                    ],
                  );
                }
                if (state is BillDetailEditing) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _titleFormBuilder(state.list[0].title),
                        _goalFormBuilder(state.list[0].amount.toString()),
                        Container(
                          child: Row(
                            children: [
                              _frequnceyFormBuilder(
                                  state.list[0].frequency.toString()),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        _startDetaFormBuilder(state.list[0].startDate),
                        _descriptionFormBuilder(state.list[0].description),
                      ],
                    ),
                  );
                }
                billDetialBloc.add(BillDetailLoad(id));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    _billTitleBuilder(),
                    _billDetailBuilder(),
                    SizedBox(
                      height: 60,
                    ),
                    Center(child: _remainingDaysConuterBuilder()),
                    SizedBox(
                      height: 30,
                    ),
                    _depositTitleBuilder(1),
                    Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<BillDetailBloc, BillDetailState>(
          builder: (context, state) {
            final billDetailBloc = BlocProvider.of<BillDetailBloc>(context);
            final billBloc = BlocProvider.of<BillsBloc>(context);
            billBloc.add(BillsRefresh());

            if (state is BillDetailEditing) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 00.0, 0.0, 0.0),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          billDetailBloc.add(BillEditSave(
                            id: id,
                            title: title_value,
                            description: description_value,
                            amount: amount_value,
                            frequency: frequency_value,
                            startDate: startDate_value,
                          ));
                        }
                      },
                      child: Container(
                        width: 225.0,
                        height: 65.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Color.fromRGBO(119, 237, 190, 1),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "Done",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        billDetailBloc.add(BillEditCancel(state.ids));
                      },
                      child: Container(
                        width: 100.0,
                        height: 65.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Color.fromRGBO(230, 18, 18, 1),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return CustomFooterBar();
          },
        ),
      ),
    );
  }

  Widget _billTitleBuilder() {
    return BlocBuilder<BillDetailBloc, BillDetailState>(
      builder: (context, state) {
        final billDetailBloc = BlocProvider.of<BillDetailBloc>(context);
        if (state is BillDetailEditing) {
          return Container(
            margin: EdgeInsets.fromLTRB(22.0, 0.0, 0.0, 5.0),
            child: Text(
              "School Fee Bill",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        if (state is BillDetailLoaded) {
          String title = state.list[0].title;
          return Container(
            margin: EdgeInsets.fromLTRB(22.0, 0.0, 0.0, 5.0),
            child: Row(
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 1, 0, 0),
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      billDetailBloc.add(BillEdit(state.id));
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          margin: EdgeInsets.fromLTRB(22.0, 0.0, 0.0, 5.0),
          child: Row(
            children: [
              Text(
                "Title",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 1, 0, 0),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    billDetailBloc.add(BillEdit(1));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _billDetailBuilder() {
    return BlocBuilder<BillDetailBloc, BillDetailState>(
      builder: (context, state) {
        if (state is BillDetailLoaded) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          final String startDate = formatter.format(state.list[0].startDate);
          String description = state.list[0].description;
          double deposit = state.list[0].amount;
          int frequency = state.list[0].frequency;
          return Container(
            margin: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      width: 230,
                      child: Text(
                        "$description",
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Deposite of : ",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text("$deposit birr"),
                    Text(
                      ", every: ",
                    ),
                    Text("$frequency day"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Starting on: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text("$startDate"),
                  ],
                ),
              ],
            ),
          );
        }
        return Container(
          margin: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    width: 230,
                    child: Text(
                      "Bill to pay for cooking class, somethings to pay for cooking class one more word",
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Deposite of : ",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text("200"),
                  Text(
                    ", every: ",
                  ),
                  Text("30 days"),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Starting on: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Text("24 August, 2020"),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Until: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 55,
                  ),
                  Text("24 August, 2021"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _remainingDaysConuterBuilder() {
    return BlocBuilder<BillDetailBloc, BillDetailState>(
      builder: (context, state) {
        if (state is BillDetailLoaded) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          final String endDate = formatter.format(state.list[0].next_pay_day);
          return Container(
            width: 200,
            height: 80,
            child: Text(
              "$endDate",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          );
        }
        return Container(
          width: 175,
          height: 175,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "0",
                style: TextStyle(
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "days left",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _depositTitleBuilder(int id) {
    return Container(
      margin: EdgeInsets.fromLTRB(22.0, 20.0, 15.0, 0.0),
      child: Container(
        child: Row(
          children: [
            Text(
              "Payments",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            _depositAddButtionBuilder(id),
          ],
        ),
      ),
    );
  }

  Widget _depositAddButtionBuilder(int ids) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 7, 7, 1),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 18.0, 0.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                "ADD",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        print('object');
        this
            ._scaffoldKey
            .currentState
            ?.showBottomSheet((ctx) => _buildBottomSheet(ctx, ids));
      },
    );
  }

  Widget _depositeList() {
    return BlocBuilder<BillDetailBloc, BillDetailState>(
      builder: (context, state) {
        if (state is BillDetailLoaded) {
          return _depositsListBuilder(state.list[0].deposit);
        }
        return Container();
      },
    );
  }

  Widget _depositsListBuilder(List depositList) {
    List<Widget> list = [];
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    for (var i = 0; i < depositList.length; i++) {
      double amount = depositList[i]['paid Amount'].toDouble();
      DateTime date = inputFormat.parse(
          depositList[i]['Deposit Date'][2].toString() +
              '-' +
              depositList[i]['Deposit Date'][1].toString() +
              '-' +
              depositList[i]['Deposit Date'][0].toString());

      list.add(_depositCardBuilder(amount, date));
    }
    return Column(
      children: list,
    );
  }

  Widget _depositCardBuilder(double amount, DateTime date) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: Color.fromRGBO(117, 243, 197, 1),
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _dateDisplayBuilder(date),
                      _depositeAmountDisplayBuilder(amount),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _dateDisplayBuilder(DateTime date) {
    return Container(
      width: 200,
      child: DateTimeFormField(
        dateTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        enabled: false,
        initialValue: date,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        mode: DateTimeFieldPickerMode.date,
      ),
    );
  }

  Widget _depositeAmountDisplayBuilder(double amount) {
    return Container(
      width: 100,
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: '$amount',
        style: TextStyle(fontSize: 20),
        enabled: false,
        decoration: InputDecoration(
          hintText: "Birr",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _titleFormBuilder(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromRGBO(117, 243, 197, 1)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Title: "),
              Container(
                width: 150,
                child: TextFormField(
                  initialValue: title,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value != null) {
                      title_value = value;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _descriptionFormBuilder(String desc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromRGBO(117, 243, 197, 1)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Container(
              height: 200,
              child: TextFormField(
                initialValue: desc,
                maxLines: null,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                validator: (value) {
                  description_value = value!;
                },
              )),
        ),
      ),
    );
  }

  Widget _goalFormBuilder(String goal) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromRGBO(117, 243, 197, 1)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Bill Amount"),
              TextFormField(
                initialValue: goal,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                validator: (value) {
                  double x = double.parse(value!);
                  if (x > 0) {
                    amount_value = x;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _frequnceyFormBuilder(String freq) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 0.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromRGBO(117, 243, 197, 1)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Frequencey\n (in days)"),
              Container(
                width: 290,
                child: TextFormField(
                  initialValue: freq,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    int x = int.parse(value!);
                    if (x > 0) {
                      frequency_value = x;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _startDetaFormBuilder(DateTime date) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromRGBO(117, 243, 197, 1)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Start Date: "),
              Container(
                width: 150,
                child: DateTimeFormField(
                    initialValue: date,
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) {
                      startDate_value = e!;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form _buildBottomSheet(BuildContext context, int id) {
    print('building bottom sheet');
    final bloc = BlocProvider.of<BillDetailBloc>(context);
    return Form(
      key: _formDepositKey,
      child: Container(
        height: 500,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListView(
          children: <Widget>[
            const ListTile(title: Text('ADD Deposit')),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.attach_money),
                labelText: 'Enter an integer',
              ),
              validator: (e) {
                double x = double.parse(e!);
                deposit_amount = x;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.date_range),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: DateTimeFormField(
                      initialValue: DateTime.now(),
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: InputBorder.none,
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (e) {
                        deposit_date = e!;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.note_alt_outlined),
                labelText: 'Description',
              ),
              validator: (e) {
                deposit_desc = e!;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                      onPressed: () => {
                            if (_formDepositKey.currentState!.validate())
                              {
                                print(id),
                                bloc.add(
                                  AddDeposit(
                                    id: id,
                                    amount: deposit_amount,
                                    date: deposit_date,
                                    desc: deposit_desc,
                                  ),
                                ),
                              },
                            bloc.add(RefershPage(id)),
                            Navigator.pop(context)
                          }),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.cancel),
                    label: const Text('close'),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
