import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:demoz_client/saving/bloc/saving_bloc.dart';
import 'package:demoz_client/saving/bloc/saving_detail_bloc.dart';
import 'package:demoz_client/saving/bloc/saving_detail_event.dart';
import 'package:demoz_client/saving/bloc/saving_event.dart';
import 'package:demoz_client/saving/bloc/saving_state.dart';
import 'package:demoz_client/saving/screens/saving_details_screen.dart';
import 'package:demoz_client/saving/screens/saving_plan_form_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingScreen extends StatelessWidget {
  SavingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savingBLoc = BlocProvider.of<SavingBloc>(context);
    // Future.delayed(Duration.zero, () => {savingBLoc.add(SavingRefresh())});
    return Container(
      child: _pageBuilder(),
    );
  }
}

Widget _pageBuilder() {
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(80.0), // here the desired height
      //   child: CustomAppBar(),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              _savingPageTitleBuilder(),
              _savingListBlocComsumer(),
              _savingPlanAddButtonBuilder(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomFooterBar(),
    ),
  );
}

Widget _savingPageTitleBuilder() {
  return Container(
    margin: EdgeInsets.fromLTRB(22.0, 0.0, 0.0, 5.0),
    child: Text(
      "Saving Plans",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _savingListBlocComsumer() {
  return BlocBuilder<SavingBloc, SavingState>(
    builder: (context, state) {
      final savingBLoc = BlocProvider.of<SavingBloc>(context);
      if (state is SavingLoading) {
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
      if (state is SavingLoaded) {
        return _savingListBuilder(state.savingPlans, context);
      }
      if (state is SavingUnLoaded) {
        savingBLoc.add(SavingLoad());
      }

      return Container(
        width: double.infinity,
        height: 350,
        child: Center(
          child: Text(
            'Start Saving Now',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    },
  );
}

Widget _savingListBuilder(List<dynamic> savingList, BuildContext context) {
  List<Widget> list = [];

  for (var i = 0; i < savingList.length; i++) {
    var saving = _savingPlanCardBuilder(
        id: savingList[i].id,
        title: savingList[i].title,
        goal: savingList[i].goal,
        saved: savingList[i].saved,
        context: context);
    list.add(saving);
  }
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: list,
  );
}

Widget _savingPlanCardBuilder({
  required int id,
  required String title,
  required double goal,
  required double saved,
  required BuildContext context,
}) {
  return InkWell(
    child: Container(
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
                      "Goal: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      "$goal",
                      style: TextStyle(
                        fontSize: 15,
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
                      "Saved: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "$saved",
                      style: TextStyle(
                        fontSize: 15,
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
    ),
    onTap: () {
      final bloc = BlocProvider.of<SavingDetailBloc>(context);
      bloc.add(RefershPage(id));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SavingDetailScreen(
            // id: id,
          ),
        ),
      );
    },
  );
}

Widget _savingPlanAddButtonBuilder() {
  return BlocBuilder<SavingBloc, SavingState>(
    builder: (context, state) {
      // final savingBLoc = BlocProvider.of<SavingBloc>(context);
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
            context,
            MaterialPageRoute(
              builder: (context) => SavingPlanForm(),
            ),
          );
        },
      );
    },
  );
}
