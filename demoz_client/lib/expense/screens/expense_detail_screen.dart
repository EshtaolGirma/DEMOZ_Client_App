import 'package:date_field/date_field.dart';
import 'package:demoz_client/expense/bloc/expense_detail_state.dart';
import 'package:demoz_client/expense/bloc/expense_detail_bloc.dart';
import 'package:demoz_client/expense/bloc/expense_detail_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenesDetailScreen extends StatelessWidget {
  const ExpenesDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _pageBuilder(),
    );
  }
}

Widget _pageBuilder() {
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ExpenseDetailBloc, ExpenseDetailState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final detailBloc = BlocProvider.of<ExpenseDetailBloc>(context);
          if (state is DetailLoaded) {
            return Column(
              children: [
                _categoryTitleBuilder(),
                _amountDisplayBuilder(),
                _dateDisplayBuilder(),
                _accompliceDisplayBuilder(),
                _descriptionDisplayBuilder(),
                _buttonOrganizer(),
              ],
            );
          }
          if (state is DetailEditing) {
            return Column(
              children: [
                _categoryTitleBuilder(),
                _amountDisplayBuilder(),
                _dateDisplayBuilder(),
                _accompliceDisplayBuilder(),
                _descriptionDisplayBuilder(),
                _buttonOrganizer(),
              ],
            );
          }
          detailBloc.add(DetailLoad());
          return Stack(
            children: [
              Column(
                children: [
                  _categoryTitleBuilder(),
                  _amountDisplayBuilder(),
                  _dateDisplayBuilder(),
                  _accompliceDisplayBuilder(),
                  _descriptionDisplayBuilder(),
                  _buttonOrganizer(),
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

Widget _categoryTitleBuilder() {
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
                  "Food and Drinks",
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
                      "Food and Drinks",
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
                          detailBloc.add(DetailEdit());
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
                    "Food and Drinks",
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
                    return TextFormField(
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: "\$200",
                        border: InputBorder.none,
                      ),
                    );
                  }
                  if (state is DetailLoaded) {
                    return TextFormField(
                      textAlign: TextAlign.end,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "\$200",
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
        return DateTimeFormField(
          initialValue: DateTime.now(),
          decoration: const InputDecoration(
            // errorStyle: TextStyle(color: Colors.redAccent),
            border: InputBorder.none,
            // border: OutlineInputBorder(),
          ),
          mode: DateTimeFieldPickerMode.dateAndTime,
          // late maybe added
          // autovalidateMode: AutovalidateMode.always,
          // validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
          // onDateSelected: (DateTime value) {
          //   print(value);
          // },
        );
      }
      if (state is DetailLoaded) {
        return DateTimeFormField(
          enabled: false,
          initialValue: DateTime.now(),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          mode: DateTimeFieldPickerMode.dateAndTime,
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
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("With: "),
            Container(
              width: 150,
              child: BlocConsumer<ExpenseDetailBloc, ExpenseDetailState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is DetailEditing) {
                    return TextFormField(
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: "Jack",
                        border: InputBorder.none,
                      ),
                    );
                  }
                  if (state is DetailLoaded) {
                    return TextFormField(
                      textAlign: TextAlign.end,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "Jack",
                        border: InputBorder.none,
                      ),
                    );
                  }
                  return TextFormField(
                    textAlign: TextAlign.end,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "Contact",
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
                );
              }
              if (state is DetailLoaded) {
                return TextFormField(
                  maxLines: null,
                  textAlign: TextAlign.start,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: "Some note entered by user!",
                    border: InputBorder.none,
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

Widget _buttonOrganizer() {
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
            _cancelButtonBuilder(context),
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
        detailBloc.add(DetailSave());
      },
    ),
  );
}

Widget _cancelButtonBuilder(BuildContext cxt) {
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
        detailBloc.add(DetailCancle());
      },
    ),
  );
}
