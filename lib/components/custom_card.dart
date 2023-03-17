import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class CustomCard extends StatelessWidget {
  // const CustomCard({Key? key}) : super(key: key);

  final _petname;
  final String _imageurl;
  final IconData _icon;
  final _color;
  final String _age;
  final VoidCallback _onTap;

  const CustomCard(this._petname, this._imageurl, this._icon, this._color,
      this._age, this._onTap);

  // const CustomCard(this._imageurl, this._title, this._color, this._onTap);

  @override
  Widget build(BuildContext context) {
    const colors = ColorPalette();
    return GestureDetector(
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 2),
            )
          ]),
      height: 200,
      width: 145,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 110,
              width: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  _imageurl,
                  height: 70,
                  width: 70,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  _petname,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      _age,
                      style: TextStyle(fontSize: 14, color: colors.lightgrey),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 5),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: _color,
                        ),
                        child: Icon(
                          _icon,
                          size: 20,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
