import 'package:flutter/material.dart';
import '../authentication.dart';
import '../constants.dart';
import '../Profile/users.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const SizedBox(height: 80),
          // logo (update when polishing app)
          const Column(
            children: [
              FlutterLogo(
                size: 55,
              ),
            ],
          ),
          const SizedBox(height: 50),
          const Center(
            child: Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SignupForm(),
          ),
          //Foo
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text('Already have an account? ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Log in Now!',
                        style: TextStyle(fontSize: 20, color: Colors.blue)),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? name;
  bool _obscureText = false;
  bool _obscureconfirm = false;

  bool agree = false;

  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    );

    var space = const SizedBox(height: 10);
    return Container(
        // height:300,
        width: 700,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 1)),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // email
              space,
              SizedBox(
                width: 376,
                height: 54,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    prefixIcon: const Icon(Icons.account_circle),
                    border: border,
                  ),
                  onSaved: (val) {
                    name = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 376,
                height: 54,
                child: TextFormField(
                  key: const ValueKey('emailField'), // Add key value
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      labelText: 'Email',
                      border: border),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              space,

              // password
              SizedBox(
                width: 376,
                height: 54,
                child: TextFormField(
                  key: const ValueKey('passwordField'), // Add key value
                  controller: pass,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: border,
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
                  onSaved: (val) {
                    password = val;
                  },
                  obscureText: !_obscureText,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              space,
              // confirm password
              SizedBox(
                width: 376,
                height: 54,
                child: TextFormField(
                  key: const ValueKey('confirmPasswordField'), // Add key value
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: border,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureconfirm = !_obscureconfirm;
                        });
                      },
                      icon: Icon(
                        _obscureconfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: !_obscureconfirm,
                  validator: (value) {
                    if (value != pass.text) {
                      return 'password not match';
                    }
                    return null;
                  },
                ),
              ),
              // name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    key: const ValueKey('termsCheckbox'), // Add key value
                    onChanged: (_) {
                      setState(() {
                        agree = !agree;
                      });
                    },
                    value: agree,
                  ),
                  const Flexible(
                    child: Text(
                        'By creating an account, I agree to Terms & Conditions and Privacy Policy.'),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              // signUP button
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 54,
                  width: 376,
                  child: ElevatedButton(
                    key: const ValueKey('signUpButton'), // Add key value
                    // When the Sign Up button is pressed check if values in the formKey exist
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        //Use Firebase to sign up a user with their given email and password
                        AuthenticationHelper()
                            .signUp(email: email!, password: password!)
                            .then((result) {
                          if (result == null) {
                            if (auth.currentUser != null) {
                              //If there are no errors and the user isn't null, create a profile
                              //with their uid, name, and email
                              String uid = AuthenticationHelper().user.uid;
                              Profile newUser =
                                  Profile(uid: uid, name: name!, email: email!);
                              newUser.createUser(uid, name, email);

                              //Sends a verification link to the email provided
                              //See authentication.dart for more
                              AuthenticationHelper().checkVerification(context);
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
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)))),
                    child: const Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
