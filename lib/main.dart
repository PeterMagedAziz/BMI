import 'package:bmi/layout/home_layout.dart';
import 'package:bmi/modules/bmi/bmi-screen.dart';
import 'package:bmi/modules/home/home_screen.dart';
import 'package:bmi/modules/login/login_Screen.dart';
import 'package:bmi/modules/messenger/messenger_screen.dart';
import 'package:bmi/modules/users/user_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),

    );
  }
}
