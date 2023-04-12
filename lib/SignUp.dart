import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication.dart';
import 'package:flutter_application_1/newPage.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(height: 80),
          // logo
          Column(
            children: [
              FlutterLogo(
                size: 55,
              ),
            ],
          ),
          SizedBox(height: 50),
          Center(
            child: Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignupForm(),
          ),

          //Expanded(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Already have an account? ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text('Log in Now!',
                        style: TextStyle(fontSize: 20, color: Colors.blue)),
                  ),
                ],
              )
            ],
          ),
          //,
        ],
      ),
    );
  }

  Container buildLogo() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      child: Center(
        child: Text(
          "T",
          style: TextStyle(color: Colors.white, fontSize: 60.0),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);

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

  final pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    var space = SizedBox(height: 10);
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
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 376,
                height: 54,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
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
              Container(
                width: 376,
                height: 54,
                child: TextFormField(
                  controller: pass,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
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
              Container(
                width: 376,
                height: 54,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock_outline),
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
              space,
              // name
              Container(
                width: 376,
                height: 54,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    prefixIcon: Icon(Icons.account_circle),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    onChanged: (_) {
                      setState(() {
                        agree = !agree;
                      });
                    },
                    value: agree,
                  ),
                  Flexible(
                    child: Text(
                        'By creating an account, I agree to Terms & Conditions and Privacy Policy.'),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              // signUP button
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 54,
                  width: 376,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        AuthenticationHelper()
                            .signUp(email: email!, password: password!)
                            .then((result) {
                          if (result == null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewPage()));
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
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)))),
                    child: Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
