import 'package:buddy_app/screens/my_pets.dart';
import 'package:flutter/material.dart';

import '../theme/color_palette.dart';

class AnimatedCheck extends StatefulWidget {
  const AnimatedCheck({Key? key}) : super(key: key);

  @override
  _AnimatedCheckState createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck>
    with TickerProviderStateMixin {
  late AnimationController scaleController = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> scaleAnimation =
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(
      duration: const Duration(milliseconds: 400), vsync: this);
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //ColorPalette
    const colors = ColorPalette();
    double circleSize = 150;
    double iconSize = 80;

    final doneButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(8),
        color: colors.accent,
        child: MaterialButton(
          onPressed: () {
            //Navigate back to MyPets screen
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MyPets()));
          },
          minWidth: MediaQuery.of(context).size.width,
          height: 58,
          child: Text(
            'Done',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ));
    return Material(
      child: Container(
        color: colors.accentTweaked,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: circleSize,
                  width: circleSize,
                  decoration: BoxDecoration(
                    color: colors.dominantTweaked,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SizeTransition(
                        sizeFactor: checkAnimation,
                        axis: Axis.horizontal,
                        axisAlignment: -1,
                        child: Center(
                            child: Icon(Icons.check,
                                color: Colors.white, size: iconSize))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Pet Added Succefully',
                    style: TextStyle(
                        fontSize: 16,
                        color: colors.accent,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 100, 40, 0),
                  child: doneButton,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
