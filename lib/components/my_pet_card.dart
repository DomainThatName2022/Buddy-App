import 'package:flutter/material.dart';

class MyPetCard extends StatelessWidget {
  // const MyPetCard({Key? key}) : super(key: key);
  final _petName;
  final _desc;
  final String _imagePath;
  final VoidCallback? _onTap;

  MyPetCard(this._imagePath, this._desc, this._onTap, this._petName);

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          height: 76,
                          width: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue[50],
                          ),
                          child: Image.asset(_imagePath)),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            height: 25,
                            width: 180,
                            child: Text(
                              _petName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            height: 45,
                            width: 175,
                            child: Text(
                              _desc,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
        ),
      ),
    );
  }
}
