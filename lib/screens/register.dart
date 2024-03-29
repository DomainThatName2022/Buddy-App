import 'package:buddy_app/components/loading.dart';
import 'package:buddy_app/model/user.dart';
import 'package:buddy_app/screens/login.dart';
import 'package:buddy_app/screens/registration_successful.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/custom_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Form key
  final _formKey = GlobalKey<FormState>();

  //editing controllers
  final firstNameEditingController = TextEditingController();
  final lastNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  //Color palette
  final colors = const ColorPalette();

  //value to control the obsecure text
  bool _isHidden = true;

  //Auth
  final _auth = FirebaseAuth.instance;

  String errorMessage = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter First Name");
        }

        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
            color: colors.dominant,
          ),
          filled: true,
          fillColor: colors.textfieldaccent,
          border: InputBorder.none,
          errorStyle: TextStyle(color: colors.dominant),
          hintText: 'First Name'),
      cursorColor: colors.dominant,
    );

    //last name field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter Last Name");
        }

        return null;
      },
      onSaved: (value) {
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
            color: colors.dominant,
          ),
          filled: true,
          fillColor: colors.textfieldaccent,
          border: InputBorder.none,
          errorStyle: TextStyle(color: colors.dominant),
          hintText: 'Last Name'),
      cursorColor: colors.dominant,
    );

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter a valid email");
        }

        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }

        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: colors.dominant,
          ),
          filled: true,
          fillColor: colors.textfieldaccent,
          border: InputBorder.none,
          errorStyle: TextStyle(color: colors.dominant),
          hintText: 'Email'),
      cursorColor: colors.dominant,
    );

    //phone number
    final phoneNumberField = TextFormField(
      autofocus: false,
      controller: phoneEditingController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        RegExp regex = RegExp(r'(^(?:[+0]27)?[0-9]{10,12}$)');

        if (value!.isEmpty) {
          return ("Please enter phone number");
        }

        if (!regex.hasMatch(value)) {
          return ("Please enter valid phone number");
        }
        return null;
      },
      onSaved: (value) {
        phoneEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: colors.dominant,
          ),
          filled: true,
          fillColor: colors.textfieldaccent,
          border: InputBorder.none,
          errorStyle: TextStyle(color: colors.dominant),
          hintText: 'Phone Number'),
      cursorColor: colors.dominant,
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: _isHidden,
      controller: passwordEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');

        if (value!.isEmpty) {
          return ("Password is required");
        }

        if (!regex.hasMatch(value)) {
          return ("Please enter valid Password(Min. 6 characters)");
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: colors.dominant,
        ),
        filled: true,
        fillColor: colors.textfieldaccent,
        border: InputBorder.none,
        errorStyle: TextStyle(color: colors.dominant),
        hintText: 'Password',
        suffixIcon: InkWell(
          onTap: _togglePasswordVisibilty,
          child: Icon(
            _isHidden ? Icons.visibility_off : Icons.visibility,
            color: colors.dominant,
          ),
        ),
      ),
      cursorColor: colors.dominant,
    );

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      obscureText: _isHidden,
      controller: confirmPasswordEditingController,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password does not match";
        }

        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: colors.dominant,
        ),
        filled: true,
        fillColor: colors.textfieldaccent,
        border: InputBorder.none,
        errorStyle: TextStyle(color: colors.dominant),
        hintText: 'Confirm Password',
        // labelText: 'Password',
        suffixIcon: InkWell(
          onTap: _toggleConfirmPasswordVisibilty,
          child: Icon(
            _isHidden ? Icons.visibility_off : Icons.visibility,
            color: colors.dominant,
          ),
        ),
      ),
      cursorColor: colors.dominant,
    );

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      color: colors.accent,
      child: MaterialButton(
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return loading
        ? Loading('Creating Profile...')
        : Scaffold(
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
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Center(
                      child: CustomImage(
                          'assets/images/sign-up-image.png', 200.0, 200.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Create an Account',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                              fontFamily: "Open Sans",
                              color: colors.accent,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Create a new account",
                              style: TextStyle(
                                  fontSize: 16, color: colors.lightgrey),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            firstNameField,
                            const SizedBox(
                              height: 50,
                            ),
                            lastNameField,
                            const SizedBox(
                              height: 50,
                            ),
                            emailField,
                            const SizedBox(
                              height: 50,
                            ),
                            phoneNumberField,
                            const SizedBox(
                              height: 50,
                            ),
                            passwordField,
                            const SizedBox(
                              height: 50,
                            ),
                            confirmPasswordField,
                            const SizedBox(
                              height: 50,
                            ),
                            signUpButton
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 40),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const Login()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  //Methods
  void _togglePasswordVisibilty() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _toggleConfirmPasswordVisibilty() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(
              msg: e!.message, backgroundColor: colors.accent);
        });
      } on FirebaseAuthException catch (error) {
        setState(() {
          loading = false;
        });
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(
            msg: errorMessage, backgroundColor: colors.accent);
        debugPrint(error.code);
      }
    }
  }

  // postDetailsToFirestore() async {
  //   // calling our firestore
  //   // calling our user model
  //   // sending these values

  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;

  //   UserModel userModel = UserModel();

  //   // writing all the values
  //   userModel.email = user!.email;
  //   userModel.uid = user.uid;
  //   userModel.firstName = firstNameEditingController.text;
  //   userModel.secondName = lastNameEditingController.text;
  //   userModel.phoneNumber = phoneEditingController.text;

  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(user.uid)
  //       .set(userModel.toMap());
  //   Fluttertoast.showToast(
  //       msg: "Account created successfully!", backgroundColor: colors.accent);

  //   Navigator.pushAndRemoveUntil(
  //       (context),
  //       MaterialPageRoute(builder: (context) => const RegistrationSuccessful()),
  //       (route) => false);
  // }

  // void signUp(String email, String password) async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       loading = true;
  //     });

  //     try {
  //       await _auth.createUserWithEmailAndPassword(
  //           email: email, password: password);
  //       await postDetailsToFirestore();
  //     } on FirebaseAuthException catch (error) {
  //       setState(() {
  //         loading = false;
  //       });
  //       switch (error.code) {
  //         case "invalid-email":
  //           errorMessage = "Your email address appears to be malformed.";
  //           break;
  //         case "wrong-password":
  //           errorMessage = "Your password is wrong.";
  //           break;
  //         case "user-not-found":
  //           errorMessage = "User with this email doesn't exist.";
  //           break;
  //         case "user-disabled":
  //           errorMessage = "User with this email has been disabled.";
  //           break;
  //         case "too-many-requests":
  //           errorMessage = "Too many requests";
  //           break;
  //         case "operation-not-allowed":
  //           errorMessage = "Signing in with Email and Password is not enabled.";
  //           break;
  //         default:
  //           errorMessage = "An undefined Error happened.";
  //       }
  //       Fluttertoast.showToast(
  //           msg: errorMessage, backgroundColor: colors.accent);
  //       debugPrint(error.code);
  //     }
  //   }
  // }

  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel(
      email: user!.email,
      uid: user.uid,
      firstName: firstNameEditingController.text,
      secondName: lastNameEditingController.text,
      phoneNumber: phoneEditingController.text,
    );

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(
        msg: "Account created successfully!", backgroundColor: colors.accent);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationSuccessful()),
        (route) => false);
  }
}
