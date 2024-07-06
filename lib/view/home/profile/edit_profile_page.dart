import 'package:blog_mobile/controllers/auth/home_controller.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/themes/style/consts.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/utils/auth/auth_utils.dart';
import 'package:blog_mobile/view/auth/components/auth_button.dart';
import 'package:blog_mobile/view/auth/components/auth_snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key, required this.userLogged});

  User userLogged;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _userNameController;
  late TextEditingController _countryController;
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();
  bool isEdited = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.userLogged.firstame);
    _lastNameController =
        TextEditingController(text: widget.userLogged.lastName);
    _emailController = TextEditingController(text: widget.userLogged.email);
    _userNameController =
        TextEditingController(text: widget.userLogged.userName);
    _countryController = TextEditingController(text: widget.userLogged.country);
    _phoneController = TextEditingController(text: widget.userLogged.phone);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }

        if (isEdited) {
          final exit = await _showDialog() ?? false;
          if (exit) {
            Navigator.pop(context);
          }
        } else {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Focus(
              onKeyEvent: (focusNode, keyEvent) {
                if (keyEvent is KeyDownEvent &&
                    keyEvent.physicalKey == PhysicalKeyboardKey.enter) {
                  if (_formKey.currentState!.validate()) {
                    _updateUser();
                  }
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              },
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: kStyleTitleEditProfile,
                          ),
                          TextFormField(
                            controller: _firstNameController,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              isEdited = true;
                            },
                            decoration: const InputDecoration(
                              labelText: 'First name',
                              labelStyle: kLabelStyleAuthPages,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: kBoderTextFormField,
                              focusedBorder: kFocusedBorderTextFormField,
                            ),
                            validator: (String? text) {
                              final String? valid =
                                  AuthUtils.textFormFieldValidator(
                                      text, 'name');
                              return valid;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Last name',
                            style: kStyleTitleEditProfile,
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              isEdited = true;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Last name',
                              labelStyle: kLabelStyleAuthPages,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: kBoderTextFormField,
                              focusedBorder: kFocusedBorderTextFormField,
                            ),
                            validator: (String? text) {
                              final String? valid =
                                  AuthUtils.textFormFieldValidator(
                                      text, 'last name');
                              return valid;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Email',
                            style: kStyleTitleEditProfile,
                          ),
                          TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.white,
                              onChanged: (value) {
                                isEdited = true;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: kLabelStyleAuthPages,
                                  border: kBoderTextFormField,
                                  focusedBorder: kFocusedBorderTextFormField,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never),
                              validator: (String? text) {
                                String email = _emailController.text;
                                final bool isValid =
                                    EmailValidator.validate(email);
                                if (isValid) {
                                  return null;
                                } else {
                                  return 'The email is not valid';
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Username',
                            style: kStyleTitleEditProfile,
                          ),
                          TextFormField(
                            controller: _userNameController,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              isEdited = true;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: kLabelStyleAuthPages,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                          const Text(
                            'Country',
                            style: kStyleTitleEditProfile,
                          ),
                          TextFormField(
                            controller: _countryController,
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              isEdited = true;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Country',
                              labelStyle: kLabelStyleAuthPages,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: kBoderTextFormField,
                              focusedBorder: kFocusedBorderTextFormField,
                            ),
                            validator: (String? text) {
                              final String? valid =
                                  AuthUtils.textFormFieldValidator(
                                      text, 'Country');
                              return valid;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Phone',
                            style: kStyleTitleEditProfile,
                          ),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              isEdited = true;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              labelStyle: kLabelStyleAuthPages,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: kBoderTextFormField,
                              focusedBorder: kFocusedBorderTextFormField,
                            ),
                            validator: (userInput) {
                              final String? valid =
                                  AuthUtils.textFormFieldValidator(
                                      _phoneController.text, 'Phone');
                              return valid;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (isEdited) {
                              _updateUser();
                            } else {
                              Navigator.pop(context);
                            }
                          }
                        },
                        title: 'Save',
                        fontSize: 20,
                        size: const Size(1, 50),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateUser() async {
    widget.userLogged.setFirstName = _firstNameController.text;
    widget.userLogged.setLastName = _lastNameController.text;
    widget.userLogged.setEmail = _emailController.text;
    widget.userLogged.setUserName = _userNameController.text;
    widget.userLogged.setCountry = _countryController.text;
    widget.userLogged.setPhone = _phoneController.text;
    final bool isEdit =
        await HomeController.updateUserController(widget.userLogged);
    if (isEdit && mounted) {
      Navigator.pop(context);
    } else {
      buildAuthSnackBar(message: 'Failed');
    }
  }

  Future<bool?> _showDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ThemeColors.colorScaffold,
          title: const Text(
            'Disagree your changes?',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Want to go back to the previous page and lose changes?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: ThemeColors.colorBottonSelected,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
