import 'package:blog_mobile/controllers/auth/home_controller.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/auth/components/auth_snackbar.dart';
import 'package:blog_mobile/view/home/components/card_post.dart';
import 'package:blog_mobile/view/posts/edit_and_create_post.dart';
import 'package:flutter/material.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({super.key, required this.userLogged});

  final User userLogged;

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  List<Post> _posts = [];
  late Future<bool> isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = _fetchMyPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: isLoading,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ThemeColors.colorCircularProgressIndicator,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      const Center(child: Text('Error'));
                    }
                    return _posts.isNotEmpty
                        ? ListView.builder(
                            itemCount: _posts.length + 1,
                            itemBuilder: (context, index) {
                              if (index >= _posts.length) {
                                return const SizedBox(
                                  height: 63,
                                );
                              } else {
                                return CardPost(
                                  post: _posts[index],
                                  isPostPage: false,
                                  isMyPost: true,
                                  edit: () async {
                                    _editPost(index);
                                  },
                                  delete: () async {
                                    _deletePost(index);
                                  },
                                );
                              }
                            },
                          )
                        : const Center(
                            child: Text('No Posts'),
                          );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.colorBottonSelected,
        onPressed: () async {
          final newPost = await Navigator.push<Post>(
            context,
            MaterialPageRoute(
              builder: (context) => EditAndCreatePost(
                  post: Post(
                      username: widget.userLogged.userName,
                      fullName: widget.userLogged.firstame != null &&
                              widget.userLogged.lastName != null
                          ? '${widget.userLogged.firstame!} ${widget.userLogged.lastName!}'
                          : 'No name',
                      userId: widget.userLogged.id == 209
                          ? 1
                          : widget.userLogged.id),
                  isEditPost: false),
            ),
          );
          setState(() {
            if (newPost != null) {
              _posts.add(newPost);
            }
          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Future<bool> _fetchMyPosts() async {
    _posts += await HomeController.myPostsController(widget.userLogged.id!);
    if (mounted) {
      setState(() {});
    }
    return Future.value(true);
  }

  Future<void> _editPost(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAndCreatePost(
          post: _posts[index],
          isEditPost: true,
        ),
      ),
    );
    setState(() {});
  }

  Future<void> _deletePost(int index) async {
    final Post postRemoved = _posts.removeAt(index);
    bool deleted = true;
    setState(() {});

    final SnackBarAction action = SnackBarAction(
      label: 'undo',
      textColor: Colors.black,
      onPressed: () async {
        setState(() {
          _posts.insert(index, postRemoved);
          deleted = false;
        });
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      buildAuthSnackBar(
        message: 'Post ${postRemoved.getId} Removed',
        actionBar: action,
      ),
    );

    await Future.delayed(const Duration(seconds: 3));
    if (deleted) {
      await HomeController.deletePostController(postRemoved.getId!);
    }
  }
}
