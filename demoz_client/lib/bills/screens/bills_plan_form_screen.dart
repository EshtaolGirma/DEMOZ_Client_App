import 'package:date_field/date_field.dart';
import 'package:demoz_client/bills/bloc/bills_bloc.dart';
import 'package:demoz_client/bills/bloc/bills_event.dart';
import 'package:demoz_client/bills/bloc/bills_state.dart';
import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillsPlanFormScreen extends StatelessWidget {
  BillsPlanFormScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  DateTime today = new DateTime.now();

  late String title_value;
  late String description_value;
  late double amount_value;
  late int frequency_value;
  DateTime? startDate_value;

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
                        "Creat A New Bill Record",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _titleFormBuilder(),
                      _goalFormBuilder(),
                      _frequnceyFormBuilder(),
                      _startDetaFormBuilder(),
                      _descriptionFormBuilder(),
                    ],
                  ),
                )),
          ),
          bottomNavigationBar:
              BlocConsumer<BillCreationBloc, BillCreationState>(
            listener: (context, state) {
              if (state is BillCreationSave) {
                final bloc = BlocProvider.of<BillsBloc>(context);
                bloc.add(BillsRefresh());
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final savingCreate = BlocProvider.of<BillCreationBloc>(context);

              return Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 00.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          savingCreate.add(BillCreationDone(
                            title: title_value,
                            description: description_value,
                            amount: amount_value,
                            frequency: frequency_value,
                            startDate: startDate_value!,
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

  Widget _frequnceyFormBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
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
              TextFormField(
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
                    initialValue: DateTime.now(),
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
}
