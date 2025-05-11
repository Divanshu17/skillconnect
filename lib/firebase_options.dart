import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // Add other platforms if needed
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'your_actual_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your_sender_id',
    projectId: 'skillconnect',
    authDomain: 'skillconnect.firebaseapp.com',
    storageBucket: 'skillconnect.appspot.com',
  );
}
