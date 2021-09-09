// import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:demoz_client/bills/bloc/bill_detail_bloc.dart';
import 'package:demoz_client/bills/bloc/bill_detail_event.dart';
import 'package:demoz_client/bills/bloc/bills_bloc.dart';
import 'package:demoz_client/bills/bloc/bills_event.dart';
import 'package:demoz_client/bills/bloc/bills_state.dart';
import 'package:demoz_client/bills/screens/bills_detail_screen.dart';
import 'package:demoz_client/bills/screens/bills_plan_form_screen.dart';
import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BillsScreen extends StatelessWidget {
  static const String routeName = '/bills';
  const BillsScreen({Key? key}) : super(key: key);

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                _billsPageTitleBuilder(),
                _billsListBuilder(),
                _billsPlanAddButtonBuilder(cxt),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomFooterBar(),
      ),
    );
  }

  Widget _billsPageTitleBuilder() {
    return Container(
      margin: EdgeInsets.fromLTRB(22.0, 0.0, 0.0, 5.0),
      child: Text(
        "Bills",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _billsListBuilder() {
    return BlocBuilder<BillsBloc, BillsState>(
      builder: (context, state) {
        print(state);
        final billsBloc = BlocProvider.of<BillsBloc>(context);
        if (state is BillsLoading) {
          return Padding(
            padding: const EdgeInsets.all(60.0),
            child: Center(
              child: Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is BillsPlanLoaded) {
          return _billListBuilder(state.bills, context);
        }
        if (state is BillsUnloaded) {
          billsBloc.add(BillsLoad());
        }
        return Container(
          width: double.infinity,
          height: 350,
          child: Center(
            child: Text(
              'No Bills',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _billListBuilder(List<dynamic> bills_list, BuildContext context) {
    List<Widget> list = [];

    for (var i = 0; i < bills_list.length; i++) {
      var saving = _billsPlanCardBuilder(
          id: bills_list[i].id,
          title: bills_list[i].title,
          amount: bills_list[i].amount,
          date: bills_list[i].next_pay_day,
          cxt: context);
      list.add(saving);
    }
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: list,
    );
  }

  Widget _billsPlanCardBuilder(
      {required int id,
      required double amount,
      required DateTime date,
      required String title,
      required BuildContext cxt}) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String day = formatter.format(date);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Amount: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      "$amount",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Next Date: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "$day",
                      style: TextStyle(
                        // fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        final bloc = BlocProvider.of<BillDetailBloc>(cxt);
        bloc.add(RefershPage(id));
        Navigator.push(
          cxt,
          MaterialPageRoute(
            builder: (context) => BillsDetailScreen(
              id: id,
            ),
          ),
        );
      },
    );
  }

  Widget _billsPlanAddButtonBuilder(BuildContext cxt) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 125,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(20),
            color: Colors.black26,
            dashPattern: [18, 5],
            strokeWidth: 1,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.black26,
                size: 50,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          cxt,
          MaterialPageRoute(
            builder: (context) => BillsPlanFormScreen(),
          ),
        );
      },
    );
  }
}
