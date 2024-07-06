import 'package:blog_mobile/controllers/auth/home_controller.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/themes/style/consts.dart';
import 'package:blog_mobile/utils/auth/auth_utils.dart';
import 'package:blog_mobile/view/auth/components/auth_button.dart';
import 'package:blog_mobile/view/auth/components/auth_snackbar.dart';
import 'package:flutter/material.dart';

class EditAndCreatePost extends StatefulWidget {
  const EditAndCreatePost(
      {super.key, required this.post, required this.isEditPost});

  final Post post;
  final bool isEditPost;

  @override
  State<EditAndCreatePost> createState() => _EditAndCreatePostState();
}

class _EditAndCreatePostState extends State<EditAndCreatePost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post.getTitle ?? '';
    _bodyController.text = widget.post.getBody ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
        child: Form(
          key: _formKey,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Title',
                    style: kStyleTitleEditProfile,
                  ),
                  TextFormField(
                    controller: _titleController,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      isEdited = true;
                    },
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: kLabelStyleAuthPages,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: kBoderTextFormField,
                      focusedBorder: kFocusedBorderTextFormField,
                    ),
                    validator: (String? text) {
                      final String? valid =
                          AuthUtils.textFormFieldValidator(text, 'Title');
                      return valid;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Body',
                    style: kStyleTitleEditProfile,
                  ),
                  TextFormField(
                    controller: _bodyController,
                    keyboardType: TextInputType.multiline,
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      isEdited = true;
                    },
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Body',
                      labelStyle: kLabelStyleAuthPages,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: kBoderTextFormField,
                      focusedBorder: kFocusedBorderTextFormField,
                    ),
                    validator: (userInput) {
                      final String? valid = AuthUtils.textFormFieldValidator(
                          _bodyController.text, 'Body');
                      return valid;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          widget.post.setTitle = _titleController.text;
                          widget.post.body = _bodyController.text;
                        });
                        if (widget.isEditPost) {
                          _edit();
                        } else {
                          _create();
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
    );
  }

  void _edit() async {
    final bool edited = await HomeController.updatePostController(widget.post);
    if (edited && mounted) {
      Navigator.pop(context);
    } else {
      buildAuthSnackBar(message: 'Failed');
    }
  }

  void _create() async {
    final Post? newPost = await HomeController.addPostController(widget.post);
    if (newPost != null && mounted) {
      newPost.fullName = widget.post.getFullName ?? 'No name';
      newPost.username = widget.post.getUserName ?? 'No username';
      Navigator.pop(context, newPost);
    } else {
      Navigator.pop(context);
      buildAuthSnackBar(message: 'Failed');
    } 
  }
}
