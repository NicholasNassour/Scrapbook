import 'package:flutter/material.dart';
import 'home.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);
  @override
  NewPageState createState() => NewPageState();
}

class NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
      ),
      body: const Home1(),
    );
  }
}
