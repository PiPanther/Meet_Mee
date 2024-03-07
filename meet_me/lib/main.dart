import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meet_me/firebase_options.dart';
import 'package:meet_me/pages/home_page.dart';
import 'package:meet_me/pages/homepage_subpages/profile_page.dart';
import 'package:meet_me/pages/homepage_subpages/tempPage.dart';
import 'package:meet_me/pages/login_page.dart';
import 'package:meet_me/pages/splash_screen.dart';
import 'package:meet_me/providers/data_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = SplashScreen();
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print(user!.email);
      if (user != null) {
        // User is signed in
        setState(() {
          page = TempPage();
        });
      } else {
        // User is not signed in
        setState(() {
          page = const LoginPage();
        });
      }
    });
  }

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider<UserData>(
          create: (context) => UserData(),
        )
      ], child: page),
    );
  }
}
