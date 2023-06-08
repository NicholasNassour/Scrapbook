import 'package:flutter/material.dart';
import 'package:flutter_application_1/SignUp.dart';
// import 'package:flutter_application_1/newPage.dart';
import 'package:flutter_application_1/src/navpages/main_page.dart';
// import 'package:flutter/services.dart';
import 'dart:core';
import 'package:flutter_application_1/authentication.dart';
// import "home3.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
// import 'newPage.dart';

//Create more messages when an email is not found/password is incorrect etc

//When a successful login is stored, store the user and pass using the
//flutter secture storage and create a method which will automatically
//input the info again when the app is opened using through initstate

//Create a goal page in mind to stop getting sidetracked on different projects
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SizedBox(height: 80),
          // logo
          Column(
            children: [
              Image.asset('assets/images/scrapbook.png',
                  height: 200, width: 200),
              SizedBox(height: 50),
              Text(
                'Welcome back!',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),

          SizedBox(
            height: 50,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(),
          ),

          SizedBox(height: 20),

          Row(
            children: <Widget>[
              SizedBox(width: 30),
              Text('New here? ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              InkWell(
                child: Text('Create account',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 32, 155, 255))),
                onTap: () {
                  // Navigator.pushNamed(context, '/signup');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

  String? email;
  String? password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          Container(
            width: 376,
            height: 54,
            child: TextFormField(
              // initialValue: 'Input text',
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(10),
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a email';
                }
                return null;
              },
              onSaved: (val) {
                email = val;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),

          // password
          Container(
            width: 376,
            height: 54,
            child: TextFormField(
              // initialValue: 'Input text',
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(10),
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              obscureText: _obscureText,
              onSaved: (val) {
                password = val;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a password';
                }
                return null;
              },
            ),
          ),

          SizedBox(height: 30),

          SizedBox(
            height: 54,
            width: 184,
            child: ElevatedButton(
              onPressed: () {
                // Respond to button press

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  AuthenticationHelper()
                      .signIn(email: email!, password: password!)
                      .then((result) {
                    if (result == null) {
                      // Below is the code for logging in with a token
                      //await storage.write(key: "token", value: output["token"]);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 23, 103, 168),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)))),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
