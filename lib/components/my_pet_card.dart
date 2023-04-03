import 'package:buddy_app/model/pet.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyPetCard extends StatelessWidget {
  final VoidCallback? _onTap;

  //PetModel
  final PetModel _pet;
  bool petImageLoading = false;

  final String _age;
  // final VoidCallback _onTap;

  MyPetCard(this._onTap, this._pet, this._age);

  @override
  Widget build(BuildContext context) {
    //Color Palette
    final colors = const ColorPalette();

    //Gender Icons and color
    final IconData _male = Icons.male;
    final IconData _female = Icons.female;

    return GestureDetector(
      onTap: _onTap,
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
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 130,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: "${_pet.mediaUrlList[0]}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${_pet.name}",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Container(
                  width: 150,
                  height: 33,
                  child: Text(
                    "${_pet.description!.isEmpty ? "No Description to display" : _pet.description}",
                    style:
                        TextStyle(fontSize: 14, color: colors.dominantTweaked),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${_pet.yearOfBirth}",
                          style:
                              TextStyle(fontSize: 14, color: colors.lightgrey),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: _pet.petGender == "Male"
                                ? colors.male
                                : colors.female,
                          ),
                          child: Icon(
                            _pet.petGender == "Male" ? _male : _female,
                            size: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
