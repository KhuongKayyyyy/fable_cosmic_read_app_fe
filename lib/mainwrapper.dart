import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Mainwrapper extends StatefulWidget {
  const Mainwrapper({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  @override
  State<Mainwrapper> createState() => _MainwrapperState();
}

class _MainwrapperState extends State<Mainwrapper> {
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
              activeColor: AppTheme.primaryColor,
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.library_books),
              title: const Text('Library'),
              activeColor: AppTheme.primaryColor,
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.search),
              title: const Text('Search'),
              activeColor: AppTheme.primaryColor,
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
              activeColor: AppTheme.primaryColor,
            ),
          ],
          onItemSelected: _goToPage,
        ),
      ),
    );
  }
}
