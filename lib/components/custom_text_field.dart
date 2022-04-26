import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  @required
  final String _labelText;
  @required
  final String _hintText;

  const CustomTextField(this._hintText, this._labelText);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: _labelText, hintText: _hintText),
    );
  }
}
