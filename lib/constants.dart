import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
const String google_api_key = "insert_google_maps_api_key";
Map<String, String> countryFlagMap = {
  'Brazil': 'assets/images/badges/1.png',
  'Syria': 'assets/images/badges/2.png',
  'United States': 'assets/images/badges/3.png',
  'Philippines': 'assets/images/badges/4.png'
};
