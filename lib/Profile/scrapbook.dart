import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String userUid;
  String? name;
  Map badges;

  Book({required this.userUid, this.name, this.badges = const {}});

  void createScrapbook(String? userUid) {
    CollectionReference Scrapbook =
        FirebaseFirestore.instance.collection('Scrapbook');

    Scrapbook.add({
      'uid': userUid,
      'name': "",
      'badges': "",
    }).then((DocumentReference documentRef) {
      print('User created with ID: ${documentRef.id}');
      // You can perform further actions here, such as navigation or showing a success message
    }).catchError((error) {
      print('Failed to create user: $error');
      // Handle the error appropriately, such as showing an error message to the user
    });
  }
}
