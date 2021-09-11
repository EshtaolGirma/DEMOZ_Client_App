import 'package:demoz_client/navigation_bar/navigation_bar.dart';
import 'package:demoz_client/transaction/bloc/transaction_bloc.dart';
import 'package:demoz_client/transaction/bloc/transaction_event.dart';
import 'package:demoz_client/transaction/bloc/transaction_state.dart';
import 'package:demoz_client/transaction/screens/transaction_form_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryScreen extends StatelessWidget {
  static const String routeName = '/category';
  const CategoryScreen({Key? key}) : super(key: key);

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // here the desired height
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          _pageTitleBuilder("Categories"),
          Container(
            height: 501,
            child: _categoryListBuilder(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: CustomFooterBar(),
    ),
  );
}

Widget _pageTitleBuilder(title) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 0.0, 0),
      child: Text(
        "$title",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _categoryCardBuilder(String name) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 2,
          color: Color.fromRGBO(117, 243, 197, 1),
        ),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget _categoryListBuilder() {
  return BlocBuilder<TransactionBloc, TransactionState>(
    builder: (context, state) {
      final transactionBloc = BlocProvider.of<TransactionBloc>(context);
      if (state is TransactionLoading) {
        return Container(
          width: double.infinity,
          height: 400,
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (state is TransactionLoaded) {
        return ListView.builder(
            itemCount: state.transactionList.length,
            itemBuilder: (BuildContext cxt, index) {
              return InkWell(
                child:
                    _categoryCardBuilder(state.transactionList[index].category),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionFormScreen(
                        id: index,
                        cat_name: state.transactionList[index].category,
                      ),
                    ),
                  );
                },
              );
            });
      }
      transactionBloc.add(TransactionLoad());
      return Container();
    },
  );
}
