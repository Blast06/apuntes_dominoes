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
    apiKey: 'AIzaSyB4ICDKL5XqnV3yNnc2_DIWoL8jNby2VDM',
    appId: '1:359439722905:web:73feb462c4cdbcfc7ccb08',
    messagingSenderId: '359439722905',
    projectId: 'nicknames-generator',
    authDomain: 'nicknames-generator.firebaseapp.com',
    storageBucket: 'nicknames-generator.appspot.com',
    measurementId: 'G-GQMYS81W41',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcMG-uN0rx_SZeYv9_7V0pj4s0u92qp0c',
    appId: '1:359439722905:android:b105247ff33429357ccb08',
    messagingSenderId: '359439722905',
    projectId: 'nicknames-generator',
    storageBucket: 'nicknames-generator.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMgq_fVcRTy0pjzlXSlhlqUODP-Uash-I',
    appId: '1:359439722905:ios:7690f7fed72131be7ccb08',
    messagingSenderId: '359439722905',
    projectId: 'nicknames-generator',
    storageBucket: 'nicknames-generator.appspot.com',
    iosClientId: '359439722905-dl7kd9epic5hmicbt9felg0fdt0m2k5r.apps.googleusercontent.com',
    iosBundleId: 'com.dominoes.anotarapuntes',
  );
}
