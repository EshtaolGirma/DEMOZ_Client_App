import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      // bottomBar,
      backgroundColor: Color.fromRGBO(117, 243, 197, 1),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 00, 0),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            FaIcon(
              FontAwesomeIcons.userCircle,
              color: Colors.black,
              size: 50,
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "First Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "\$1200",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFooterBar extends StatelessWidget {
  const CustomFooterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        color: Color.fromRGBO(117, 243, 197, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.wallet),
            onPressed: () {
              print("Pressed");
            },
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.piggyBank,
            ),
            onPressed: () {
              print("Pressed");
            },
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.plusSquare,
              size: 35,
            ),
            onPressed: () {
              print("Pressed");
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.commentsDollar),
            onPressed: () {
              print("Pressed");
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
            onPressed: () {
              print("Pressed");
            },
          ),
        ],
      ),
    );
  }
}
