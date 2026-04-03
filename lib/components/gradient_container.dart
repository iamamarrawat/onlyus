import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  const GradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 3, 36, 20),
            Color.fromARGB(255, 0, 43, 31),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
