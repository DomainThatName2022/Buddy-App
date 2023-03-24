import 'package:buddy_app/components/custom_image.dart';
import 'package:buddy_app/components/loading.dart';
import 'package:buddy_app/screens/home.dart';
import 'package:buddy_app/screens/login.dart';
import 'package:buddy_app/screens/password_reset_successful.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //Color Palette
  final colors = const ColorPalette();

  // controllers
  final TextEditingController emailcontroller = TextEditingController();

  //form key
  final _formKey = GlobalKey<FormState>();

  //firebase instance
  final auth = FirebaseAuth.instance;

  //reset status
  bool isResetted = false;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter a valid email");
        }

        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        }

        return null;
      },
      onSaved: (value) {
        emailcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail, color: colors.dominant),
          filled: true,
          fillColor: colors.textfieldaccent,
          border: InputBorder.none,
          errorStyle: TextStyle(color: colors.dominant),
          hintText: 'Email'),
      cursorColor: colors.dominant,
    );

    //Submit Button
    final passwordResetButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      color: colors.accent,
      child: MaterialButton(
        onPressed: () {
          resetPassword(emailcontroller.text);
        },
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Send Request',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: colors.dominant,
            )),
        title: Text(
          'Forgot Password',
          style: TextStyle(color: colors.accent, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isResetted
          ? Loading('Resetting password...')
          : Material(
              color: Colors.white,
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    CustomImage(
                        'assets/images/Forgot_password.png', 250.0, 333.0),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          'Forgot your password?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.accent,
                            fontFamily: "Open Sans",
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          'Enter your email below to reset your password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              emailField,
                              const SizedBox(
                                height: 40,
                              ),
                              passwordResetButton
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ),
    );
  }

  // Reset Request function
  void resetPassword(String email) async {
    if (_formKey.currentState!.validate()) {
      //Loading
      setState(() {
        isResetted = true;
      });
      try {
        await auth.sendPasswordResetEmail(email: email);
        Fluttertoast.showToast(
            msg: "Request email sent", backgroundColor: colors.accent);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const PasswordResetSuccessful()));
      } on FirebaseAuthException catch (error) {
        //loading
        setState(() {
          isResetted = false;
        });

        Fluttertoast.showToast(
            msg: "Email does not exist", backgroundColor: colors.accent);
        debugPrint(error.code);
      }
    }
  }
}
