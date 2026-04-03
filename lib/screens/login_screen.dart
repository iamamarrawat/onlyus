import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:only_us/components/gradient_button.dart';
import 'package:only_us/components/gradient_container.dart';
import 'package:only_us/screens/pin_screen.dart';
import 'package:only_us/user/user_prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Map<String, dynamic>> emailPassList = [
    {
      "email": "amarrawat244@gmail.com",
      "pass": "Quicklogin@123",
      "username": "user1",
    },
    {
      "email": "rktsadhanakumari@gmail.com",
      "pass": "Quicklogin@123",
      "username": "user2",
    },
  ];

  late TextEditingController emailController;

  late TextEditingController passController;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: 320,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),

                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Password Field
                    TextField(
                      controller: passController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Login Button
                    GradientButton(
                      title: "Login",
                      onTap: () async {
                        final enteredEmail = emailController.text
                            .trim()
                            .toLowerCase();
                        final enteredPass = passController.text.trim();

                        // Find matching user
                        final user = emailPassList.firstWhere(
                          (element) =>
                              element["email"].toLowerCase() == enteredEmail &&
                              element["pass"] == enteredPass,
                          orElse: () => {},
                        );

                        if (user.isNotEmpty) {
                          // ✅ Save username + login state
                          await UserPrefs.setUsername(user["username"]);
                          await UserPrefs.setUserLoggedIn(true);

                          // 🚀 Navigate
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const PinScreen(),
                            ),
                          );
                        } else {
                          // ❌ Error Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.black,
                              showCloseIcon: true,
                              closeIconColor: Colors.white,

                              content: Text(
                                "Enter valid email/password!",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
