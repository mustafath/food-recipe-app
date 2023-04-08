import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/extensions/colors.dart';
import 'package:food_recipe_app/screens/login/view/login_screen.dart';
import 'package:food_recipe_app/screens/main_menu/view/main_menu.dart';
import 'package:food_recipe_app/screens/main_menu/viewmodel/main_menu_cubit.dart';
import 'package:food_recipe_app/screens/signup/view/signup_screen.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (context) => MainMenuCubit())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe App',
      home: MainMenu(),
      theme: ThemeData(
        primaryColor: AppColors.accentColor,
      ),
    );
  }
}
