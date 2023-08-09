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
    apiKey: 'AIzaSyDfuw8wJ0g3fAkOUm_TbwHBhp8d1MbhF7I',
    appId: '1:574732087732:web:d51f97e486c7ff15b382e1',
    messagingSenderId: '574732087732',
    projectId: 'acelerador-de-ecommerce',
    authDomain: 'acelerador-de-ecommerce.firebaseapp.com',
    databaseURL: 'https://acelerador-de-ecommerce-default-rtdb.firebaseio.com',
    storageBucket: 'acelerador-de-ecommerce.appspot.com',
    measurementId: 'G-D1LTCGMW6J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0HISiGyia9QpcBzw_0J2xosbk9G1PAIU',
    appId: '1:574732087732:android:6a458bd76b3ed503b382e1',
    messagingSenderId: '574732087732',
    projectId: 'acelerador-de-ecommerce',
    databaseURL: 'https://acelerador-de-ecommerce-default-rtdb.firebaseio.com',
    storageBucket: 'acelerador-de-ecommerce.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2ISMTCSlleyosgi13La7P9TRaX8IpV-0',
    appId: '1:574732087732:ios:9e18e1ba2a898aa7b382e1',
    messagingSenderId: '574732087732',
    projectId: 'acelerador-de-ecommerce',
    databaseURL: 'https://acelerador-de-ecommerce-default-rtdb.firebaseio.com',
    storageBucket: 'acelerador-de-ecommerce.appspot.com',
    androidClientId: '574732087732-3rqnt3thfjsp59cgu96r647rqfmujqfb.apps.googleusercontent.com',
    iosClientId: '574732087732-a0q8e6gfbtunhp36k2bcvv2af1d9v96l.apps.googleusercontent.com',
    iosBundleId: 'br.com.aceleradordeecommerce.duraes',
  );
}
