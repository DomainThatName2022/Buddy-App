import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // CustomTextField({Key? key}) : super(key: key);

  @required
  String _labelText;
  @required
  String _hintText;

  CustomTextField(this._hintText, this._labelText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(labelText: _labelText, hintText: _hintText),
      ),
    );
  }
}
