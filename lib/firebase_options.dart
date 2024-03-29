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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAeJvuIqyPxNt-uk21N8pgy-WJdqw1H_6U',
    appId: '1:268563778173:web:e1515737eaba0ecf69ff14',
    messagingSenderId: '268563778173',
    projectId: 'todoexample-27e7f',
    authDomain: 'todoexample-27e7f.firebaseapp.com',
    databaseURL: 'https://todoexample-27e7f-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'todoexample-27e7f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUoHQOeq_hzISxM9YxDi1ckNIeedUxs6U',
    appId: '1:268563778173:android:795f10f66094add569ff14',
    messagingSenderId: '268563778173',
    projectId: 'todoexample-27e7f',
    databaseURL: 'https://todoexample-27e7f-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'todoexample-27e7f.appspot.com',
  );
}
