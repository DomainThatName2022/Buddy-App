import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class CustomActionCard extends StatelessWidget {
  // const CustomActionCard({Key? key}) : super(key: key);

  final String _action;
  final String _actiondesc;
  final VoidCallback _ontap;

  const CustomActionCard(this._action, this._actiondesc, this._ontap);

  @override
  Widget build(BuildContext context) {
    final colors = ColorPalette();
    return GestureDetector(
      onTap: _ontap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: colors.dominantTweaked,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 4),
              )
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  _action,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    width: 250,
                    alignment: Alignment.topLeft,
                    child: Text(
                      _actiondesc,
                      // "Flag your missing pet and let the buddy community help you find your pet and bring it home.",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    alignment: Alignment.topRight,
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.arrow_circle_right,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
