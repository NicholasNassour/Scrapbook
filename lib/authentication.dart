// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:async';
import 'src/navpages/main_page.dart';

class AuthenticationHelper {
  get user => auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Method to determine if an account is verified
  checkVerification(BuildContext context) {
    bool isEmailVerified = auth.currentUser!.emailVerified;
    if (isEmailVerified) return;
    auth.currentUser!.sendEmailVerification();
    verifyAcc(context);

    // Loop every three seconds to determine if email was verified
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await auth.currentUser?.reload();
      isEmailVerified = auth.currentUser!.emailVerified;

      // Check if email is verified before going to MainPage
      if (isEmailVerified) {
        // Switch to Intro page once the account is verified
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
        timer.cancel(); // Stop the timer
      }
    });
  }

  //Pop up dialog when verification occurs
  verifyAcc(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Waiting', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(), // Loading symbol
              SizedBox(
                  height:
                      16), // Add some spacing between the loading symbol and text
              Text('Please wait while we verify your email.'),
            ],
          ),
        );
      },
    );
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await auth.signOut();

    print('signout');
  }
}
