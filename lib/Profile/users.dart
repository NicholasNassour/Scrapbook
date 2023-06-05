import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String uid;

  User({required this.uid, required this.name, required this.email});

  void createUser(String? uid, String? name, String? email) {
    // Get a reference to the Firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Create a new user document with the name and email fields
    users.add({
      'uid': uid,
      'name': name,
      'email': email,
    }).then((DocumentReference documentRef) {
      print('User created with ID: ${documentRef.id}');
      // You can perform further actions here, such as navigation or showing a success message
    }).catchError((error) {
      print('Failed to create user: $error');
      // Handle the error appropriately, such as showing an error message to the user
    });
  }
}
