import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/src/navpages/photo_album.dart';
import '../../authentication.dart';
import '../../constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool sortByAlphabet = false; // Track the sorting order

  //Return the badges the current user has collected
  Future<List<dynamic>> currUser() async {
    String uid = AuthenticationHelper().user.uid;

    // Reference the collection 'Scrapbook' in Firebase for a given user uid
    CollectionReference scrapbookCollection =
        FirebaseFirestore.instance.collection('Scrapbook');
    DocumentReference scrapbookDocRef = scrapbookCollection.doc(uid);
    DocumentSnapshot snapshot = await scrapbookDocRef.get();

    //Retrieve the countries visited from the 'badges' array
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    List<dynamic> badges = data['badges'] ?? [];
    print(badges);
    return badges;
  }

  //Sort the order of the badges
  void toggleSortOrder() {
    setState(() {
      sortByAlphabet = !sortByAlphabet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: currUser(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<dynamic> badges = snapshot.data ?? [];

        // Sort the badges list based on the sorting order
        if (sortByAlphabet) {
          badges.sort();
        } else {
          // Sort by the order they were obtained
          badges.sort((a, b) => badges.indexOf(a).compareTo(badges.indexOf(b)));
        }

        return Scaffold(
          //App bar with a button to sort badges in alphabetical order or
          //by the order they were obtained in
          appBar: AppBar(
            title: const Text('Badge List'),
            actions: [
              IconButton(
                onPressed: toggleSortOrder,
                icon: Icon(
                  sortByAlphabet ? Icons.sort_by_alpha : Icons.access_time,
                ),
              ),
            ],
          ),
          //Grid of badges that are collected
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns per row
            ),
            itemCount: badges.length,
            itemBuilder: (BuildContext context, int index) {
              String badge = badges[index];
              String flagImagePath = countryFlagMap[badge] ?? '';

              return GridTile(
                child: InkWell(
                  // Go to album page when a badge is tapped
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Photos(badge: badge),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2.0),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(flagImagePath),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        badge,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
