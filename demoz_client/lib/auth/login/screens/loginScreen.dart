import 'package:demoz_client/auth/login/bloc/login_bloc.dart';
import 'package:demoz_client/auth/login/bloc/login_event.dart';
import 'package:demoz_client/auth/login/bloc/login_state.dart';
import 'package:demoz_client/auth/register/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  LoginScreen({Key? key}) : super(key: key);

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Demoz',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  controller: emailTextController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  validator: (String? email) {
                    if (!email!.contains('@')) {
                      return "Invalid email";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  obscureText: true,
                  controller: passwordTextController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  validator: (String? password) {
                    if (password!.length < 8) {
                      return "Password too short";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 120.0),
                BlocConsumer<LoginBloc, AuthState>(
                  listener: (context, state) {
                    if (state is LoggedIn) {
                      // Navigator.of(context).pushNamed('routeName');
                    }
                    if (state is AuthFailed) {
                      final msg = state.errorMsg;
                      final snackBar = SnackBar(
                        content: Text(msg),
                        duration: Duration(
                          seconds: 5,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginInprogress) {
                      return CircularProgressIndicator();
                    }

                    return GestureDetector(
                      onTap: () {
                        // run validations.
                        // form access.
                        final valid = formKey.currentState!.validate();
                        if (!valid) {
                          // do something here.
                          print("something failed");
                          return;
                        } //ii

                        final email = emailTextController.text;
                        final pass = passwordTextController.text;
                        print("all went well");
                        final loginBloc = BlocProvider.of<LoginBloc>(context);
                        loginBloc.add(LoginEvent(email: email, password: pass));
                        // print("email::   pass:: ");
                      },
                      child: Container(
                        height: 60.0,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15.0),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: Text(
                      "Don't have an account",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
