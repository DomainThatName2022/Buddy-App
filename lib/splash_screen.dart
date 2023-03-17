import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:buddy_app/screens/get_started.dart';
import 'package:buddy_app/screens/register.dart';
// import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';
// import 'screens/home.dart';
import 'screens/login.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimatedSplashScreen(
        splash: Center(
          child: Container(
            child: Image.asset('assets/images/splash.png'),
          ),
        ),
        splashIconSize: 300,
        nextScreen: const Get_Started(),
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
      ),
    );
  }
}
