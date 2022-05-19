import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class CustomCard extends StatelessWidget {
  // const CustomCard({Key? key}) : super(key: key);

  final _title;
  final String _icon;
  final _color;
  final VoidCallback _onTap;

  const CustomCard(this._icon, this._title, this._color, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        elevation: 8,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: ClipPath(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                border: Border(left: BorderSide(color: _color, width: 12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        child: Iconify(
                          _icon,
                          size: 70,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40, right: 10),
                        child: Text(
                          _title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, right: 25),
                      child: Material(
                        child: InkWell(
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 25,
                          ),
                          onTap: _onTap,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
        ),
      ),
    );
  }
}
