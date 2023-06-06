import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalPage extends StatefulWidget {
  const GlobalPage({Key? key}) : super(key: key);

  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  TextEditingController _scrapbookNameController = TextEditingController();

  @override
  void dispose() {
    _scrapbookNameController.dispose();
    super.dispose();
  }

  Future<void> updateScrapbookName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userUid = user.uid;

      String scrapbookName = _scrapbookNameController.text;

      CollectionReference Scrapbook =
          FirebaseFirestore.instance.collection('Scrapbook');

      print('Updating scrapbook name: $scrapbookName for UID: $userUid');
      Scrapbook.doc(userUid).update({'name': scrapbookName});
      print('Updating scrapbook name: $scrapbookName for UID: $userUid');
    } else {
      print("No user logged in");
    }
    // Implement your logic to update the scrapbook name
    // For example, you can use Firebase Firestore or a custom backend API

    // TODO: Update the scrapbook name in the database using the userUid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Global Page"),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _scrapbookNameController,
                decoration: InputDecoration(
                  hintText: 'Enter scrapbook name',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateScrapbookName,
              child: Text('Create Scrapbook'),
            ),
          ],
        ),
      ),
    );
  }
}
