import 'package:blog_mobile/context/post_provider.dart';
import 'package:blog_mobile/themes/style/app_theme.dart';
import 'package:blog_mobile/view/auth/check_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()), 
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme,
      home: const CheckPage(),
    );
  }
}
