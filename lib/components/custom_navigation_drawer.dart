import 'package:buddy_app/screens/my_profile.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawer();
}

class _CustomNavigationDrawer extends State<CustomNavigationDrawer> {
  final colors = const ColorPalette();

  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.dominant,
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 70,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 30),
            child: Column(
              children: [
                Text(
                  "${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
                // Text(
                //   "${loggedInUser.email}",
                //   style: const TextStyle(
                //     color: Colors.white,
                //     fontSize: 14,
                //   ),
                //   textAlign: TextAlign.left,
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 70, top: 10),
                  child: InkWell(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const MyProfile())));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
