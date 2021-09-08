import 'package:demoz_client/auth/login/bloc/login_bloc.dart';
import 'package:demoz_client/auth/login/screens/loginScreen.dart';
import 'package:demoz_client/auth/register/bloc/register_bloc.dart';
import 'package:demoz_client/auth/register/screens/registerScreen.dart';
import 'package:demoz_client/expense/bloc/expense_bloc.dart';
import 'package:demoz_client/expense/data_provider/expense_data.dart';
import 'package:demoz_client/expense/repository/expense_summery_repository.dart';
import 'package:demoz_client/expense/screens/expense_summery_screen.dart';
import 'package:demoz_client/saving/bloc/saving_bloc.dart';
import 'package:demoz_client/saving/bloc/saving_detail_bloc.dart';
import 'package:demoz_client/saving/bloc/saving_detail_state.dart';
import 'package:demoz_client/saving/bloc/saving_state.dart';
import 'package:demoz_client/saving/data_provider/saving_data_provider.dart';
import 'package:demoz_client/saving/repository/saving_repository.dart';
import 'package:demoz_client/saving/screens/saving_details_screen.dart';
import 'package:demoz_client/saving/screens/saving_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ExpenseRepository expenseRepository = ExpenseRepository(
      expenseDataProvider: ExpenseDataProvider(http.Client()));

  final SavingRepository savingRepository = SavingRepository(
      savingDataProvider: SavingDataProvider(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => LoginBloc()),
        BlocProvider(create: (ctx) => RegisterBloc()),
        BlocProvider(
          create: (cxt) => ExpenseBloc(expenseRepository: expenseRepository),
        ),
        BlocProvider(
            create: (cxt) =>
                ExpenseCategoryBloc(expenseRepository: expenseRepository)),
        BlocProvider(
            create: (cxt) => SavingBloc(SavingUnLoaded(), savingRepository)),
        BlocProvider(
            create: (cxt) =>
                SavingCreationBloc(SavingFormEmpty(), savingRepository)),
        BlocProvider(
            create: (cxt) =>
                SavingDetailBloc(SavingDetailUnloaded(), savingRepository))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/saving',
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xff66ffc7)),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/expense': (context) => ExpenseSummeryScreen(),
          '/saving': (context) => SavingScreen(),
          '/saving_detail': (context) => SavingDetailScreen(),
        },
      ),
    );
  }
}
