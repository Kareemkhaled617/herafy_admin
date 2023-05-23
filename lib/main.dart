import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herafy_admin_web_part/pages/home_page.dart';
import 'package:herafy_admin_web_part/pages/login/login.dart';
import 'package:herafy_admin_web_part/pages/users/users.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAKKcVY2qktvq_Cm1_wTqpJGRqIqE5R3Gg",
      projectId: "herafy-983de",
      messagingSenderId: "1088905524845",
      appId: "1:1088905524845:web:a402d7112952c24da4b164",
      storageBucket: "herafy-983de.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Herafy',
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehaviour(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       // home:FirebaseAuth.instance.currentUser !=null?const HomePage(): const LoginScreen(),
       home: const HomePage(),
    );
  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
