import 'package:flutter/material.dart';
import 'package:nio_demo/di/app_module.dart';
import 'package:nio_demo/routes/router.dart';

import 'gen/fonts.gen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF9F9F9),
        // This is the theme of your application.
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        fontFamily: FontFamily.sfPro,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.maxFinite, 70),
                textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: .8),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))))),
        textTheme: const TextTheme(
          // appbar
          titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 23.0),

          labelLarge: TextStyle(fontSize: 16.0),
          // body
          bodySmall: TextStyle(fontSize: 14),
          bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 1.5),
          labelMedium: TextStyle(fontSize: 14.0, color: Color(0xFF8F8F8F)),
        ),
      ),
      routerConfig: RouteConfig.router,
    );
  }
}
