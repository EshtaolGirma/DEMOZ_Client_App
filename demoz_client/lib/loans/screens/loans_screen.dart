// import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:demoz_client/loans/bloc/loans_bloc.dart';
import 'package:demoz_client/loans/bloc/loans_detail_bloc.dart';
import 'package:demoz_client/loans/bloc/loans_detail_event.dart';
import 'package:demoz_client/loans/bloc/loans_event.dart';
import 'package:demoz_client/loans/bloc/loans_state.dart';
import 'package:demoz_client/loans/screens/loan_detail_screen.dart';
import 'package:demoz_client/loans/screens/loans_form_page.dart';
import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoansScreen extends StatelessWidget {
  static const String routeName = '/loans';
  const LoansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _pageBuilder(context),
    );
  }
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
              _loanPageTitleBuilder(),
              _loanListBuilder(),
              _loanPlanAddButtonBuilder(cxt),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomFooterBar(),
    ),
  );
}

Widget _loanPageTitleBuilder() {
  return Container(
    margin: EdgeInsets.fromLTRB(22.0, 0.0, 0.0, 5.0),
    child: Text(
      "Loans",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _loanListBuilder() {
  return BlocBuilder<LoansBloc, LoansState>(
    builder: (context, state) {
      final loanBloc = BlocProvider.of<LoansBloc>(context);
      if (state is LoansLoading) {
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
      if (state is LoansLoaded) {
        return _loansListBuilder(state.loans, context);
      }
      loanBloc.add(LoansLoad());
      return Container(
        width: double.infinity,
        height: 200,
        child: Center(
          child: Text(
            'No Loans',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    },
  );
}

Widget _loansListBuilder(List<dynamic> loans_list, BuildContext context) {
  List<Widget> list = [];

  for (var i = 0; i < loans_list.length; i++) {
    var saving = _loansPlanCardBuilder(
        id: loans_list[i].id,
        title: loans_list[i].title,
        amount: loans_list[i].amount,
        borrower: loans_list[i].borrower,
        cxt: context);
    list.add(saving);
  }
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: list,
  );
}

Widget _loansPlanCardBuilder(
    {required int id,
    required double amount,
    required String title,
    required String borrower,
    required BuildContext cxt}) {
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
                    "Borrower: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "$borrower",
                    style: TextStyle(
                      fontSize: 20,
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
      final bloc = BlocProvider.of<LoanDetailBloc>(cxt);
      bloc.add(RefershPager(id));
      Navigator.push(
        cxt,
        MaterialPageRoute(
          builder: (context) => LoanDetailScreen(
            id: id,
          ),
        ),
      );
    },
  );
}

Widget _loanPlanAddButtonBuilder(BuildContext cxt) {
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
          builder: (context) => LoansFormScreen(),
        ),
      );
    },
  );
}
