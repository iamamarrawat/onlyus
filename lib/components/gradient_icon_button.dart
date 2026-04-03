import 'package:flutter/material.dart';

class GradientIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;

  const GradientIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 25, 104, 27),
        ),
        child: Center(
          child: Icon(icon, color: Colors.white.withOpacity(0.7), size: 24),
        ),
      ),
    );
  }
}
