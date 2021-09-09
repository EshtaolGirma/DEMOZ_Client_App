import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:demoz_client/saving/bloc/saving_detail_bloc.dart';
import 'package:demoz_client/saving/bloc/saving_detail_event.dart';
import 'package:demoz_client/saving/bloc/saving_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SavingDetailScreen extends StatelessWidget {
  final int id;
  SavingDetailScreen({Key? key, required this.id}) : super(key: key);

  DateTime today = new DateTime.now();
  late String title_value;
  late double goal_value;
  late double saved_value;
  late String description_value;
  late double amount_value;
  late int frequency_value;
  late DateTime startDate_value;
  late DateTime endDate_value;

  late double deposit_amount;
  late DateTime deposit_date;
  late String deposit_desc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _formDepositKey = GlobalKey<FormState>();
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
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: CustomAppBar(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: BlocBuilder<SavingDetailBloc, SavingDetailState>(
              builder: (context, state) {
                print(state);
                // final savingDetialBloc =
                //     BlocProvider.of<SavingDetailBloc>(context);
                if (state is SavingDetailLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      _savingTitleBuilder(),
                      _savingDetailBuilder(),
                      SizedBox(
                        height: 30,
                      ),
                      Center(child: _remainingDaysConuterBuilder()),
                      SizedBox(
                        height: 30,
                      ),
                      _savingPeogressBarBuilder(),
                      _depsiteTitleBuilder(state.id),
                      _depositeList(),
                    ],
                  );
                }
                if (state is SavingDetailEditing) {
                  print(state.list);
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _titleFormBuilder(state.list[0].title),
                        Container(
                          child: Row(
                            children: [
                              _goalFormBuilder(state.list[0].goal.toString()),
                              SizedBox(
                                width: 15,
                              ),
                              _initialFormBuilder(
                                  state.list[0].saved.toString()),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              _frequnceyFormBuilder(
                                  state.list[0].frequency.toString()),
                              SizedBox(
                                width: 15,
                              ),
                              _amountFormBuilder(
                                  state.list[0].amount.toString()),
                            ],
                          ),
                        ),
                        _startDetaFormBuilder(state.list[0].startDate),
                        _endDateFormBuilder(state.list[0].endDate),
                        _descriptionFormBuilder(state.list[0].description),
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    _savingTitleBuilder(),
                    _savingDetailBuilder(),
                    SizedBox(
                      height: 30,
                    ),
                    Center(child: _remainingDaysConuterBuilder()),
                    SizedBox(
                      height: 30,
                    ),
                    _depsiteTitleBuilder(1),
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
        bottomNavigationBar: BlocBuilder<SavingDetailBloc, SavingDetailState>(
          builder: (context, state) {
            final savingDetailBloc = BlocProvider.of<SavingDetailBloc>(context);
            if (state is SavingDetailEditing) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 00.0, 0.0, 0.0),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          savingDetailBloc.add(SavingEditSave(
                              id: 1,
                              title: title_value,
                              goal: goal_value,
                              saved: saved_value,
                              description: description_value,
                              amount: amount_value,
                              frequency: frequency_value,
                              startDate: startDate_value,
                              endDate: endDate_value));
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
                        savingDetailBloc.add(SavingEditCancle(id));
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

  Widget _savingTitleBuilder() {
    return BlocBuilder<SavingDetailBloc, SavingDetailState>(
      builder: (context, state) {
        final savingDetailBloc = BlocProvider.of<SavingDetailBloc>(context);
        if (state is SavingDetailEditing) {
          return Container(
            margin: EdgeInsets.fromLTRB(22.0, 0.0, 0.0, 5.0),
            child: Text(
              "School Fee Saving",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        if (state is SavingDetailLoaded) {
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
                      savingDetailBloc.add(SavingEdit(state.id));
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
                    savingDetailBloc.add(SavingEdit(1));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _savingDetailBuilder() {
    return BlocBuilder<SavingDetailBloc, SavingDetailState>(
      builder: (context, state) {
        if (state is SavingDetailLoaded) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          final String startDate = formatter.format(state.list[0].startDate);
          final String endDate = formatter.format(state.list[0].endDate);
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
                    Text("$endDate"),
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
                      "Saving to pay for cooking class, somethings to pay for cooking class one more word",
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
    return BlocBuilder<SavingDetailBloc, SavingDetailState>(
      builder: (context, state) {
        if (state is SavingDetailLoaded) {
          DateTime endDate = state.list[0].endDate;
          DateTime today = DateTime.now();

          int remainingDays = today.difference(endDate).inDays * -1;
          return Container(
            width: 175,
            height: 175,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(
                  color: Colors.black,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$remainingDays",
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
        }
        return Container(
          width: 175,
          height: 175,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                color: Colors.black,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "5",
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

  Widget _savingPeogressBarBuilder() {
    return BlocBuilder<SavingDetailBloc, SavingDetailState>(
      builder: (context, state) {
        if (state is SavingDetailLoaded) {
          double goal = state.list[0].goal;
          double saved = state.list[0].saved;
          return Container(
            margin: EdgeInsets.fromLTRB(20, 0.0, 20, 0.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final maxWidth = MediaQuery.of(context).size.width - 95;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 15, 0.0),
                      child: StepProgressIndicator(
                        totalSteps: goal.toInt(),
                        currentStep: saved.toInt(),
                        size: 12,
                        padding: 0,
                        selectedColor: Color.fromRGBO(117, 243, 197, 1),
                        unselectedColor: Colors.black12,
                        roundedEdges: Radius.circular(10),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: -20,
                      child: Text("$goal"),
                    ),
                    Positioned(
                      top: -20,
                      left: (saved * maxWidth) / goal,
                      child: Text('$saved'),
                    ),
                  ],
                );
              },
            ),
          );
        }

        final total = 100;
        final currentAmount = 0;
        return Container(
          margin: EdgeInsets.fromLTRB(20, 0.0, 20, 0.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final maxWidth = MediaQuery.of(context).size.width - 95;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 15, 0.0),
                    child: StepProgressIndicator(
                      totalSteps: total,
                      currentStep: currentAmount,
                      size: 12,
                      padding: 0,
                      selectedColor: Color.fromRGBO(117, 243, 197, 1),
                      unselectedColor: Colors.black12,
                      roundedEdges: Radius.circular(10),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    bottom: -20,
                    child: Text("$total"),
                  ),
                  Positioned(
                    top: -20,
                    left: (currentAmount * maxWidth) / total,
                    child: Text('$currentAmount'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _depsiteTitleBuilder(int id) {
    return Container(
      margin: EdgeInsets.fromLTRB(22.0, 40.0, 15.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Text(
                  "Deposits",
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
        ],
      ),
    );
  }

  Widget _depositAddButtionBuilder(int id) {
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
        this
            ._scaffoldKey
            .currentState
            ?.showBottomSheet((ctx) => _buildBottomSheet(ctx, id));
      },
    );
  }

  Widget _depositeList() {
    return BlocBuilder<SavingDetailBloc, SavingDetailState>(
      builder: (context, state) {
        if (state is SavingDetailLoaded) {
          return _depositsListBuilder(state.list[0].deposit, state.id);
        }
        return Container(
          width: 30,
          height: 40,
          color: Colors.pink,
        );
      },
    );
  }

  Widget _depositsListBuilder(List depositList, int id) {
    List<Widget> list = [];
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    for (var i = 0; i < depositList.length; i++) {
      double amount = depositList[i]['Deposited Amount'].toDouble();
      String desc = depositList[i]['Description'];

      DateTime date = inputFormat.parse(
          depositList[i]['Deposit Date'][2].toString() +
              '-' +
              depositList[i]['Deposit Date'][1].toString() +
              '-' +
              depositList[i]['Deposit Date'][0].toString());
      list.add(_depositCardBuilder(amount, desc, date, id));
    }
    return Column(
      children: list,
    );
  }

  Widget _depositCardBuilder(
      double amount, String description, DateTime date, int id) {
    return BlocBuilder<SavingDetailBloc, SavingDetailState>(
      builder: (context, state) {
        if (state is SavingDetailLoaded) {
          return InkWell(
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                              child: Text(
                                "Note: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            _descriptionDisplayBuilder(description),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          );
        }

        return Container();
      },
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

  Widget _descriptionDisplayBuilder(String desc) {
    return Container(
      width: 250,
      child: Text(
        "$desc",
        textAlign: TextAlign.justify,
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
      padding: const EdgeInsets.fromLTRB(20.0, 10, 0.0, 0),
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
              Text("Goal"),
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: goal,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    double x = double.parse(value!);
                    if (x > 0) {
                      goal_value = x;
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

  Widget _initialFormBuilder(String initial) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10, 20.0, 0),
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
              Text("Initail Amount"),
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: initial,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    double x = double.parse(value!);
                    if (x > 0) {
                      saved_value = x;
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

  Widget _amountFormBuilder(String amount) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10, 20.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromRGBO(117, 243, 197, 1)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("One Time Deposite "),
              Container(
                width: 50,
                child: TextFormField(
                  initialValue: amount,
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
                width: 93,
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

  Widget _endDateFormBuilder(DateTime end) {
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
              Text("Date: "),
              Container(
                width: 150,
                child: DateTimeFormField(
                    initialValue: end,
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) {
                      endDate_value = e!;
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

    final bloc = BlocProvider.of<SavingDetailBloc>(context);
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
