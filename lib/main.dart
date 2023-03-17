// import 'package:buddy_app/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:buddy_app/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
        apiKey: "AIzaSyBgWL29Pk-qaobGkRO0HbaH1PQooU3yIyQ",
        authDomain: "buddyapp-321f5.firebaseapp.com",
        projectId: "buddyapp-321f5",
        storageBucket: "buddyapp-321f5.appspot.com",
        messagingSenderId: "136919883372",
        appId: "1:136919883372:web:8b934de684755c62718249",
        measurementId: "G-CR4H61HWFP"),
  );

  runApp(const Splash());
}
