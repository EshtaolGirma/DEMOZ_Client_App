// import 'dart:js';

import 'package:date_field/date_field.dart';
import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:demoz_client/saving/bloc/saving_bloc.dart';
import 'package:demoz_client/saving/bloc/saving_event.dart';
import 'package:demoz_client/saving/bloc/saving_state.dart';
import 'package:demoz_client/saving/screens/saving_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingPlanForm extends StatelessWidget {
  SavingPlanForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  DateTime today = new DateTime.now();

  late String title_value;
  late double goal_value;
  late double saved_value;
  late String description_value;
  late double amount_value;
  late int frequency_value;
  DateTime? startDate_value;
  DateTime? endDate_value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _pageBuilder(),
    );
  }

  Widget _pageBuilder() {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0), // here the desired height
            child: CustomAppBar(),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Creat A New Saving Plane",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _titleFormBuilder(),
                      Container(
                        child: Row(
                          children: [
                            _goalFormBuilder(),
                            SizedBox(
                              width: 15,
                            ),
                            _initialFormBuilder(),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            _frequnceyFormBuilder(),
                            SizedBox(
                              width: 15,
                            ),
                            _amountFormBuilder(),
                          ],
                        ),
                      ),
                      _startDetaFormBuilder(),
                      _endDateFormBuilder(),
                      _descriptionFormBuilder(),
                    ],
                  ),
                )),
          ),
          bottomNavigationBar:
              BlocConsumer<SavingCreationBloc, SavingCreationState>(
            listener: (context, state) {
              if (state is SavingCreationSave) {
                final bloc = BlocProvider.of<SavingBloc>(context);
                bloc.add(SavingRefresh());
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final savingCreate = BlocProvider.of<SavingCreationBloc>(context);

              return Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 00.0, 0.0, 0.0),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          savingCreate.add(SavingCreationDone(
                              title: title_value,
                              goal: goal_value,
                              saved: saved_value,
                              description: description_value,
                              amount: amount_value,
                              frequency: frequency_value,
                              startDate: startDate_value!,
                              endDate: endDate_value!));
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
                        Navigator.pop(context);
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
            },
          )),
    );
  }

  Widget _titleFormBuilder() {
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

  Widget _descriptionFormBuilder() {
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
              height: 150,
              child: TextFormField(
                maxLines: null,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  prefix: Text('Note:'),
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

  Widget _goalFormBuilder() {
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

  Widget _initialFormBuilder() {
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
                  keyboardType: TextInputType.number,
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

  Widget _amountFormBuilder() {
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

  Widget _frequnceyFormBuilder() {
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

  Widget _startDetaFormBuilder() {
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
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) {
                      startDate_value = e;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _endDateFormBuilder() {
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
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (e) {
                      endDate_value = e;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
