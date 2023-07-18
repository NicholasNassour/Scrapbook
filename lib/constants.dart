import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;
const String google_api_key = "insert_google_maps_api_key";

//Example country badges linked to their respective flags
Map<String, String> countryFlagMap = {
  'Brazil': 'assets/images/badges/1.png',
  'Syria': 'assets/images/badges/2.png',
  'United States': 'assets/images/badges/3.png',
  'Philippines': 'assets/images/badges/4.png',
  'Japan': 'assets/images/badges/5.png',
  'China': 'assets/images/badges/6.png',
};
