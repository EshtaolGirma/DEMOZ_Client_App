import 'package:demoz_client/auth/profile/bloc/profile_bloc.dart';
import 'package:demoz_client/auth/profile/bloc/profile_event.dart';
import 'package:demoz_client/auth/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: const Color(0xff66ffc7),
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(80.0), // here the desired height
        //   child: CustomAppBar(),
        // ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              print(state);
              if (state is LoadingProfile) {
                final bloc = BlocProvider.of<ProfileBloc>(context);
                bloc.add(LoadProfileEvent(email: 'email'));
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else {
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
                          child: TextButton(
                            onPressed: () {},
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
                            initialValue: "Fullname",
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
                              return null;
                            },
                          ),
                        ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        Container(
                          margin: EdgeInsets.all(7),
                          child: TextFormField(
                            enabled: false,
                            initialValue: "Email",
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              labelText: "Email",
                              // suffixIcon: Icon(Icons.edit),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (!value!.contains('@')) {
                                return "Invalid email";
                              }
                              return null;
                            },
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(7),
                          child: TextFormField(
                            enabled: false,
                            initialValue: "Password",
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
                                return "This Field Is Required";
                              }
                              if (value.length < 8) {
                                return "Password Length Too Short";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(7),
                          child: TextFormField(
                            enabled: false,
                            initialValue: "Encome",
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.money),
                              labelText: "Encome",
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
                            initialValue: "Expense",
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
                        // Expanded(child: SizedBox()),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20.0,
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'LOG OUT',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                      padding:
                                          EdgeInsets.fromLTRB(50, 30, 50, 30)),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'DELETE',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      padding:
                                          EdgeInsets.fromLTRB(50, 30, 50, 30)),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
