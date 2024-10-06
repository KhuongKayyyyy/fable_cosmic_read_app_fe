import 'package:fable_cosmic_read_app_fe/core/router/app_navigation.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Fable Cosmic Read App',
      theme: AppTheme.theme,
      routerConfig: AppNavigation.router,
    );
  }
}
