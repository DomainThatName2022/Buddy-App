import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String _assetPath;
  final double _width;
  final double _height;

  CustomImage(this._assetPath, this._height, this._width);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _width,
        height: _height,
        /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
        child: Image.asset(_assetPath));
  }
}
