import 'package:buddy_app/components/my_pet_card.dart';
import 'package:buddy_app/components/no_pets.dart';
import 'package:buddy_app/model/pet.dart';
// import 'package:buddy_app/components/no_pets.dart';
import 'package:buddy_app/screens/add_my_pets.dart';
import 'package:buddy_app/screens/home.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool petScreenLoaded = false;

  User? user = FirebaseAuth.instance.currentUser;

  //Pets Object
  List _petList = [];

  Future getPetsList() async {
    var data = await FirebaseFirestore.instance
        .collection('pets')
        .doc(user?.uid)
        .collection('userPets')
        .get();

    if (data.docs.isNotEmpty) {
      setState(() {
        _petList = List.from(data.docs.map((doc) => PetModel.fromSnaphot(doc)));
        petScreenLoaded = true;
      });
    } else if (data.docs.isEmpty) {
      setState(() {
        petScreenLoaded = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getPetsList();
  }

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
      body: petScreenLoaded
          ? WillPopScope(
              onWillPop: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false);
                return Future.value(false);
              },
              child: Container(
                color: colors.pewter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: _petList.length,
                    itemBuilder: (contet, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: MyPetCard(() => {}, _petList[index]),
                      );
                    },
                  ),
                ),
              ),
            )
          : const NoPets(),
      floatingActionButton: SizedBox(
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
              //Navigate to AddPets screen
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddMyPets()));
            }),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
