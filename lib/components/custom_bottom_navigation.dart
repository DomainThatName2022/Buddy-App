import 'package:buddy_app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  //color palette
  final colors = const ColorPalette();

  //Iconify Icons
  static const String pawIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 15 15"><path fill="black" d="M5 0a2 2 0 0 0-2 2v1a2 2 0 1 0 4 0V2a2 2 0 0 0-2-2Zm5 0a2 2 0 0 0-2 2v1a2 2 0 1 0 4 0V2a2 2 0 0 0-2-2ZM2 5a2 2 0 0 0-2 2v.5a2 2 0 1 0 4 0V7a2 2 0 0 0-2-2Zm11 0a2 2 0 0 0-2 2v.5a2 2 0 1 0 4 0V7a2 2 0 0 0-2-2ZM9.613 7.779a2.737 2.737 0 0 0-4.226 0L2.47 11.322C1.261 12.789 2.305 15 4.205 15c.272 0 .54-.063.782-.185l.36-.18a4.814 4.814 0 0 1 4.306 0l.36.18c.242.122.51.185.782.185c1.9 0 2.944-2.211 1.736-3.678L9.613 7.779Z"/></svg>';
  static const String chatIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 32 32"><path fill="black" d="M15.985 5.972c-7.563 0-13.695 4.077-13.695 9.106c0 2.877 2.013 5.44 5.147 7.108c-.446 1.48-1.336 3.117-3.056 4.566c0 0 4.016-.266 6.852-3.143c.163.04.332.07.497.106a4.49 4.49 0 0 1-.247-1.443c0-3.393 3.776-6.05 8.6-6.05c3.463 0 6.378 1.376 7.75 3.406c1.168-1.34 1.847-2.893 1.847-4.553c0-5.028-6.132-9.105-13.695-9.105zM27.68 22.274c0-2.79-3.4-5.053-7.6-5.053c-4.195 0-7.598 2.264-7.598 5.054c0 2.79 3.403 5.053 7.6 5.053c.928 0 1.813-.116 2.636-.32c1.573 1.598 3.8 1.745 3.8 1.745c-.953-.804-1.446-1.713-1.694-2.534c1.738-.925 2.856-2.347 2.856-3.944z"/></svg>';
  static const String homeIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1024 1024"><path fill="black" d="M946.5 505L534.6 93.4a31.93 31.93 0 0 0-45.2 0L77.5 505c-12 12-18.8 28.3-18.8 45.3c0 35.3 28.7 64 64 64h43.4V908c0 17.7 14.3 32 32 32H448V716h112v224h265.9c17.7 0 32-14.3 32-32V614.3h43.4c17 0 33.3-6.7 45.3-18.8c24.9-25 24.9-65.5-.1-90.5z"/></svg>';

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Iconify(
              homeIcon,
              size: 20,
            ),
            activeIcon: Iconify(
              homeIcon,
              color: colors.accent,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Iconify(pawIcon, size: 20),
            activeIcon: Iconify(
              pawIcon,
              color: colors.accent,
            ),
            label: 'Manage Pets',
          ),
          BottomNavigationBarItem(
            icon: const Iconify(chatIcon, size: 20),
            activeIcon: Iconify(
              chatIcon,
              color: colors.accent,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
              size: 20,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: colors.accent,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colors.dominant,
        onTap: _onItemTapped,
      ),
    );
  }
}
