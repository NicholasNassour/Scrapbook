import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/src/navpages/main_page.dart';
import 'login.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter auth Demo',
      home: Login(),
    );
  }
}
