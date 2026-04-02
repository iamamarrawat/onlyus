import 'package:flutter/material.dart';
import 'package:only_us/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Only Us',
      home: const LoginScreen(),
    );
  }
}
