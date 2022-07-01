import 'package:buddy_app/model/pet.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class MyPetCard extends StatelessWidget {
  final VoidCallback? _onTap;

  //PetModel
  final PetModel _pet;

  MyPetCard(this._onTap, this._pet);

  @override
  Widget build(BuildContext context) {
    //Color Palette
    final colors = const ColorPalette();
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: ClipPath(
            child: SizedBox(
              height: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                            height: 80,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: colors.accentTweaked,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                "${_pet.mediaUrlList[0]}",
                                fit: BoxFit.fill,
                              ),
                            )),
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
                                "${_pet.name}",
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
                            child: SizedBox(
                              height: 45,
                              width: 175,
                              child: Text(
                                "${_pet.description!.isEmpty ? "No Description to display" : _pet.description}",
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
      ),
      onTap: _onTap,
    );
  }
}
