import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD9Wbjq_vzwIEV-u39g8IXexZCEhK2Ajn4",
            authDomain: "crawler-qit35v.firebaseapp.com",
            projectId: "crawler-qit35v",
            storageBucket: "crawler-qit35v.firebasestorage.app",
            messagingSenderId: "181779977120",
            appId: "1:181779977120:web:3a2b096e257e6438538ac5",
            measurementId: "G-CG6WS2J85C"));
  } else {
    await Firebase.initializeApp();
  }
}
