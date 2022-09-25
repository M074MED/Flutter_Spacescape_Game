import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:spacescape/screens/main_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      fontFamily: "BungeeInline",
      scaffoldBackgroundColor: Colors.black,
    ),
    home: const MainMenu(),
  ));
}
