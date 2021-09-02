import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';

  RegisterScreen({Key? key}) : super(key: key);

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
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
                  controller: emailTextController,
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
                    prefixIcon: Icon(Icons.person),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Last Name",
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
                  controller: passwordTextController,
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
                    if (password!.length < 8) {
                      return "Password too short";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 80.0),
                GestureDetector(
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
                    print("all went well");
                    // print("email:: $email  pass:: $pass");
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}