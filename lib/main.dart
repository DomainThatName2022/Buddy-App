// import 'package:buddy_app/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:buddy_app/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyBXv15-rcVszvf7nXCqnLwzmsZBCU4dNjc",
      appId: "1:259771989535:android:b558e94b520fddbab75f2a",
      messagingSenderId: "259771989535",
      projectId: "emailpasswordauth-13830",
    ),
  );

  runApp(const Splash());
}
