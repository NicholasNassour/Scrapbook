import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Profile/scrapbook.dart';

class Profile {
  String name;
  String email;
  String uid;

  Profile({required this.uid, required this.name, required this.email});

  // Creating a user profile with a unique UID linked to their email
  void createUser(String? uid, String? name, String? email) {
    // Get a reference to the Firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Create a new user document with the name and email fields
    users.add({
      'uid': uid,
      'name': name,
      'email': email,
      'prevLocations': [],
    }).then((DocumentReference documentRef) {
      print('User created with ID: ${documentRef.id}');
      // You can perform further actions here, such as navigation or showing a success message
    }).catchError((error) {
      print('Failed to create user: $error');
      // Handle the error appropriately, such as showing an error message to the user
    });

    Book userBook = Book(userUid: uid!);
    userBook.createScrapbook(uid);
  }
}
