import 'package:flutter/material.dart';
import 'package:only_us/screens/login_screen.dart';
import 'package:only_us/screens/pin_screen.dart';
import 'package:only_us/user/user_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isLoggedIn = await UserPrefs.isUserLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Only Us',
      home: isLoggedIn ? const PinScreen() : const LoginScreen(),
    );
  }
}
