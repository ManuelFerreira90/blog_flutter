import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(1, 65),
        backgroundColor: ThemeColors.colorBottonSelected,
      ),
      onPressed: onPressed, 
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.white
        ),
        )
      );
  }
}