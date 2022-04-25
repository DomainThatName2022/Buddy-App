import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

class Button extends StatelessWidget {
  static const colors = ColorPalette();

  String buttonText;
  VoidCallback onTap;

  Button(this.buttonText, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 323,
      child: ElevatedButton(
        onPressed: onTap,
        // onPressed: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (_) => const HomePage(
        //                 title: 'Home',
        //               )));
        // },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Button.colors.gray),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
