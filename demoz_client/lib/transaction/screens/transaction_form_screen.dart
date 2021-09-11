import 'package:date_field/date_field.dart';
import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:demoz_client/transaction/bloc/transaction_form_bloc.dart';
import 'package:demoz_client/transaction/bloc/transaction_form_event.dart';
import 'package:demoz_client/transaction/bloc/transaction_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionFormScreen extends StatelessWidget {
  final int id;
  final String cat_name;
  final _formkey = GlobalKey<FormState>();
  TransactionFormScreen({Key? key, required this.id, required this.cat_name})
      : super(key: key);

  late double formAmount;
  late DateTime formDate;
  late String formDescription;
  String? formAccomplice;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _pageBuilder(context),
    );
  }

  Widget _pageBuilder(BuildContext cxt) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // here the desired height
          child: CustomAppBar(),
        ),
        body: BlocConsumer<TransactionDetailBloc, TransactionDetailState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<TransactionDetailBloc>(context);
            if (state is DetailLoaded) {
              double x = state.transactionDetailList.budget;
              double y = 0;
              if (state.transactionDetailList.budget != 0) {
                y = x - state.transactionDetailList.total;
              }
              return Column(
                children: [
                  _pageTitleBuilder(cat_name),
                  _budgetRemainder(x, y),
                  _amountFormBuilder(),
                  _dateFormBuilder(),
                  _accompliceFormBuilder(),
                  _descriptionFormBuilder(),
                ],
              );
            }
            bloc.add(DetailLoad(id));
            return Container();
          },
        ),
        bottomNavigationBar: _buttonOrganizer(cxt),
      ),
    );
  }

  Widget _pageTitleBuilder(title) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 0.0, 0),
        child: Text(
          "$title",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _budgetRemainder(double budget, double leftover) {
    return Container(
      margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0.0, 0.0, 0.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Budget = "),
                Text(
                  "$budget",
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Remaining Budget = "),
                Text(
                  "$leftover",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _amountFormBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color.fromRGBO(117, 243, 197, 1)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Amount: "),
              Container(
                width: 150,
                child: TextFormField(
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: "Birr",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    print(value);
                    if (value == null) {
                      formAmount = 0;
                    }
                    var x = double.parse(value!);
                    if (x <= 0) {
                      return "";
                    } else {
                      formAmount = x;
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

  Widget _dateFormBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color.fromRGBO(117, 243, 197, 1)),
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
                child: _datepickerBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _datepickerBuilder() {
    DateTime today = new DateTime.now();
    return DateTimeFormField(
      initialValue: DateTime.now(),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      mode: DateTimeFieldPickerMode.date,
      validator: (e) {
        print(e);
        if (e!.year > today.year) {
          return 'Can\'t spend in the future';
        } else {
          if (e.month > today.month) {
            return 'Can\'t spend in the future';
          } else {
            if (e.day > today.day) {
              return 'Can\'t spend in the future';
            } else {
              formDate = e;
            }
          }
        }
      },
    );
  }

  Widget _accompliceFormBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color.fromRGBO(117, 243, 197, 1)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("With: "),
              Container(
                width: 150,
                child: TextFormField(
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: "Contact",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    formAccomplice = value!;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _descriptionFormBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Color.fromRGBO(117, 243, 197, 1)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
          child: Container(
              height: 150,
              child: TextFormField(
                initialValue: "Some note entered by user",
                maxLines: null,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                validator: (value) {
                  print(formDescription);
                  if (value == null) {
                    formDescription = '';
                  }
                  formDescription = value!;
                },
              )),
        ),
      ),
    );
  }

  Widget _buttonOrganizer(BuildContext cxt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _updateButtonBuilder(cxt),
          _cancelButtonBuilder(cxt),
        ],
      ),
    );
  }

  Widget _updateButtonBuilder(BuildContext cxt) {
    final detailBloc = BlocProvider.of<TransactionDetailBloc>(cxt);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0.0, 10.0, 0.0),
      child: InkWell(
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
        onTap: () {
          print(formAccomplice);
          if (_formkey.currentState!.validate()) {
            detailBloc.add(DetailSave(
                formAmount, formDate, formDescription, formAccomplice!, id));
          }
        },
      ),
    );
  }

  Widget _cancelButtonBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0.0, 0.0, 0.0),
      child: InkWell(
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
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
