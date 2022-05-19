import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Color Palette
    const colors = ColorPalette();

    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitFadingCircle(
          color: colors.scallopSeashell,
          size: 80,
        ),
      ),
    );
  }
}
