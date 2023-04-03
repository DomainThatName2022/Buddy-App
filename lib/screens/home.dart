import 'package:buddy_app/components/custom_action_card.dart';
import 'package:buddy_app/components/custom_carousel.dart';
import 'package:buddy_app/components/drawer_list.dart';
import 'package:buddy_app/components/custom_navigation_drawer.dart';
import 'package:buddy_app/screens/my_pets.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import '../components/custom_bottom_navigation.dart';
import '../components/custom_card.dart';
import '../components/notification_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final colors = const ColorPalette();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _cardObjects = [
      CustomCard("Gadget", "assets/images/pet1.jpg", Icons.male, colors.male,
          "5 months", () {}),
      CustomCard("Lory", "assets/images/pet5.jpg", Icons.male, colors.male,
          "4 years", () {}),
      CustomCard("Dave", "assets/images/pet3.jpg", Icons.female, colors.female,
          "8 months", () {}),
      CustomCard("Dolly", "assets/images/pet6.jpg", Icons.female, colors.female,
          "9 months", () {}),
      CustomCard("Busta", "assets/images/pet2.jpg", Icons.male, colors.male,
          "8 months", () {}),
      CustomCard("Shovi", "assets/images/pet4.jpg", Icons.female, colors.female,
          "1 year", () {}),
    ];

    final _cardObjects2 = [
      CustomCard("Dave", "assets/images/pet3.jpg", Icons.female, colors.female,
          "8 months", () {}),
      CustomCard("Shovi", "assets/images/pet4.jpg", Icons.female, colors.female,
          "1 year", () {}),
      CustomCard("Gadget", "assets/images/pet1.jpg", Icons.male, colors.male,
          "5 months", () {}),
      CustomCard("Lory", "assets/images/pet5.jpg", Icons.male, colors.male,
          "4 years", () {}),
      CustomCard("Dolly", "assets/images/pet6.jpg", Icons.female, colors.female,
          "9 months", () {}),
      CustomCard("Busta", "assets/images/pet2.jpg", Icons.male, colors.male,
          "8 months", () {}),
    ];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 10, bottom: 10),
                child: Image.asset(
                  "assets/images/menu.png",
                  height: 20,
                  width: 20,
                ),
              ),
            );
          }),
          title: Text(
            'Home',
            style: TextStyle(color: colors.accent, fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 12, right: 20),
              child: NotificationIcon(),
            ),
          ]),
      drawer: Drawer(
        child: SingleChildScrollView(
            child: Column(
          children: const [
            CustomNavigationDrawer(),
            DrawerList(),
          ],
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: colors.accentTweaked,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25, bottom: 10),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Missing Pets",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: colors.accent),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Container(
                  height: 200,
                  child: CustomCarousel(_cardObjects),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25, bottom: 10),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Found Pets",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: colors.accent),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Container(
                  height: 200,
                  child: CustomCarousel(_cardObjects2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25, bottom: 20),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Actions",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: colors.accent),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18, bottom: 20),
                child: CustomActionCard("Report a missing Pet",
                    "Flag your missing pet and let the buddy community help you find your pet and bring it home.",
                    () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyPets()));
                }),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18, bottom: 40),
                child: CustomActionCard("Report a Found Pet",
                    "Let the buddy community know when you have seen or found a pet that doesn’t belong to you.",
                    () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => CustomCarousel()));
                }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
