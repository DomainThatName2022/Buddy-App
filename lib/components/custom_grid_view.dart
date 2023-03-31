import 'package:buddy_app/screens/pet.dart';
import 'package:flutter/material.dart';
import 'package:buddy_app/components/my_pet_card.dart';
import 'package:buddy_app/model/pet.dart';

import 'package:buddy_app/components/my_pet_card.dart';

import '../theme/color_palette.dart';

class CustomGridView extends StatelessWidget {
  // const CustomGridView({Key? key}) : super(key: key);

  final List _list;

  CustomGridView(this._list);

  @override
  Widget build(BuildContext context) {
    //color Palette
    // final colors = const ColorPalette();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        childAspectRatio: 0.8,
        // crossAxisSpacing: 0.5,
        mainAxisSpacing: 20,
      ),
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
          child: MyPetCard(
              () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Pet(_list[index])))
                  },
              _list[index],
              "2 years"),
        );
      },
    );
  }
}
