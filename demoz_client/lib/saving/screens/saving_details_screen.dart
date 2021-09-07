import 'package:date_field/date_field.dart';
// import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SavingDetailScreen extends StatelessWidget {
  const SavingDetailScreen({Key? key}) : super(key: key);

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
      resizeToAvoidBottomInset: false,
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
                height: 25,
              ),
              _savingTitleBuilder(),
              _savingDetailBuilder(),
              SizedBox(
                height: 30,
              ),
              Center(child: _remainingDaysConuterBuilder()),
              SizedBox(
                height: 30,
              ),
              _savingPeogressBarBuilder(),
              _depsiteTitleBuilder(),
              Column(
                children: _depositsListBuilder(),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomFooterBar(),
    ),
  );
}

Widget _savingTitleBuilder() {
  return Container(
    margin: EdgeInsets.fromLTRB(22.0, 0.0, 0.0, 5.0),
    child: Text(
      "School Fee Saving",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _savingDetailBuilder() {
  return Container(
    margin: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description: ",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              width: 230,
              child: Text(
                "Saving to pay for cooking class, somethings to pay for cooking class one more word",
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Deposite of : ",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text("200"),
            Text(
              ", every: ",
            ),
            Text("30 days"),
          ],
        ),
        Row(
          children: [
            Text(
              "Starting on: ",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              width: 9,
            ),
            Text("24 August, 2020"),
          ],
        ),
        Row(
          children: [
            Text(
              "Until: ",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              width: 55,
            ),
            Text("24 August, 2021"),
          ],
        ),
      ],
    ),
  );
}

Widget _remainingDaysConuterBuilder() {
  return Container(
    width: 175,
    height: 175,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: Colors.black,
        )),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "5",
          style: TextStyle(
            fontSize: 65,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "days left",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

Widget _savingPeogressBarBuilder() {
  final total = 100;
  final currentAmount = 35;
  return Container(
    margin: EdgeInsets.fromLTRB(20, 0.0, 20, 0.0),
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = MediaQuery.of(context).size.width - 95;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 15, 0.0),
              child: StepProgressIndicator(
                totalSteps: total,
                currentStep: currentAmount,
                size: 12,
                padding: 0,
                selectedColor: Color.fromRGBO(117, 243, 197, 1),
                unselectedColor: Colors.black12,
                roundedEdges: Radius.circular(10),
              ),
            ),
            Positioned(
              right: 5,
              bottom: -20,
              child: Text("100"),
            ),
            Positioned(
              top: -20,
              left: (currentAmount * maxWidth) / total,
              child: Text('$currentAmount'),
            ),
          ],
        );
      },
    ),
    // Container(
    //   margin: EdgeInsets.fromLTRB(0.0, 0.0, 20, 0.0),
    //   child: StepProgressIndicator(
    //     totalSteps: total,
    //     currentStep: currentAmount,
    //     size: 12,
    //     padding: 0,
    //     selectedColor: Color.fromRGBO(117, 243, 197, 1),
    //     unselectedColor: Colors.black12,
    //     roundedEdges: Radius.circular(10),
    //   ),
    // ),
  );
}

Widget _depsiteTitleBuilder() {
  return Container(
    margin: EdgeInsets.fromLTRB(22.0, 40.0, 15.0, 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: [
              Text(
                "Deposits",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              _depositAddButtionBuilder(),
            ],
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          "Next deposit on 19 August, 2021",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w200,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget _depositAddButtionBuilder() {
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 7, 7, 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 18.0, 0.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
              child: FaIcon(
                FontAwesomeIcons.plus,
                size: 20,
                color: Colors.white,
              ),
            ),
            Text(
              "ADD",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
    onTap: () {},
  );
}

List<Widget> _depositsListBuilder() {
  List<Widget> list = [];
  for (var i = 0; i < 10; i++) {
    list.add(_depositCardBuilder());
  }
  return list;
}

Widget _depositCardBuilder() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 1,
        // color: Color.fromRGBO(250, 250, 250, 0.75),
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _dateDisplayBuilder(),
                    _depositeAmountDisplayBuilder(),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                      child: Text(
                        "Note: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    _descriptionDisplayBuilder(),
                  ],
                )
              ],
            )),
      ),
    ),
  );
}

Widget _dateDisplayBuilder() {
  return Container(
    width: 200,
    child: DateTimeFormField(
      dateTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      enabled: false,
      initialValue: DateTime.now(),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      mode: DateTimeFieldPickerMode.dateAndTime,
    ),
  );
}

Widget _depositeAmountDisplayBuilder() {
  return Container(
    width: 100,
    child: TextFormField(
      keyboardType: TextInputType.number,
      initialValue: '200',
      style: TextStyle(fontSize: 25),
      enabled: false,
      decoration: InputDecoration(
        hintText: "200",
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(28, 8.2, 0, 0),
          child: Text(
            "\$",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _descriptionDisplayBuilder() {
  // return Container(
  //   width: 200,
  //   child: TextFormField(
  //     maxLines: null,
  //     textAlign: TextAlign.start,
  //     enabled: false,
  //     decoration: InputDecoration(
  //       hintText: "Some note entered by user!Some note entered by user!",
  //       border: InputBorder.none,
  //     ),
  //   ),
  // );
  return Container(
    width: 250,
    child: Text(
      "Something the user writes which helps them remmeber this deposit Something the user writes which helps them remmeber this deposit",
      textAlign: TextAlign.justify,
    ),
  );
}
