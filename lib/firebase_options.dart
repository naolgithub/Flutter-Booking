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
    apiKey: 'AIzaSyCcDLsk61xWJ0Vr_aWflKia7HeDL0PcbAI',
    appId: '1:564546244239:web:6d6cbde0bc4ffca4a42afa',
    messagingSenderId: '564546244239',
    projectId: 'chat-with-admin-fd10f',
    authDomain: 'chat-with-admin-fd10f.firebaseapp.com',
    storageBucket: 'chat-with-admin-fd10f.appspot.com',
    measurementId: 'G-4NCPS0NLBJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmhi1UgaznvqcAgPohAOBZDqkVQ-HKwGg',
    appId: '1:564546244239:android:1ee446528e13dfdca42afa',
    messagingSenderId: '564546244239',
    projectId: 'chat-with-admin-fd10f',
    storageBucket: 'chat-with-admin-fd10f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAACrFX2S4IfxKZp1WvwhvHALG4n1fWLxM',
    appId: '1:564546244239:ios:fe695e745ba30ffaa42afa',
    messagingSenderId: '564546244239',
    projectId: 'chat-with-admin-fd10f',
    storageBucket: 'chat-with-admin-fd10f.appspot.com',
    iosBundleId: 'com.example.booking',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAACrFX2S4IfxKZp1WvwhvHALG4n1fWLxM',
    appId: '1:564546244239:ios:8704f064c8ecbafba42afa',
    messagingSenderId: '564546244239',
    projectId: 'chat-with-admin-fd10f',
    storageBucket: 'chat-with-admin-fd10f.appspot.com',
    iosBundleId: 'com.example.booking.RunnerTests',
  );
}
