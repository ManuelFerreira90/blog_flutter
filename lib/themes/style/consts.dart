import 'package:flutter/material.dart';

const kTitleStyleAuthPages = TextStyle(
  color: Colors.white,
  fontSize: 40,
  fontWeight: FontWeight.bold,
);
const kLabelStyleAuthPages = TextStyle(color: Colors.grey, fontSize: 14);
const kPaddingAuthPages = EdgeInsets.symmetric(vertical: 10, horizontal: 25);
const kBoderTextFormField =
    OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)));
const kBoderTextFormFieldSearch =
    OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide.none);
const kFocusedBorderTextFormField = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.white));
const kFocusedBorderTextFormFieldSearch = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide.none);
const kStyleTitleEditProfile = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);