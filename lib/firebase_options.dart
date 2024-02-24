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
    apiKey: 'AIzaSyBEboUdNw8MWRJp0k1hx0LH9grJit0X6dI',
    appId: '1:1057982402076:web:972c0f8afe0dd6471dd9d9',
    messagingSenderId: '1057982402076',
    projectId: 'newsify-d7d9a',
    authDomain: 'newsify-d7d9a.firebaseapp.com',
    storageBucket: 'newsify-d7d9a.appspot.com',
    measurementId: 'G-883JNBVFTX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF90W9dtsTJbBVS8BZLFjJspR4jPSys-0',
    appId: '1:1057982402076:android:f23d885482acbec61dd9d9',
    messagingSenderId: '1057982402076',
    projectId: 'newsify-d7d9a',
    storageBucket: 'newsify-d7d9a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUYr4iQvliv29gfrsoCYifER7VyGAYJ2k',
    appId: '1:1057982402076:ios:d3edba3a4005b3511dd9d9',
    messagingSenderId: '1057982402076',
    projectId: 'newsify-d7d9a',
    storageBucket: 'newsify-d7d9a.appspot.com',
    iosBundleId: 'com.bholechature.newsify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUYr4iQvliv29gfrsoCYifER7VyGAYJ2k',
    appId: '1:1057982402076:ios:b67495b7f922cff51dd9d9',
    messagingSenderId: '1057982402076',
    projectId: 'newsify-d7d9a',
    storageBucket: 'newsify-d7d9a.appspot.com',
    iosBundleId: 'com.bholechature.newsify.RunnerTests',
  );
}