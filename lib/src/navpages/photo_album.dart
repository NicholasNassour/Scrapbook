import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../constants.dart';
import '../../Authentication.dart';

class Photos extends StatefulWidget {
  final String badge;

  const Photos({Key? key, required this.badge}) : super(key: key);

  @override
  PhotosPage createState() => PhotosPage();
}

class PhotosPage extends State<Photos> {
  // Store the selected picture
  PlatformFile? pickedFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });

    String downloadURL = await uploadFile(pickedFile!.path!);
    print('we\'re working with badge: ${widget.badge}');
    print('Download URL: $downloadURL');
  }

  uploadFile(String filePath) async {
    // Get the current user
    if (auth.currentUser != null) {
      // Generate a unique file name for the uploaded file
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      CollectionReference scrapbookCollection =
          FirebaseFirestore.instance.collection('Scrapbook');

      // Get the reference to the user's folder in Firebase Storage
      Reference storageRef = storage.ref().child(
          'users/${auth.currentUser?.uid}/files/${widget.badge}/$fileName');
      print(
          "The photo was added to 'users/${auth.currentUser?.uid}/files/${widget.badge}/$fileName'");

      // Upload the file to Firebase Storage
      storageRef.putFile(File(filePath));
    } else {
      throw Exception('User not authenticated.');
    }
  }

  Future<List<String>> getPhotoURLs() async {
    // Get the reference to the user's folder in Firebase Storage
    Reference storageRef = storage
        .ref()
        .child('users/${auth.currentUser?.uid}/files/${widget.badge}');

    // List all the items (photos) in the folder
    final ListResult result = await storageRef.listAll();

    // Get the download URLs of the items (photos)
    List<String> photoURLs =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

    return photoURLs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.badge),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: selectFile,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: getPhotoURLs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<String> photoURLs = snapshot.data ?? [];

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 1,
              ),
              itemCount: photoURLs.length,
              itemBuilder: (BuildContext context, int index) {
                String photoURL = photoURLs[index];

                return Image.network(
                  photoURL,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            );
          }
        },
      ),
    );
  }
}
