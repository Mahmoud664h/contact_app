import 'package:contact_app/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.homeScreen,
      routes: {HomeScreen.homeScreen: (context) => const HomeScreen()},
    );
  }
}
