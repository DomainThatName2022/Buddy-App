import 'package:buddy_app/screens/login.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_image.dart';
import '../components/custom_text_field.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final colors = ColorPalette();

  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(
                child: CustomImage('assets/images/register.png', 151.0, 214.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'Create an Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: CustomTextField('', 'First Name'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: CustomTextField('', 'Last Name'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: CustomTextField('', 'Email'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: CustomTextField('', 'Phone Number'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '',
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                        color: colors.gray,
                      ),
                    ),
                  )),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: '',
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                        color: colors.gray,
                      ),
                    ),
                  )),
            ),

            //Register Button
            Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Button('Sign Up', () => {debugPrint('Button Clicked')})),

            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Login()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
