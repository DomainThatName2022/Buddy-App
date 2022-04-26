import 'package:buddy_app/components/custom_image.dart';
import 'package:buddy_app/screens/register.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import '../theme/color_palette.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  //import color palette
  final colors = const ColorPalette();

  bool _isHidden = true;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      // validator: (){},
      onSaved: (value) {
        emailcontroller.text = value!;
      },

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: colors.gray,
          ),
          hintText: 'Email'),
      cursorColor: colors.scallopSeashell,
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: _isHidden,
      controller: passwordcontroller,
      // validator: (){},
      onSaved: (value) {
        passwordcontroller.text = value!;
      },

      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: colors.gray,
        ),
        hintText: 'Password',
        // labelText: 'Password',
        suffixIcon: InkWell(
          onTap: _togglePasswordView,
          child: Icon(
            _isHidden ? Icons.visibility_off : Icons.visibility,
            color: colors.gray,
          ),
        ),
      ),
      cursorColor: colors.scallopSeashell,
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: colors.gray,
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
        },
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Login',
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
                child:
                    // CustomTextField('abc@gmail.com', 'Email'),
                    Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      emailField,
                      const SizedBox(
                        height: 50,
                      ),
                      passwordField,
                      const SizedBox(
                        height: 40,
                      ),
                      loginButton
                    ],
                  ),
                )),

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
                        InkWell(
                          onTap: _toggleRememberMe,
                          child: Icon(
                            _isChecked
                                ? Icons.check_box_outline_blank
                                : Icons.check_box_outlined,
                            color: colors.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        'Remember me',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
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
              padding: const EdgeInsets.fromLTRB(50, 10, 40, 0),
              child: Center(
                child: Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Don't have an account yet?"),
                    GestureDetector(
                        onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Register()))
                            },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colors.scallopSeashell,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ))
                  ],
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Methods
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _toggleRememberMe() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }
}
