import 'package:buddy_app/components/custom_image.dart';
import 'package:buddy_app/screens/login.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class PasswordResetSuccessful extends StatelessWidget {
  const PasswordResetSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colors = ColorPalette();

    final proceedButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: colors.gray,
      child: MaterialButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login()));
        },
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Proceed to Login',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 80,
              width: 200,
              child: Text(
                'Password Reset Successful !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: colors.scallopSeashell,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: CustomImage('assets/images/mail_sent.png', 271.0, 335.0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 40, left: 40),
              child: Center(
                child: Text(
                  'Please check your email for a password reset link',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                child: proceedButton),
          ],
        ),
      ),
    );
  }
}
