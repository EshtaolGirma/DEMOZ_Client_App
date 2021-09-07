import 'package:demoz_client/auth/login/bloc/login_bloc.dart';
import 'package:demoz_client/auth/login/screens/loginScreen.dart';
import 'package:demoz_client/auth/register/bloc/register_bloc.dart';
import 'package:demoz_client/auth/register/screens/registerScreen.dart';
import 'package:demoz_client/expense/screens/expense_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expense/screens/expense_summery_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => LoginBloc()),
        BlocProvider(create: (ctx) => RegisterBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xff66ffc7)),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => ExpenseSummeryScreen(),
          '/expense_detial': (context) => ExpenesDetailScreen(),
        },
      ),
    );
  }
}
