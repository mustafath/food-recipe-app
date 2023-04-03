import 'package:flutter/material.dart';
import 'package:food_recipe_app/extensions/colors.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe App',
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: AppColors.accentColor,
      ),
    );
  }
}
