import 'package:blog_mobile/controllers/auth/resgister_controller.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/themes/style/consts.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/utils/auth/auth_utils.dart';
import 'package:blog_mobile/view/auth/components/auth_button.dart';
import 'package:blog_mobile/view/auth/components/auth_snackbar.dart';
import 'package:blog_mobile/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  late ResgisterController checkRegister;
  final _formKey = GlobalKey<FormState>();
  bool _isVisibly = false;
  bool _isAccepted = false;
  PhoneNumber number = PhoneNumber(isoCode: 'BR');
  String userPhone = '';

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    checkRegister = ResgisterController();
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
          backgroundColor: ThemeColors.colorScaffold,
          leading: const Text(''),
        ),
        body: ListView(
          padding: kPaddingAuthPages,
          children: [
            Form(
              key: _formKey,
              child: Focus(
                onKeyEvent: (focusNode, keyEvent) {
                  if(keyEvent is KeyDownEvent && keyEvent.physicalKey == PhysicalKeyboardKey.enter){
                    if(_formKey.currentState!.validate()){
                      _registerUser();
                    }
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: InternationalPhoneNumberInput(
                            inputDecoration: const InputDecoration(
                                labelText: 'Phone',
                                labelStyle: kLabelStyleAuthPages,
                                border: kBoderTextFormField,
                                focusedBorder: kFocusedBorderTextFormField,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never),
                            validator: (userInput) {
                              if (userPhone.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            onInputChanged: (PhoneNumber number) {
                              userPhone = number.phoneNumber ?? '';
                            },
                            onInputValidated: (bool value) {},
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              useBottomSheetSafeArea: true,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle:
                                const TextStyle(color: Colors.white),
                            initialValue: number,
                            textFieldController: _phoneController,
                            formatInput: true,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            onSaved: (PhoneNumber number) {},
                          ),
                        ),
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
                              String email = _emailController.text;
                              final bool isValid = EmailValidator.validate(email);
                              if (isValid) {
                                return null;
                              } else {
                                return 'The email is not valid';
                              }
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: FormField<bool>(
                                validator: (value) {
                                  if (!_isAccepted) {
                                    return 'You need to accept terms';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                                state.didChange(_isAccepted);
                                              });
                                            },
                                          ),
                                          const Flexible(
                                            child: Wrap(
                                              children: [
                                                Text('I agree to the'),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: Text(
                                                    'Terms of Services',
                                                    style: TextStyle(
                                                        color: Colors.teal),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      state.errorText != null ? Text(
                                        state.errorText!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffdfaaa9),
                                        ),
                                      ) : const SizedBox.shrink(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Wrap(
                                children: [
                                  const Text('Have an account?'),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                    ),
                                  ),
                                ],
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
                          _registerUser();
                        }
                      },
                      title: 'Sign Up',
                      size: const Size(1, 65),
                      fontSize: 25.0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser() async {
    await checkRegister.controlRegister(_userNameController.text,
        _phoneController.text, _emailController.text, _passwordController.text);

    if (mounted) {
      if (checkRegister.getSucessRegister) {
        final User user = checkRegister.getUser!;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userLogged: user,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(buildAuthSnackBar(message: checkRegister.getError));
      }
    }
  }
}
