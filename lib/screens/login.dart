import 'package:flutter/material.dart';
import 'home.dart';
import '../theme/color_palette.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //import color palette
  final colors = const ColorPalette();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Center(
                child: Container(
                    width: 214,
                    height: 151,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/good_dog.png')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter valid email: abc@gmail.com'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                    // icon: Icon(Icons.visibility),
                  )),
            ),

            //Login Button
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                height: 58,
                width: 323,
                // decoration: BoxDecoration(
                //     color: colors.gray, borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HomePage(
                                  title: 'Home',
                                )));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(colors.gray),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),

            //Remember me Checkbox
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: const [Icon(Icons.check_box_outline_blank)],
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
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Divider(
                thickness: 1,
                color: colors.gray,
                height: 50,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 40, 0),
              child: Center(
                child: Expanded(
                    child: Row(
                  children: const <Widget>[
                    Text('Dont have an account yet?'),
                    FlatButton(onPressed: null, child: Text('Sign in'))
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
