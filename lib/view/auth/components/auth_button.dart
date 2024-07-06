import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.fontSize,
    required this.size,
  });

  final VoidCallback onPressed;
  final String title;
  final double fontSize;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: size, 
        backgroundColor: ThemeColors.colorBottonSelected,
      ),
      onPressed: onPressed, 
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white
        ),
        )
      );
  }
}