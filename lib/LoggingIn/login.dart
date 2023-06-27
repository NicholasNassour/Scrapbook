import 'package:flutter/material.dart';
import '../LoggingIn/SignUp.dart';
import '../src/navpages/main_page.dart';
import '../constants.dart';
import '../authentication.dart';
import 'dart:core';
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import 'package:shared_preferences/shared_preferences.dart';

//Create more messages when an email is not found/password is incorrect etc

//When a successful login is stored, store the user and pass using the
//flutter secture storage and create a method which will automatically
//input the info again when the app is opened using through initstate

//Create a goal page in mind to stop getting sidetracked on different projects
class Login extends StatelessWidget {
  static String id = '1';
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          const SizedBox(height: 80),
          // logo
          Column(
            children: [
              Image.asset('assets/images/scrapbook.png',
                  height: 200, width: 200),
              const SizedBox(height: 50),
              const Text(
                'Welcome back!',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),

          const SizedBox(
            height: 50,
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginForm(),
          ),

          const SizedBox(height: 20),

          Row(
            children: <Widget>[
              const SizedBox(width: 30),
              const Text('New here? ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              InkWell(
                child: const Text('Create account',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 32, 155, 255))),
                onTap: () {
                  // Navigator.pushNamed(context, '/signup');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Signup()));
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
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String? email;
  String? password;
  // late Future<String> _x;
  // late Future<int> _counter;

  bool _obscureText = true;
  bool _isChecked = false;

  // _onFormSubmit saves data after the app is closed
  _onFormSubmit(String email) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('Check', true);
  }

  _signIn() async {
    AuthenticationHelper()
        .signIn(email: email!, password: password!)
        .then((result) {
      if (result == null) {
        if (!(auth.currentUser!.emailVerified)) {
          print("this user ain't verified idk why he's signed in");
          AuthenticationHelper().checkVerification(context);
        } else {
          if (_isChecked) {
            _onFormSubmit(email!);
          }
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: const TextStyle(fontSize: 16),
          ),
        ));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    //Update  on form submit here
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email text field
          SizedBox(
            width: 376,
            height: 54,
            child: TextFormField(
              // initialValue: 'Input text',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
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
          const SizedBox(
            height: 20,
          ),

          // password text field
          SizedBox(
            width: 376,
            height: 54,
            child: TextFormField(
              // initialValue: 'Input text',
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
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

          const SizedBox(height: 10),

          // Stay signed in Checkbox
          Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              const Flexible(
                child: Text(
                  'Stay signed in?',
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          // Login button
          SizedBox(
            height: 54,
            width: 184,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _signIn();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 23, 103, 168),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)))),
              child: const Text(
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
