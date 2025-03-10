import 'package:fable_cosmic_read_app_fe/core/router/app_navigation.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configLoading();
  final GoRouter router = await AppNavigation.createRouter();
  runApp(MyApp(router: router));
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..indicatorColor = AppTheme.primaryColor
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Fable Cosmic Read App',
      theme: AppTheme.theme,
      routerConfig: router,
    );
  }
}
