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
    apiKey: 'AIzaSyC4vl0DJrf2rmk6PNDv6XuQsrFR1FmIMI4',
    appId: '1:573642381199:web:84b9f550b425fcd6281dfa',
    messagingSenderId: '573642381199',
    projectId: 'smart-mirror-5467c',
    authDomain: 'smart-mirror-5467c.firebaseapp.com',
    databaseURL: 'https://smart-mirror-5467c-default-rtdb.firebaseio.com',
    storageBucket: 'smart-mirror-5467c.appspot.com',
    measurementId: 'G-BT1P1CKRDJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEC3JJ5ctXDox60K4fDPxIbbHb65DH2AQ',
    appId: '1:573642381199:android:edacd4c4c1a7d4af281dfa',
    messagingSenderId: '573642381199',
    projectId: 'smart-mirror-5467c',
    databaseURL: 'https://smart-mirror-5467c-default-rtdb.firebaseio.com',
    storageBucket: 'smart-mirror-5467c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJfOzNLAbjuSHNBZ82hdEyOiUxp5TnUKY',
    appId: '1:573642381199:ios:15db13606f27fa59281dfa',
    messagingSenderId: '573642381199',
    projectId: 'smart-mirror-5467c',
    databaseURL: 'https://smart-mirror-5467c-default-rtdb.firebaseio.com',
    storageBucket: 'smart-mirror-5467c.appspot.com',
    iosClientId: '573642381199-rjmflgkel1il7ctupnoqt5pvapf0sjal.apps.googleusercontent.com',
    iosBundleId: 'com.example.theMirror',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJfOzNLAbjuSHNBZ82hdEyOiUxp5TnUKY',
    appId: '1:573642381199:ios:15db13606f27fa59281dfa',
    messagingSenderId: '573642381199',
    projectId: 'smart-mirror-5467c',
    databaseURL: 'https://smart-mirror-5467c-default-rtdb.firebaseio.com',
    storageBucket: 'smart-mirror-5467c.appspot.com',
    iosClientId: '573642381199-rjmflgkel1il7ctupnoqt5pvapf0sjal.apps.googleusercontent.com',
    iosBundleId: 'com.example.theMirror',
  );
}