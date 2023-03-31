import 'dart:ui';

import 'package:buddy_app/screens/login.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class Get_Started extends StatelessWidget {
  const Get_Started({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = ColorPalette();

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      color: colors.dominant,
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Login()));
        },
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Get Started',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/missing-pet.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
              child: Column(
                children: [
                  Text(
                    "Lost your pet and don't know where to start?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Our app is here to help! Our state-of-the-art technology uses advanced algorithms to help locate your lost furry friend. With just a few taps on your phone, you can access a powerful network of pet lovers and increase your chances of finding your beloved companion.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: loginButton,
            ),
          )
        ],
      ),
    );
  }
}
