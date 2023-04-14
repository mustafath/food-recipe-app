import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_recipe_app/extensions/colors.dart';
import 'package:food_recipe_app/screens/login/view/login_screen.dart';
import 'package:food_recipe_app/screens/main_menu/view/main_menu.dart';
import 'package:food_recipe_app/screens/main_menu/viewmodel/main_menu_cubit.dart';
import 'package:food_recipe_app/screens/notifications/notifications_view.dart';
import 'package:food_recipe_app/screens/reviews/review_cubit.dart';
import 'package:food_recipe_app/screens/saved_recipes/view/saved_recipes.dart';
import 'package:food_recipe_app/screens/search_recipe/view/search_menu.dart';
import 'package:food_recipe_app/screens/signup/view/signup_screen.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';
import 'package:food_recipe_app/screens/user_profile/user_profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => MainMenuCubit()),
    BlocProvider(create: (context) => UserProfileCubit()),
    BlocProvider(create: (context) => ReviewCubit())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? mtoken = "";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    requestPermission();
    getToken();
    initInfo();

    super.initState();
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc("user1")
        .set({"token": mtoken});
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/¡c_launcher');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("sela");
      print(message);
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) async {
      setState(() {});
      mtoken = token;
      saveToken(mtoken!);
      String a = await FirebaseMessaging.instance
          .getAPNSToken()
          .then((value) => value.toString());
      print(a);
      print("My token is $mtoken");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe App',
      home: LoginScreen(),
      theme: ThemeData(
        primaryColor: AppColors.accentColor,
      ),
    );
  }
}
