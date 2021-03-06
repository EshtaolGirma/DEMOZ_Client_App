import 'package:demoz_client/auth/login/bloc/bloc.dart';
import 'package:demoz_client/auth/login/data_provider/login_data_provider.dart';
import 'package:demoz_client/auth/login/repository/login_repository.dart';
import 'package:demoz_client/auth/login/screens/loginScreen.dart';
import 'package:demoz_client/auth/profile/bloc/profile_bloc.dart';
import 'package:demoz_client/auth/profile/data_provider/profile_data.dart';
import 'package:demoz_client/auth/profile/repository/profile_repository.dart';
import 'package:demoz_client/auth/profile/screens/profile.dart';
import 'package:demoz_client/auth/register/bloc/bloc.dart';
import 'package:demoz_client/auth/register/data_provider/register_data.dart';
import 'package:demoz_client/auth/register/repository/register_repository.dart';
import 'package:demoz_client/auth/register/screens/registerScreen.dart';
import 'package:demoz_client/bills/bloc/bill_detail_bloc.dart';
import 'package:demoz_client/bills/bloc/bloc.dart';
import 'package:demoz_client/bills/data_provider/bills_data.dart';
import 'package:demoz_client/bills/repository/bills_repository.dart';
import 'package:demoz_client/expense/bloc/bloc.dart';
import 'package:demoz_client/expense/data_provider/expense_data.dart';
import 'package:demoz_client/expense/repository/expense_summery_repository.dart';
import 'package:demoz_client/expense/screens/expense_summery_screen.dart';
import 'package:demoz_client/loans/bloc/bloc.dart';
import 'package:demoz_client/loans/bloc/loans_bloc.dart';
import 'package:demoz_client/loans/data_provider/loans_data.dart';
import 'package:demoz_client/loans/repository/loans_repository.dart';
import 'package:demoz_client/loans/screens/loans_screen.dart';
import 'package:demoz_client/saving/bloc/bloc.dart';
import 'package:demoz_client/saving/data_provider/saving_data_provider.dart';
import 'package:demoz_client/saving/repository/saving_repository.dart';
import 'package:demoz_client/saving/screens/saving_screen.dart';
import 'package:demoz_client/transaction/bloc/transaction_bloc.dart';
import 'package:demoz_client/transaction/bloc/transaction_form_bloc.dart';
import 'package:demoz_client/transaction/date_provider/transaction_data.dart';
import 'package:demoz_client/transaction/repository/transaction_repository.dart';
import 'package:demoz_client/transaction/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bills/screens/bills_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginRepository loginRepository = LoginRepository(
      loginDataProvider: LoginDataProvider(httpClient: http.Client()));

  final RegisterRepository registerRepository = RegisterRepository(
      registerDataProvider: RegisterDataProvider(httpClient: http.Client()));

  final ProfileRepository profileRepository = ProfileRepository(
      profileDataProvider: ProfileDataProvider(httpClient: http.Client()));
  final ExpenseRepository expenseRepository = ExpenseRepository(
      expenseDataProvider: ExpenseDataProvider(http.Client()));

  final TransactionRepository transactionRepository = TransactionRepository(
      transactionDataProvider: TransactionDataProvider(http.Client()));

  final SavingRepository savingRepository = SavingRepository(
      savingDataProvider: SavingDataProvider(httpClient: http.Client()));

  final BillsRepository billsRepository = BillsRepository(
      billsDataProvider: BillsDataProvider(httpClient: http.Client()));
  final LoansRepository loansRepository = LoansRepository(
      loansDataProvider: LoansDataProvider(httpClient: http.Client()));
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (ctx) => LoginBloc(loginRepository: loginRepository)),
        BlocProvider(
            create: (ctx) =>
                RegisterBloc(registerRepository: registerRepository)),
        BlocProvider(
            create: (ctx) => ProfileBloc(profileRepository: profileRepository)),
        BlocProvider(
          create: (cxt) => ExpenseBloc(expenseRepository: expenseRepository),
        ),
        BlocProvider(
          create: (cxt) =>
              TransactionBloc(transactionRepository: transactionRepository),
        ),
        BlocProvider(
          create: (cxt) => TransactionDetailBloc(transactionRepository),
        ),
        BlocProvider(create: (cxt) => ExpenseDetailBloc(expenseRepository)),
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
                SavingDetailBloc(SavingDetailUnloaded(), savingRepository)),
        BlocProvider(
            create: (cxt) => BillsBloc(BillsUnloaded(), billsRepository)),
        BlocProvider(
            create: (cxt) =>
                BillDetailBloc(BillDetailUnloaded(), billsRepository)),
        BlocProvider(
            create: (cxt) =>
                BillCreationBloc(BillFormEmpty(), billsRepository)),
        BlocProvider(
            create: (cxt) => LoansBloc(LoansUnloaded(), loansRepository)),
        BlocProvider(
            create: (cxt) =>
                LoanCreationBloc(LoansFormEmpty(), loansRepository)),
        BlocProvider(
            create: (cxt) =>
                LoanDetailBloc(LoanDetailUnloaded(), loansRepository))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xff66ffc7)),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/expense': (context) => ExpenseSummeryScreen(),
          '/saving': (context) => SavingScreen(),
          '/bills': (context) => BillsScreen(),
          '/category': (context) => CategoryScreen(),
          '/loans': (context) => LoansScreen(),
          // '/transaction_form': (context) => TransactionFormScreen(),
          '/profile': (context) => ProfileScreen(),
        },
      ),
    );
  }
}
