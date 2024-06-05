import 'package:blog_mobile/controllers/auth/check_controller.dart';
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
    SchedulerBinding.instance.addPostFrameCallback ((_) {
        _checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _checkUser() async{
    final CheckController checkUserControl = CheckController();

    print(checkUserControl.user);
    if(checkUserControl.user != null){
      // TODO - criar navegação para home page
      
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      // TODO - criar navegação para login page
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }
}