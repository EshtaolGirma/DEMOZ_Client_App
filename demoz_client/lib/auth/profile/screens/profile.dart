import 'package:demoz_client/auth/login/screens/loginScreen.dart';
import 'package:demoz_client/auth/profile/bloc/profile_bloc.dart';
import 'package:demoz_client/auth/profile/bloc/profile_event.dart';
import 'package:demoz_client/auth/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  late String fullname_value;
  late String password_value;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: const Color(0xff66ffc7),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is LoggedOut) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<ProfileBloc>(context);
            if (state is LoadedState) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: FaIcon(
                        FontAwesomeIcons.userCircle,
                        color: Colors.black,
                        size: 125,
                      ),
                      // radius: 58.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          bloc.add(EditProfile());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Edit Page",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        enabled: false,
                        initialValue: state.user[0].full_name,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.person),
                          labelText: "Fullname",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      child: TextFormField(
                        enabled: false,
                        initialValue: state.user[0].email,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      child: TextFormField(
                        enabled: false,
                        // initialValue: ,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.lock_outlined),
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      child: TextFormField(
                        enabled: false,
                        initialValue: "${state.user[0].income}",
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.money),
                          labelText: "Income",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      child: TextFormField(
                        enabled: false,
                        initialValue: "${state.user[0].expense}",
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.money_off),
                          labelText: "Expense",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {
                                bloc.add(LoggingOut());
                              },
                              child: Text(
                                'LOG OUT',
                                style: TextStyle(fontSize: 15),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  padding: EdgeInsets.all(20.0)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'DELETE Account',
                                style: TextStyle(fontSize: 10),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                padding: EdgeInsets.all(20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is EditinState) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: FaIcon(
                          FontAwesomeIcons.userCircle,
                          color: Colors.black,
                          size: 125,
                        ),
                        // radius: 58.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: state.user[0].full_name,
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                            labelText: "Fullname",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This Field Is Required";
                            }
                            fullname_value = value;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(7),
                        child: TextFormField(
                          initialValue: state.user[0].email,
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(7),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.lock_outlined),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              password_value = '';
                            }
                            if (value.length < 8) {
                              return "Password Length Too Short";
                            }
                            password_value = value;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(7),
                        child: TextFormField(
                          initialValue: "${state.user[0].income}",
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.money),
                            labelText: "Income",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(7),
                        child: TextFormField(
                          initialValue: "${state.user[0].expense}",
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.money_off),
                            labelText: "Expense",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    bloc.add(SaveProfile(
                                        full_name: fullname_value,
                                        pass: password_value));
                                  }
                                },
                                child: Text(
                                  'SAVE',
                                  style: TextStyle(fontSize: 15),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                    padding: EdgeInsets.all(20.0)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: () {
                                  bloc.add(LoadProfileEvent());
                                },
                                child: Text(
                                  'CANCEL',
                                  style: TextStyle(fontSize: 10),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  padding: EdgeInsets.all(20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            bloc.add(LoadProfileEvent());
            return Container(
              color: Colors.pink,
              width: 200,
              height: 200,
            );
          },
        ));
  }
}
