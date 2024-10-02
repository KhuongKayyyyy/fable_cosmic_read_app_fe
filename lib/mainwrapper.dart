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
      body: widget.navigationShell,
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black.withOpacity(0.1),
        onTap: _goToPage,
        items: [
          CrystalNavigationBarItem(icon: Icons.home),
          CrystalNavigationBarItem(icon: Icons.library_books),
          CrystalNavigationBarItem(icon: Icons.search),
          CrystalNavigationBarItem(icon: Icons.settings),
        ],
      ),
    );
  }
}
