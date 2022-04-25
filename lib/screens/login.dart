import 'package:buddy_app/components/custom_image.dart';
import 'package:buddy_app/screens/register.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import '../theme/color_palette.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //import color palette
  final colors = const ColorPalette();

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
                child: CustomImage('assets/images/good_dog.png', 151.0, 214.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'Please log in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: CustomTextField('abc@gmail.com', 'Email'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                    suffixIcon: GestureDetector(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                        color: colors.gray,
                      ),
                    ),
                  )),
            ),

            //Login Button
            Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Button(
                    'Login',
                    () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomePage(
                                        title: 'Home',
                                      )))
                        })),

            //Remember me Checkbox
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        // Icon(Icons.check_box_outline_blank)
                        Icon(
                          Icons.check_box_outline_blank,
                          color: colors.gray,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        'Remember me',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            ),

            //Divider (Horizontal line)
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(children: <Widget>[
                Expanded(
                    child: Divider(
                  thickness: 1,
                  color: colors.gray,
                  height: 50,
                )),
                const Text(
                  "Or Sign in with",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: Divider(
                  thickness: 1,
                  color: colors.gray,
                  height: 50,
                )),
              ]),
            ),

            //Optional login
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(children: <Widget>[
                Expanded(
                    child: OutlinedButton(
                        onPressed: () => {debugPrint('Button Clicked')},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: <Widget>[
                              Image.asset('assets/images/google.png'),
                              const Text('Google'),
                            ],
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: colors.gray),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))))),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: OutlinedButton(
                  onPressed: () => {debugPrint('Button Clicked')},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/facebook.png'),
                        const Text('Facebook'),
                      ],
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2.0, color: colors.gray),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                )),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: Divider(
                thickness: 1,
                color: colors.gray,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 40, 0),
              child: Center(
                child: Expanded(
                    child: Row(
                  children: <Widget>[
                    const Text('Dont have an account yet?'),
                    FlatButton(
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Register()))
                            },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                )),
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            FlatButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
