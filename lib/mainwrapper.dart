import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';

class Mainwrapper extends StatefulWidget {
  const Mainwrapper({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  @override
  State<Mainwrapper> createState() => _MainwrapperState();
}

class _MainwrapperState extends State<Mainwrapper> {
  // int _myCurrentIndex = 0; // Removed unused field
  void _goToPage(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: widget.navigationShell,
      // bottomNavigationBar: CrystalNavigationBar(
      //   currentIndex: widget.navigationShell.currentIndex,
      //   unselectedItemColor: Colors.white70,
      //   selectedItemColor: Colors.pink[400],
      //   backgroundColor: Colors.black.withOpacity(0.1),
      //   onTap: _goToPage,
      //   items: [
      //     CrystalNavigationBarItem(icon: Icons.home),
      //     CrystalNavigationBarItem(icon: Icons.library_books),
      //     CrystalNavigationBarItem(icon: Icons.search),
      //     CrystalNavigationBarItem(icon: Icons.settings),
      //   ],
      // )
      bottomNavigationBar: SizedBox(
        height: 90,
        child: FlashyTabBar(
          selectedIndex: widget.navigationShell.currentIndex,
          showElevation: true,
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
            ),
          ],
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Colors.pink,
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.library_books),
              title: const Text('Library'),
              activeColor: Colors.pink,
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.search),
              title: const Text('Search'),
              activeColor: Colors.pink,
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
              activeColor: Colors.pink,
            ),
          ],
          onItemSelected: _goToPage,
        ),
      ),
    );
  }
}
