import 'package:flutter/material.dart';
import 'package:only_us/screens/chat_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void navigate(BuildContext context, String user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatScreen(username: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select User")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => navigate(context, "user1"),
              child: const Text("Login as User 1"),
            ),
            ElevatedButton(
              onPressed: () => navigate(context, "user2"),
              child: const Text("Login as User 2"),
            ),
          ],
        ),
      ),
    );
  }
}
