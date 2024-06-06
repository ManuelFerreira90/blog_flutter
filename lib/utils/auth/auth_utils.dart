import 'package:flutter/material.dart';

class AuthUtils {
  static Icon passwordVisibilityToggle(bool isVisibly) {
    if (isVisibly) {
      return const Icon(Icons.visibility, color: Colors.grey);
    } else {
      return const Icon(Icons.visibility_off, color: Colors.grey);
    }
  }

  static String? textFormFieldValidator(
      String? text, String nameTextFormFiedl) {
    if (text == null || text.isEmpty) {
      return '$nameTextFormFiedl cannot be empty';
    } else {
      return null;
    }
  }
}
