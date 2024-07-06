// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAqyNZGiXeCdZ60IGzQ-kjQr-0nUf_i-Gc',
    appId: '1:19288067060:web:ae5c3182147a7a36e647a1',
    messagingSenderId: '19288067060',
    projectId: 'hotelmanager-2b353',
    authDomain: 'hotelmanager-2b353.firebaseapp.com',
    storageBucket: 'hotelmanager-2b353.appspot.com',
    measurementId: 'G-LV101QKFP5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSNaXtfGW7k6Uffo48J50h4FIeXNh_Oe8',
    appId: '1:19288067060:android:2b9205f70e7af7f5e647a1',
    messagingSenderId: '19288067060',
    projectId: 'hotelmanager-2b353',
    storageBucket: 'hotelmanager-2b353.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHBcD7Te4BM_RfQ6BzuTXPdR9ihPnH5KE',
    appId: '1:19288067060:ios:7be6cebe0da7bca5e647a1',
    messagingSenderId: '19288067060',
    projectId: 'hotelmanager-2b353',
    storageBucket: 'hotelmanager-2b353.appspot.com',
    iosBundleId: 'com.example.bookingHotel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHBcD7Te4BM_RfQ6BzuTXPdR9ihPnH5KE',
    appId: '1:19288067060:ios:7be6cebe0da7bca5e647a1',
    messagingSenderId: '19288067060',
    projectId: 'hotelmanager-2b353',
    storageBucket: 'hotelmanager-2b353.appspot.com',
    iosBundleId: 'com.example.bookingHotel',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAqyNZGiXeCdZ60IGzQ-kjQr-0nUf_i-Gc',
    appId: '1:19288067060:web:99ad7efd0998c728e647a1',
    messagingSenderId: '19288067060',
    projectId: 'hotelmanager-2b353',
    authDomain: 'hotelmanager-2b353.firebaseapp.com',
    storageBucket: 'hotelmanager-2b353.appspot.com',
    measurementId: 'G-6TPL32CCGR',
  );

}