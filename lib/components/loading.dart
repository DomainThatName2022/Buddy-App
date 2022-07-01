import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  // const Loading({Key? key}) : super(key: key);
  final String _status;

  Loading(this._status);

  @override
  Widget build(BuildContext context) {
    //Color Palette
    const colors = ColorPalette();

    return Material(
      child: Container(
        color: colors.accentTweaked,
        child: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: colors.dominant),
            child: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      _status,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
