import 'package:demoz_client/auth/login/bloc/login_bloc.dart';
import 'package:demoz_client/auth/login/screens/loginScreen.dart';
import 'package:demoz_client/auth/register/bloc/register_bloc.dart';
import 'package:demoz_client/auth/register/screens/registerScreen.dart';
import 'package:demoz_client/expense/screens/expense_detail_screen.dart';
import 'package:demoz_client/saving/bloc/saving_bloc.dart';
import 'package:demoz_client/saving/bloc/saving_state.dart';
import 'package:demoz_client/saving/data_provider/saving_data.dart';
import 'package:demoz_client/saving/repository/saving_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'expense/screens/expense_summery_screen.dart';
import 'saving/screens/saving_details_screen.dart';
import 'saving/screens/saving_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SavingRepository savingRepository =
      SavingRepository(savingDataProvider: SavingDataProvider(http.Client()));
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => LoginBloc()),
        BlocProvider(create: (ctx) => RegisterBloc()),
        BlocProvider(
            create: (ctx) => SavingBloc(SavingUnloaded(), savingRepository))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/saving',
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xff66ffc7)),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => ExpenseSummeryScreen(),
          '/expense_detial': (context) => ExpenesDetailScreen(),
          '/saving': (context) => SavingScreen(),
          '/saving_detail': (context) => SavingDetailScreen(),
          // '/profilePage': (context) => ProfileScreen(),
        },
      ),
    );
  }
}
