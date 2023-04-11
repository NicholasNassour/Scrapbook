// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBsmTHR7JJry8x0jYgD0u8_xTjeDDiTEX4',
    appId: '1:779783460629:web:ea702cf226f735d5d43b1c',
    messagingSenderId: '779783460629',
    projectId: 'scrapbook-4cdbc',
    authDomain: 'scrapbook-4cdbc.firebaseapp.com',
    storageBucket: 'scrapbook-4cdbc.appspot.com',
    measurementId: 'G-677L8N9TZ6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCznm6wXGQXuSuR5CT-EzSVFU15irlHhPE',
    appId: '1:779783460629:android:0fcbbe4a4c0e9c9dd43b1c',
    messagingSenderId: '779783460629',
    projectId: 'scrapbook-4cdbc',
    storageBucket: 'scrapbook-4cdbc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbpl3Nmr8wsctzGQ4Havs5ZXVJ0js2qpo',
    appId: '1:779783460629:ios:5b9323034d3d6761d43b1c',
    messagingSenderId: '779783460629',
    projectId: 'scrapbook-4cdbc',
    storageBucket: 'scrapbook-4cdbc.appspot.com',
    iosClientId: '779783460629-2q4ve3gpadarc0ha6dukdpa8e040c7r9.apps.googleusercontent.com',
    iosBundleId: 'com.example.testing',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDbpl3Nmr8wsctzGQ4Havs5ZXVJ0js2qpo',
    appId: '1:779783460629:ios:5b9323034d3d6761d43b1c',
    messagingSenderId: '779783460629',
    projectId: 'scrapbook-4cdbc',
    storageBucket: 'scrapbook-4cdbc.appspot.com',
    iosClientId: '779783460629-2q4ve3gpadarc0ha6dukdpa8e040c7r9.apps.googleusercontent.com',
    iosBundleId: 'com.example.testing',
  );
}
