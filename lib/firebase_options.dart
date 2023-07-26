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
    apiKey: 'AIzaSyDsE14aLFAemT0COrNuGOCm-DF0tRCgk-c',
    appId: '1:964972011651:web:7cfff08fc6a3a23226fbb6',
    messagingSenderId: '964972011651',
    projectId: 'travelapp-c2e16',
    authDomain: 'travelapp-c2e16.firebaseapp.com',
    storageBucket: 'travelapp-c2e16.appspot.com',
    measurementId: 'G-83PTG89L70',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxGO0neQd7iZOoiux-Bfqyxz8-Nvby_Zs',
    appId: '1:964972011651:android:3d7f5b6dca6a219326fbb6',
    messagingSenderId: '964972011651',
    projectId: 'travelapp-c2e16',
    storageBucket: 'travelapp-c2e16.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCutmQk_KVJDInE8Mp59Ah5z3ZSEK4a1mw',
    appId: '1:964972011651:ios:61b3c1ab8cebe1ed26fbb6',
    messagingSenderId: '964972011651',
    projectId: 'travelapp-c2e16',
    storageBucket: 'travelapp-c2e16.appspot.com',
    iosClientId: '964972011651-gogagtekmi5cpan55f5uq1vohpveh1v2.apps.googleusercontent.com',
    iosBundleId: 'com.example.travelapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCutmQk_KVJDInE8Mp59Ah5z3ZSEK4a1mw',
    appId: '1:964972011651:ios:d7eca898088d0cf126fbb6',
    messagingSenderId: '964972011651',
    projectId: 'travelapp-c2e16',
    storageBucket: 'travelapp-c2e16.appspot.com',
    iosClientId: '964972011651-b8bhdes9kjlboten6aurepuh0g8q5672.apps.googleusercontent.com',
    iosBundleId: 'com.example.travelapp.RunnerTests',
  );
}
