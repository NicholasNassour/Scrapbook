import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Book {
  String userUid;
  String? name;
  List<Badge> badges;

  Book({required this.userUid, this.name, this.badges = const []});

  // Creating a Scrapbook linked to the users UID
  void createScrapbook(String userUid) {
    // Get a reference to the Firestore collection
    CollectionReference scrapbookCollection =
        FirebaseFirestore.instance.collection('Scrapbook');

    DocumentReference scrapbookDocRef = scrapbookCollection.doc(userUid);

    // Create a new scrapbook with an empty name until the user sets the name
    scrapbookDocRef.set({
      'uid': userUid,
      'name': '',
      'countries': badges,
    }).then((_) {
      print('Scrapbook created with ID: $userUid');
      // You can perform further actions here, such as navigation or showing a success message
    }).catchError((error) {
      print('Failed to create scrapbook: $error');
      // Handle the error appropriately, such as showing an error message to the user
    });
  }
}
