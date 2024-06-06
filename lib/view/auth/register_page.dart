import 'package:blog_mobile/themes/style/consts.dart';
import 'package:blog_mobile/utils/auth/auth_utils.dart';
import 'package:blog_mobile/view/auth/components/auth_button.dart';
import 'package:blog_mobile/view/auth/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _userNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _isVisibly = false;
  bool _isAccepted = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
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
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome',
                        style: kTitleStyleAuthPages,
                      ),
                      const Text(
                        'User',
                        style: kTitleStyleAuthPages,
                      ),
                      const Text(
                        'Sign up to join',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                          controller: _userNameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: kLabelStyleAuthPages,
                              border: kBoderTextFormField,
                              focusedBorder: kFocusedBorderTextFormField,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never),
                          validator: (String? text) {
                            final String? valid =
                                AuthUtils.textFormFieldValidator(
                                    text, 'Username');
                            return valid;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: kLabelStyleAuthPages,
                              border: kBoderTextFormField,
                              focusedBorder: kFocusedBorderTextFormField,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never),
                          validator: (String? text) {
                            final String? valid =
                                AuthUtils.textFormFieldValidator(text, 'Email');
                            return valid;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              labelText: 'Phone',
                              labelStyle: kLabelStyleAuthPages,
                              border: kBoderTextFormField,
                              focusedBorder: kFocusedBorderTextFormField,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never),
                          validator: (String? text) {
                            final String? valid =
                                AuthUtils.textFormFieldValidator(text, 'Phone');
                            return valid;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: kLabelStyleAuthPages,
                              border: kBoderTextFormField,
                              focusedBorder: kFocusedBorderTextFormField,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                           activeColor: Colors.green,
                            checkColor: Colors.white,
                              value: _isAccepted,
                              onChanged: (bool? accepted) {
                                setState(() {
                                  _isAccepted = !_isAccepted;
                                });
                              }),
                          const Text('I agree to the'),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Terms of Service',
                            style: TextStyle(color: Colors.teal),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Have an account?'),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: const Text(
                              'Sign In',
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
                        //register();
                      }
                    },
                    title: 'Sign Up',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
