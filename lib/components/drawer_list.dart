import 'package:buddy_app/theme/color_palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/login.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  final colors = const ColorPalette();

  var currentPage = DrawerSections.support;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.support) {
      // container = Support();
    } else if (currentPage == DrawerSections.happyStories) {
      // container = HappyStories();
    } else if (currentPage == DrawerSections.settings) {
      // container = Settings();
    } else if (currentPage == DrawerSections.about) {
      // container = About();
    } else if (currentPage == DrawerSections.logout) {
      container = logout(context);
    }

    return Container(
      padding: const EdgeInsets.only(
        top: 0,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Support", Icons.contact_support,
              currentPage == DrawerSections.support ? true : false),
          menuItem(2, "Happy Stories", Icons.auto_stories,
              currentPage == DrawerSections.happyStories ? true : false),
          menuItem(3, "Settings", Icons.settings,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(4, "About", Icons.info,
              currentPage == DrawerSections.about ? true : false),
          menuItem(5, "Logout", Icons.logout,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.support;
            } else if (id == 2) {
              currentPage = DrawerSections.happyStories;
            } else if (id == 3) {
              currentPage = DrawerSections.settings;
            } else if (id == 4) {
              currentPage = DrawerSections.about;
            } else if (id == 5) {
              currentPage = DrawerSections.logout;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 25,
                  color: colors.scallopSeashell,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }
}

enum DrawerSections {
  support,
  happyStories,
  settings,
  about,
  logout,
}
