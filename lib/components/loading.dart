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
      color: colors.ivory,
      child: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colors.scallopSeashell),
          child: const Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }
}
