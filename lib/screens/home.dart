import 'package:buddy_app/components/drawer_list.dart';
import 'package:buddy_app/components/navigation_drawer.dart';
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

  //Iconify Icons
  static const String petIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1.02em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 65 64"><path fill="#868b8e" d="M54.853 54.475a7.565 7.565 0 0 0 1.262-7.385l-.867-2.386h5.229V.592H3.722v44.112h30.522l3.327 9.142a7.545 7.545 0 0 0 5.716 4.84l1.465 4.873h13.446l-3.345-9.082zm-1.671-15.386l-1.243-3.379l-1.841-5.074a5.397 5.397 0 0 0-3.229 6.921l2.019 5.51H5.359V2.232h53.482v40.835h-4.198l-1.461-3.977z"/><path fill="#868b8e" d="M21.869 19.493c-1.032.86-2.508 1.291-4.425 1.291h-3.673v6.344h-3.664V9.485h7.576c1.747 0 3.138.456 4.177 1.365c1.039.911 1.558 2.319 1.558 4.225c0 2.085-.517 3.556-1.549 4.419zm-2.814-6.358c-.467-.391-1.122-.587-1.963-.587h-3.321v5.197h3.321c.841 0 1.495-.213 1.963-.635c.467-.424.699-1.093.699-2.012c.001-.917-.232-1.571-.699-1.963zm19.875-.526h-9.334v3.747h8.57v3.064h-8.57v4.536h9.767v3.171h-13.37V9.484h12.938v3.125zm16.611-3.124v3.125h-5.277v14.518h-3.712V12.61h-5.303V9.485H55.54z"/></svg>';
  static const String foundIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 16 16"><path fill="#868b8e" d="M8.894 12.16v-.002v.002zm.022.567l-.001-.011l.001.011zm-.013-.285v-.008v.008zM15 0H1C.45 0 0 .45 0 1v14c0 .55.45 1 1 1h14c.55 0 1-.45 1-1V1c0-.55-.45-1-1-1zM3 3.5a.5.5 0 0 1 1 0v1a.5.5 0 0 1-1 0v-1zM15 15H9.14a20.425 20.425 0 0 1-.209-1.994v.005a8.551 8.551 0 0 1-6.595-2.09a.563.563 0 0 1 .744-.844a7.426 7.426 0 0 0 5.807 1.806a31.808 31.808 0 0 1 .11-3.334A.499.499 0 0 0 8.499 8H7.012c.022-.541.079-1.466.234-2.503c.295-1.981.812-3.528 1.502-4.497h6.251v14z"/><path fill="#868b8e" d="M12.5 5a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 1 0v1a.5.5 0 0 1-.5.5zm-4.055 8.05zM8 13.063zm.423-1.138l.037-.002l-.037.002zm-.219.009a.803.803 0 0 0 .05-.002l-.05.002zm5.509-1.806a.563.563 0 0 0-.794-.05a7.428 7.428 0 0 1-4.032 1.806c.007.364.02.742.043 1.127a8.552 8.552 0 0 0 4.733-2.09a.563.563 0 0 0 .05-.794zM8.93 13.012zm-.25.023l-.183.013l.183-.013z"/></svg>';
  static const String dogIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="#868b8e" d="m19.57 17.04l-1.997-1.316l-1.665 2.782l-1.937-.567l-1.706 2.604l.087.82l9.274-1.71l-.538-5.794zm-8.649-2.498l1.488-.204c.241.108.409.15.697.223c.45.117.97.23 1.741-.16c.18-.088.553-.43.704-.625l6.096-1.106l.622 7.527l-10.444 1.882zm11.325-2.712l-.602.115L20.488 0L.789 2.285l2.427 19.693l2.306-.334c-.184-.263-.471-.581-.96-.989c-.68-.564-.44-1.522-.039-2.127c.53-1.022 3.26-2.322 3.106-3.956c-.056-.594-.15-1.368-.702-1.898c-.02.22.017.432.017.432s-.227-.289-.34-.683c-.112-.15-.2-.199-.319-.4c-.085.233-.073.503-.073.503s-.186-.437-.216-.807c-.11.166-.137.48-.137.48s-.241-.69-.186-1.062c-.11-.323-.436-.965-.343-2.424c.6.421 1.924.321 2.44-.439c.171-.251.288-.939-.086-2.293c-.24-.868-.835-2.16-1.066-2.651l-.028.02c.122.395.374 1.223.47 1.625c.293 1.218.372 1.642.234 2.204c-.116.488-.397.808-1.107 1.165c-.71.358-1.653-.514-1.713-.562c-.69-.55-1.224-1.447-1.284-1.883c-.062-.477.275-.763.445-1.153c-.243.07-.514.192-.514.192s.323-.334.722-.624c.165-.109.262-.178.436-.323a9.762 9.762 0 0 0-.456.003s.42-.227.855-.392c-.318-.014-.623-.003-.623-.003s.937-.419 1.678-.727c.509-.208 1.006-.147 1.286.257c.367.53.752.817 1.569.996c.501-.223.653-.337 1.284-.509c.554-.61.99-.688.99-.688s-.216.198-.274.51c.314-.249.66-.455.66-.455s-.134.164-.259.426l.03.043c.366-.22.797-.394.797-.394s-.123.156-.268.358c.277-.002.838.012 1.056.037c1.285.028 1.552-1.374 2.045-1.55c.618-.22.894-.353 1.947.68c.903.888 1.609 2.477 1.259 2.833c-.294.295-.874-.115-1.516-.916a3.466 3.466 0 0 1-.716-1.562a1.533 1.533 0 0 0-.497-.85s.23.51.23.96c0 .246.03 1.165.424 1.68c-.039.076-.057.374-.1.43c-.458-.554-1.443-.95-1.604-1.067c.544.445 1.793 1.468 2.273 2.449c.453.927.186 1.777.416 1.997c.065.063.976 1.197 1.15 1.767c.306.994.019 2.038-.381 2.685l-1.117.174c-.163-.045-.273-.068-.42-.153c.08-.143.241-.5.243-.572l-.063-.111c-.348.492-.93.97-1.414 1.245c-.633.359-1.363.304-1.838.156c-1.348-.415-2.623-1.327-2.93-1.566c0 0-.01.191.048.234c.34.383 1.119 1.077 1.872 1.56l-1.605.177l.759 5.908c-.337.048-.39.071-.757.124c-.325-1.147-.946-1.895-1.624-2.332c-.599-.384-1.424-.47-2.214-.314l-.05.059a2.851 2.851 0 0 1 1.863.444c.654.413 1.181 1.481 1.375 2.124c.248.822.42 1.7-.248 2.632c-.476.662-1.864 1.028-2.986.237c.3.481.705.876 1.25.95c.809.11 1.577-.03 2.106-.574c.452-.464.69-1.434.628-2.456l.714-.104l.258 1.834l11.827-1.424zM15.05 6.848c-.034.075-.085.125-.007.37l.004.014l.013.032l.032.073c.14.287.295.558.552.696c.067-.011.136-.019.207-.023c.242-.01.395.028.492.08c.009-.048.01-.119.005-.222c-.018-.364.072-.982-.626-1.308c-.264-.122-.634-.084-.757.068a.302.302 0 0 1 .058.013c.186.066.06.13.027.207m1.958 3.392c-.092-.05-.52-.03-.821.005c-.574.068-1.193.267-1.328.372c-.247.191-.135.523.047.66c.511.382.96.638 1.432.575c.29-.038.546-.497.728-.914c.124-.288.124-.598-.058-.698m-5.077-2.942c.162-.154-.805-.355-1.556.156c-.554.378-.571 1.187-.041 1.646c.053.046.096.078.137.104a4.77 4.77 0 0 1 1.396-.412c.113-.125.243-.345.21-.745c-.044-.542-.455-.456-.146-.749"/></svg>';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: colors.dominant,
          centerTitle: true,
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
            NavigationDrawer(),
            DrawerList(),
          ],
        )),
      ),
      body: Container(
        color: colors.accentTweaked,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomCard(
                    petIcon,
                    'I have lost my pet',
                    colors.dominant,
                    () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyPets(),
                            ),
                          )
                        }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomCard(
                    foundIcon, 'I have found a pet', colors.accent, () => {}),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomCard(
                    dogIcon, 'All matches', colors.compliment, () => {}),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
