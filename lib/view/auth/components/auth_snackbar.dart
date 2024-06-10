import 'package:flutter/material.dart';

SnackBar buildAuthSnackBar(String message) {
  return SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20),
    content: Text(
      message.toString(),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
