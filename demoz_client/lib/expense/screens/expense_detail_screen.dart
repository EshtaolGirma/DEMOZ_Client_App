import 'package:date_field/date_field.dart';
import 'package:demoz_client/expense/bloc/expense_detail_state.dart';
import 'package:demoz_client/expense/bloc/expense_detail_bloc.dart';
import 'package:demoz_client/expense/bloc/expense_detail_event.dart';
import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenesDetailScreen extends StatelessWidget {
  final int expense_id;
  final String cat_name;
  final _formkey = GlobalKey<FormState>();

  late double formAmount;
  late DateTime formDate;
  late String formDescription;
  String? formAccomplice;

  ExpenesDetailScreen(
      {Key? key, required this.expense_id, required this.cat_name})
      : super(key: key);

  ExpenesDetailScreen.accomplice(
      {required this.expense_id,
      required this.cat_name,
      required this.formAccomplice});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _pageBuilder(expense_id, cat_name),
    );
  }

  Widget _pageBuilder(int id, String cat_name) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // here the desired height
          child: CustomAppBar(),
        ),
        body: BlocConsumer<ExpenseDetailBloc, ExpenseDetailState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final detailBloc = BlocProvider.of<ExpenseDetailBloc>(context);
            if (state is DetailLoaded) {
              return Column(
                children: [
                  _categoryTitleBuilder(id, cat_name),
                  _amountDisplayBuilder(),
                  _dateDisplayBuilder(),
                  _accompliceDisplayBuilder(),
                  _descriptionDisplayBuilder(),
                  _buttonOrganizer(id),
                ],
              );
            }
            if (state is DetailEditing) {
              return Form(
                key: _formkey,
                child: Column(
                  children: [
                    _categoryTitleBuilder(id, cat_name),
                    _amountDisplayBuilder(),
                    _dateDisplayBuilder(),
                    _accompliceDisplayBuilder(),
                    _descriptionDisplayBuilder(),
                    _buttonOrganizer(id),
                  ],
                ),
              );
            }
            detailBloc.add(DetailLoad(id));
            return Stack(
              children: [
                Column(
                  children: [
                    _categoryTitleBuilder(id, cat_name),
                    _amountDisplayBuilder(),
                    _dateDisplayBuilder(),
                    _accompliceDisplayBuilder(),
                    _descriptionDisplayBuilder(),
                    _buttonOrganizer(id),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _categoryTitleBuilder(int id, String cat_name) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
        child: BlocConsumer<ExpenseDetailBloc, ExpenseDetailState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final detailBloc = BlocProvider.of<ExpenseDetailBloc>(context);
            if (state is DetailEditing) {
              return Column(
                children: [
                  Text(
                    "$cat_name",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  _budgetRemainder(),
                ],
              );
            }
            if (state is DetailLoaded) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "$cat_name",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 1, 0, 0),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            detailBloc.add(DetailEdit(id));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _budgetRemainder() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0.0, 0.0, 0.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Budget = "),
                Text(
                  "1000",
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
                  "234",
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

  Widget _amountDisplayBuilder() {
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
              Text("Amount: "),
              Container(
                width: 150,
                child: BlocConsumer<ExpenseDetailBloc, ExpenseDetailState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is DetailEditing) {
                      final amount = state.expenseDetailList.amount;
                      return TextFormField(
                        initialValue: '$amount',
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.end,
                        validator: (value) {
                          var x = double.parse(value!);
                          if (x <= 0) {
                            return "";
                          } else {
                            formAmount = x;
                          }
                        },
                        decoration: InputDecoration(
                          // hintText: "\$$amount",
                          border: InputBorder.none,
                        ),
                      );
                    }
                    if (state is DetailLoaded) {
                      final amount = state.expenseDetailList.amount;
                      return TextFormField(
                        textAlign: TextAlign.end,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "\$$amount",
                          border: InputBorder.none,
                        ),
                      );
                    }
                    return TextFormField(
                      textAlign: TextAlign.end,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "Birr",
                        border: InputBorder.none,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _datepickerBuilder() {
    return BlocConsumer<ExpenseDetailBloc, ExpenseDetailState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is DetailEditing) {
          DateTime today = new DateTime.now();
          return DateTimeFormField(
            initialValue: DateTime.now(),
            decoration: const InputDecoration(
              errorStyle: TextStyle(color: Colors.redAccent),
              border: InputBorder.none,
            ),
            mode: DateTimeFieldPickerMode.date,
            // late maybe added
            autovalidateMode: AutovalidateMode.always,
            validator: (e) {
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
        if (state is DetailLoaded) {
          final date = state.expenseDetailList.date;
          return DateTimeFormField(
            enabled: false,
            initialValue: date,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            mode: DateTimeFieldPickerMode.date,
          );
        }
        return Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40, 0.0),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                "Date",
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dateDisplayBuilder() {
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
                child: _datepickerBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accompliceDisplayBuilder() {
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
              Text("With: "),
              Container(
                width: 150,
                child: BlocBuilder<ExpenseDetailBloc, ExpenseDetailState>(
                  builder: (context, state) {
                    if (state is DetailEditing) {
                      String? contact =
                          formAccomplice == null ? 'Contacts' : formAccomplice;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: TextFormField(
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            hintText: "$contact",
                            suffixIcon: Icon(Icons.arrow_forward_ios_sharp),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            formAccomplice = value!;
                          },
                        ),
                      );
                    }
                    if (state is DetailLoaded) {
                      final accomplice = state.expenseDetailList.accomplice;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Text("$accomplice"),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Contact",
                          border: InputBorder.none,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _descriptionDisplayBuilder() {
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
            child: BlocConsumer<ExpenseDetailBloc, ExpenseDetailState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is DetailEditing) {
                  return TextFormField(
                    initialValue: "Some note entered by user",
                    maxLines: null,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      formDescription = value!;
                    },
                  );
                }
                if (state is DetailLoaded) {
                  final description = state.expenseDetailList.description;
                  return Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text('$description'),
                    ),
                  );
                }
                return TextFormField(
                  maxLines: null,
                  textAlign: TextAlign.start,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: "Note",
                    border: InputBorder.none,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonOrganizer(int id) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: BlocConsumer<ExpenseDetailBloc, ExpenseDetailState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is DetailLoaded) {
            return Container();
          }
          if (state is DetailUnloaded) {
            return Container();
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _updateButtonBuilder(context),
              _cancelButtonBuilder(context, id),
            ],
          );
        },
      ),
    );
  }

  Widget _updateButtonBuilder(BuildContext cxt) {
    final detailBloc = BlocProvider.of<ExpenseDetailBloc>(cxt);
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
          if (_formkey.currentState!.validate()) {
            detailBloc.add(DetailSave(formAmount, formDate, formDescription,
                formAccomplice!, expense_id));
          }
        },
      ),
    );
  }

  Widget _cancelButtonBuilder(BuildContext cxt, int id) {
    final detailBloc = BlocProvider.of<ExpenseDetailBloc>(cxt);
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
          detailBloc.add(DetailCancle(id));
        },
      ),
    );
  }
}
