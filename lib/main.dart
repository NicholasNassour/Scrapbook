import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/home3.dart';
import 'package:flutter_application_1/src/navpages/main_page.dart';
import 'login.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBsmTHR7JJry8x0jYgD0u8_xTjeDDiTEX4",
        authDomain: "scrapbook-4cdbc.firebaseapp.com",
        projectId: "scrapbook-4cdbc",
        storageBucket: "scrapbook-4cdbc.appspot.com",
        messagingSenderId: "779783460629",
        appId: "1:779783460629:web:ea702cf226f735d5d43b1c",
        measurementId: "G-677L8N9TZ6"),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        print(user.email);
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// check if user is signed (Open Chat page) if user is not signed in (open Login page)
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? Login.id : MainPage.id,

      ///key value pair
      routes: {
        MainPage.id: (context) => MainPage(),
        Login.id: (context) => Login(),
      },
      home: MainPage(),
    );
  }
}





// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter auth Demo',
//       home: Login(),
//     );
//   }
// }
