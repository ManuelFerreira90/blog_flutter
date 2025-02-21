import 'package:blog_mobile/controllers/check_controller.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/auth/login_page.dart';
import 'package:blog_mobile/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ThemeColors.colorCircularProgressIndicator,
      ),
    );
  }

  void _checkUser() async {
    final CheckController checkUserControl = CheckController();
    await checkUserControl.controlCheckUser();

    if(mounted){
      if (checkUserControl.isLogged) {
      final User user = checkUserControl.user!;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    userLogged: user,
                  )));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    }
  }
}
