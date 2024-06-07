import 'package:blog_mobile/api/auth/auth_service.dart';
import 'package:blog_mobile/controllers/auth/login_controller.dart';
import 'package:blog_mobile/themes/style/consts.dart';
import 'package:blog_mobile/utils/auth/auth_utils.dart';
import 'package:blog_mobile/view/auth/components/auth_button.dart';
import 'package:blog_mobile/view/auth/components/auth_snackbar.dart';
import 'package:blog_mobile/view/auth/register_page.dart';
import 'package:blog_mobile/view/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;
  late LoginController _checkLogin;
  final _formKey = GlobalKey<FormState>();
  bool _isVisibly = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _checkLogin = LoginController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: const Text(''),
        ),
        body: ListView(
          padding: kPaddingAuthPages,
          scrollDirection: Axis.vertical,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Welcome', style: kTitleStyleAuthPages),
                      const Text(
                        'Back',
                        style: kTitleStyleAuthPages,
                      ),
                      const Text('Sign in to continue'),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: kLabelStyleAuthPages,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: kBoderTextFormField,
                          focusedBorder: kFocusedBorderTextFormField,
                        ),
                        validator: (String? text) {
                          final String? valid =
                              AuthUtils.textFormFieldValidator(
                                  text, 'Username');
                          return valid;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _passwordController,
                          obscureText: !_isVisibly,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              labelText: 'password',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: kLabelStyleAuthPages,
                              focusedBorder: kFocusedBorderTextFormField,
                              border: kBoderTextFormField,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isVisibly = !_isVisibly;
                                  });
                                },
                                icon: AuthUtils.passwordVisibilityToggle(
                                    _isVisibly),
                              )),
                          validator: (String? text) {
                            final String? valid =
                                AuthUtils.textFormFieldValidator(
                                    text, 'Password');
                            return valid;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Create a new account?'),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.teal),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  AuthButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _loginUser();
                      }
                    },
                    title: 'Login',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _loginUser() async{
    await _checkLogin.controlLogin(
        _userNameController.text, _passwordController.text);

    if (_checkLogin.getSucessLogin && mounted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      if(mounted){
        ScaffoldMessenger.of(context)
          .showSnackBar(buildAuthSnackBar(_checkLogin.getError ?? 'An error ocurred'));
      }
    }
  }
}
