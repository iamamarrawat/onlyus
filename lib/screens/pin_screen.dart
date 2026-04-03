import 'package:flutter/material.dart';
import 'package:only_us/components/gradient_container.dart';
import 'package:only_us/screens/chat_screen.dart';
import 'package:only_us/user/user_prefs.dart';
import 'package:pinput/pinput.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  late TextEditingController pinController;

  @override
  void initState() {
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Center(
          child: Pinput(
            controller: pinController,
            autofocus: true,
            separatorBuilder: (index) => SizedBox(width: 12),
            defaultPinTheme: PinTheme(
              textStyle: TextStyle(color: Colors.white, fontSize: 24),
              height: MediaQuery.of(context).size.width * 0.17,
              width: MediaQuery.of(context).size.width * 0.17,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromARGB(26, 169, 226, 177),
              ),
            ),
            length: 4,
            onCompleted: (value) async {
              if (value == "1455" || value == "2627") {
                final username = await UserPrefs.getUsername();
                if (username != null && username.isNotEmpty) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(username: username),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.black,
                    showCloseIcon: true,
                    closeIconColor: Colors.white,

                    content: Text(
                      "Enter a valid pin!",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );

                Future.delayed(Duration(milliseconds: 500), () {
                  pinController.clear();
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
