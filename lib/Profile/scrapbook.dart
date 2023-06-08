import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String userUid;
  String? name;
  Map badges;

  Book({required this.userUid, this.name, this.badges = const {}});

  void createScrapbook(String userUid) {
    CollectionReference scrapbookCollection =
        FirebaseFirestore.instance.collection('Scrapbook');

    DocumentReference scrapbookDocRef = scrapbookCollection.doc(userUid);

    scrapbookDocRef.set({
      'name': '',
      'badges': {},
    }).then((_) {
      print('Scrapbook created with ID: $userUid');
      // You can perform further actions here, such as navigation or showing a success message
    }).catchError((error) {
      print('Failed to create scrapbook: $error');
      // Handle the error appropriately, such as showing an error message to the user
    });
  }
}
