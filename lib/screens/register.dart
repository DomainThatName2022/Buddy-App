import 'package:buddy_app/screens/login.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import '../components/custom_image.dart';

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

  final colors = const ColorPalette();

  //value to control the obsecure text
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      // validator: (){},
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
            color: colors.gray,
          ),
          hintText: 'First Name'),
      cursorColor: colors.scallopSeashell,
    );

    //last name field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.name,
      // validator: (){},
      onSaved: (value) {
        lastNameEditingController.text = value!;
      },

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
            color: colors.gray,
          ),
          hintText: 'Last Name'),
      cursorColor: colors.scallopSeashell,
    );

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      // validator: (){},
      onSaved: (value) {
        emailEditingController.text = value!;
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

    //phone number
    final phoneNumberField = TextFormField(
      autofocus: false,
      controller: phoneEditingController,
      keyboardType: TextInputType.phone,
      // validator: (){},
      onSaved: (value) {
        phoneEditingController.text = value!;
      },

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: colors.gray,
          ),
          hintText: 'Phone Number'),
      cursorColor: colors.scallopSeashell,
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: _isHidden,
      controller: passwordEditingController,
      // validator: (){},
      onSaved: (value) {
        passwordEditingController.text = value!;
      },

      textInputAction: TextInputAction.next,
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

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      obscureText: _isHidden,
      controller: confirmPasswordEditingController,
      // validator: (){},
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },

      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: colors.gray,
        ),
        hintText: 'Confirm Password',
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

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: colors.gray,
      child: MaterialButton(
        onPressed: () {},
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
              color: colors.scallopSeashell,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
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
                padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                child:
                    // CustomTextField('abc@gmail.com', 'Email'),
                    Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      firstNameField,
                      const SizedBox(
                        height: 30,
                      ),
                      lastNameField,
                      const SizedBox(
                        height: 30,
                      ),
                      emailField,
                      const SizedBox(
                        height: 30,
                      ),
                      phoneNumberField,
                      const SizedBox(
                        height: 30,
                      ),
                      passwordField,
                      const SizedBox(
                        height: 30,
                      ),
                      confirmPasswordField,
                      const SizedBox(
                        height: 30,
                      ),
                      signUpButton
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 40),
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
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
