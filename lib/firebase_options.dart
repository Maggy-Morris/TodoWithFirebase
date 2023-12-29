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
    apiKey: 'AIzaSyBjh6_MMLmZ39WiexBj8z38p4KZBQ2rFzo',
    appId: '1:90575075138:web:5b7db1d4f5b13f2aec7adb',
    messagingSenderId: '90575075138',
    projectId: 'todo-firebase-d4f45',
    authDomain: 'todo-firebase-d4f45.firebaseapp.com',
    storageBucket: 'todo-firebase-d4f45.appspot.com',
    measurementId: 'G-T1H3KR108F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWojndohJSk9GyFfknfpJJ1uDCjcmDiwI',
    appId: '1:90575075138:android:a78cc22dde11de53ec7adb',
    messagingSenderId: '90575075138',
    projectId: 'todo-firebase-d4f45',
    storageBucket: 'todo-firebase-d4f45.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCry66QllTlIlpD1tvMGKX4DSzW4uGKou4',
    appId: '1:90575075138:ios:5249ba2edde6a415ec7adb',
    messagingSenderId: '90575075138',
    projectId: 'todo-firebase-d4f45',
    storageBucket: 'todo-firebase-d4f45.appspot.com',
    iosClientId: '90575075138-b26imhf7boufpr16gsi1bud8vomlvbrf.apps.googleusercontent.com',
    iosBundleId: 'com.example.todosssss',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCry66QllTlIlpD1tvMGKX4DSzW4uGKou4',
    appId: '1:90575075138:ios:288abf044383fc0eec7adb',
    messagingSenderId: '90575075138',
    projectId: 'todo-firebase-d4f45',
    storageBucket: 'todo-firebase-d4f45.appspot.com',
    iosClientId: '90575075138-53lrlo969vgqnvfj33189ftmcna7brk9.apps.googleusercontent.com',
    iosBundleId: 'com.example.todosssss.RunnerTests',
  );
}
