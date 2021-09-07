import 'package:demoz_client/expense/bloc/expense_bloc.dart';
import 'package:demoz_client/expense/bloc/expense_event.dart';
import 'package:demoz_client/expense/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseSummeryScreen extends StatelessWidget {
  static const String routeName = '/expense';
  const ExpenseSummeryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _homepageBuild();
  }
}

Widget _homepageBuild() {
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          _chartBuilder2(),
          _generalSummeryBuilder(),
          Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 0, 10.0),
                  child: Text(
                    "Expense",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                    textWidthBasis: TextWidthBasis.longestLine,
                  ))),
          _expenseListBuilder(),
        ]),
      ),
    ),
  );
}

Widget _generalSummeryBuilder() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _savingBoard(),
      _debtAndLoanBoard(),
    ],
  );
}

final List<ChartData> chartData = [
  ChartData('Expense', 2500, Color.fromRGBO(225, 225, 225, 0.5)),
  ChartData('Income', 10000, Color.fromRGBO(117, 243, 197, 1)),
];

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

Widget _chartBuilder2() {
  return Container(
    width: double.infinity,
    height: 300,
    child: Center(
      child: Container(
        width: 200,
        height: 200,
        child: SfCircularChart(
          series: <CircularSeries>[
            // Renders doughnut chart
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              radius: '100%',
              innerRadius: '75%',
              enableSmartLabels: true,
              enableTooltip: true,
              dataLabelMapper: (ChartData data, _) =>
                  (data.x + '\n' + data.y.toString()),
              dataLabelSettings: DataLabelSettings(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                isVisible: true,
                // Positioning the data label
                labelIntersectAction: LabelIntersectAction.none,
                labelAlignment: ChartDataLabelAlignment.auto,

                connectorLineSettings: ConnectorLineSettings(
                  length: '10',
                  // type: ConnectorType.curve,
                  color: Colors.black,
                  width: 2,
                ),
                labelPosition: ChartDataLabelPosition.outside,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _savingBoard() {
  return Container(
    width: 185,
    height: 150,
    child: Card(
      elevation: 2,
      color: Color.fromRGBO(250, 250, 250, 0.75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "5",
            style: TextStyle(
                color: Colors.black,
                fontSize: 40.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Saving Plans",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget _debtAndLoanBoard() {
  return Container(
    width: 185,
    height: 150,
    child: Card(
      elevation: 2,
      color: Color.fromRGBO(250, 250, 250, 0.75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Loans 3/5",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Debts 2/6",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget _expenseListBuilder() {
  return BlocConsumer<ExpenseBloc, ExpenseState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
      if (state is ExpenseLoading) {
        return CircularProgressIndicator();
      }
      if (state is ExpenseLoaded) {
        return _buildExpenseSummeryList(state.expenseList);
      }
      expenseBloc.add(ExpenseLoad());
      return Icon(Icons.all_inclusive_sharp);
    },
  );
}

Widget _expenseCard(String categoryName, double expense, double budget) {
  return Container(
    width: double.infinity,
    height: 85,
    child: Card(
      elevation: 1,
      // color: Color.fromRGBO(250, 250, 250, 0.75),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromRGBO(117, 243, 197, 1)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "\$$expense/$budget",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _wrapExpenseCardWithExpanstionTile(
    String categoryName, double expense, double budget, int id) {
  return BlocConsumer<ExpenseCategoryBloc, ExpenseCategoryDetailState>(
    listener: (context, state) {
      // TODO: implement listener
      if (state is ExpenseDetailClicked) {
        // Navigator.of(context).pushNamed('/expense_detial');
      }
    },
    builder: (context, state) {
      final expenseDetailBloc = BlocProvider.of<ExpenseCategoryBloc>(context);
      if (state is ExpenseDetailLoaded) {
        return ExpansionTile(
          trailing: SizedBox(),
          title: LayoutBuilder(builder: (context, constraints) {
            final newScale = 1.04 + 16.0 / constraints.maxWidth;

            return Container(
              transform: Matrix4.identity()..scale(newScale),
              child: _expenseCard(categoryName, expense, budget),
            );
          }),
          children: _expenseCategoryDetail(
              state.expenseDetailList, expenseDetailBloc),
          onExpansionChanged: (bool) {
            if (bool == true) {
              expenseDetailBloc.add(ExpenseDetailLoad(id + 1, categoryName));
            }
          },
        );
      }
      return ExpansionTile(
        trailing: SizedBox(),
        title: LayoutBuilder(builder: (context, constraints) {
          final newScale = 1.04 + 16.0 / constraints.maxWidth;

          return Container(
            transform: Matrix4.identity()..scale(newScale),
            child: _expenseCard(categoryName, expense, budget),
          );
        }),
        // children: _expenseCategoryDetail([]),
        onExpansionChanged: (bool) {
          if (bool == true) {
            expenseDetailBloc.add(ExpenseDetailLoad(id + 1, categoryName));
          }
        },
      );
    },
  );
}

Widget _buildExpenseSummeryList(List<dynamic> expenseSummery) {
  List<Widget> list = [];
  for (var i = 0; i < expenseSummery.length; i++) {
    var expense = _wrapExpenseCardWithExpanstionTile(
      expenseSummery[i].category,
      expenseSummery[i].total,
      expenseSummery[i].budget,
      i,
    );
    list.add(expense);
  }

  return Column(
    children: list,
  );
}

List<Widget> _expenseCategoryDetail(List detail, ExpenseCategoryBloc bloc) {
  Widget expenseDetail(String date, double aoumnt, int id) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(
            top: 10.0, left: 40.0, right: 20.0, bottom: 0.0),
        height: 60,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(117, 243, 197, 1),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$date",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                "\$$aoumnt",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        bloc.add(ExpenseDetailClick(id));
      },
    );
  }

  List<Widget> list = [];
  for (var i = 0; i < detail.length; i++) {
    list.add(
      expenseDetail(detail[i].date, detail[i].amount, detail[i].id),
    );
  }
  return list;
}
