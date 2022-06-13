import 'package:buddy_app/components/my_pet_card.dart';
// import 'package:buddy_app/components/no_pets.dart';
import 'package:buddy_app/screens/add_my_pets.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../components/custom_bottom_navigation.dart';
import '../components/notification_icon.dart';

class MyPets extends StatefulWidget {
  const MyPets({Key? key}) : super(key: key);

  @override
  _MyPetsState createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  //color Palette
  final colors = const ColorPalette();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'My Pets',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: colors.scallopSeashell,
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 12, right: 20),
              child: NotificationIcon(),
            ),
          ]),
      body: Container(
        color: colors.pewter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MyPetCard(
                      'assets/images/dog_face.png',
                      'Friendly buddy, grey with white spots',
                      () => {},
                      'Josh')),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 75,
        width: 75,
        child: FloatingActionButton(
            elevation: 5.0,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: colors.scallopSeashell,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddMyPets()));
            }),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
