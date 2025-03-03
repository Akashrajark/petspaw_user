import 'package:flutter/material.dart';
import 'package:petspaw_user/features/signin/signin_screen.dart';
import 'package:petspaw_user/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: SigninScreen(),
    );
  }
}
