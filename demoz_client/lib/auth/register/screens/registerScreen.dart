import 'package:demoz_client/auth/register/bloc/register_bloc.dart';
import 'package:demoz_client/auth/register/bloc/register_event.dart';
import 'package:demoz_client/auth/register/bloc/register_state.dart';
import 'package:demoz_client/expense/screens/expense_summery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';

  RegisterScreen({Key? key}) : super(key: key);

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final fnameTextController = TextEditingController();
  final lnameTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<RegisterBloc, AuthState>(
          listener: (context, state) {
            if (state is Registered) {
              Navigator.of(context).pushNamed(ExpenseSummeryScreen.routeName);
            }
          },
          builder: (context, state) {
            return Center(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        controller: fnameTextController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "First Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        validator: (String? fname) {
                          if (fname!.isEmpty) {
                            return "Enter Name";
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        controller: lnameTextController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Last Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        validator: (String? lname) {
                          if (lname!.isEmpty) {
                            return "Enter Last Name";
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        controller: emailTextController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
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
                      SizedBox(height: 25.0),
                      TextFormField(
                        obscureText: true,
                        controller: passwordTextController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
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
                      SizedBox(height: 25.0),
                      TextFormField(
                        obscureText: true,
                        controller: confirmPasswordTextController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        validator: (String? password) {
                          if (password != passwordTextController.text) {
                            return "Password Doesn't Match";
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 80.0),
                      BlocConsumer<RegisterBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthFailed) {
                            final msg = state.errorMsg;
                            final snackBar = SnackBar(
                              content: Text(msg),
                              duration: Duration(
                                seconds: 5,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          if (state is Registered) {
                            final snackBar = SnackBar(
                              content: Text("Registered Successfully"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 5),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterInprogress) {
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
                              }

                              final email = emailTextController.text;
                              final pass = passwordTextController.text;
                              final confirmPass =
                                  confirmPasswordTextController.text;
                              final fname = fnameTextController.text;
                              final lname = lnameTextController.text;

                              final registerBloc =
                                  BlocProvider.of<RegisterBloc>(context);
                              registerBloc.add(RegisterEvent(
                                  email: email,
                                  password: pass,
                                  confirmPassword: confirmPass,
                                  fname: fname,
                                  lname: lname));
                              print("all went well");
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
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
