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
    // Get current User to extract uid for a scrapbook
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userUid = user.uid;

      String scrapbookName = _scrapbookNameController.text;

      CollectionReference Scrapbook =
          FirebaseFirestore.instance.collection('Scrapbook');

      // Updating the name of the scrapbook based on the uid
      Scrapbook.doc(userUid).update({'name': scrapbookName});
    } else {
      print("No user logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          print("here");
          updateScrapbookName();
          return Future.delayed(const Duration(seconds: 1));
        },
        child: Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Global Page"),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: _scrapbookNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter scrapbook name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateScrapbookName,
                    child: const Text('Create Scrapbook'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
