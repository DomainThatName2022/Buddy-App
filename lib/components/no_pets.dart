import 'package:flutter/material.dart';

import '../theme/color_palette.dart';

class NoPets extends StatelessWidget {
  const NoPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Color Palette
    const colors = ColorPalette();

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'No Pets to Show',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: colors.dominant),
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/nothing_show.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
