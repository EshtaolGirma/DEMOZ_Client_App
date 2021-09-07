// import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class SavingScreen extends StatelessWidget {
  const SavingScreen({Key? key}) : super(key: key);

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
              _savingListBuilder(),
              _savingPlanAddButtonBuilder(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomFooterBar(),
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

Widget _savingListBuilder() {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext cxt, index) {
        return _savingPlanCardBuilder();
      });
}

Widget _savingPlanCardBuilder() {
  return Container(
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
                "School Fee Saving",
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
                    "220",
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
                    "220",
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
  );
}

Widget _savingPlanAddButtonBuilder() {
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
    onTap: () {},
  );
}
