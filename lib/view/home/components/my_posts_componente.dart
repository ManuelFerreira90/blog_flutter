import 'package:blog_mobile/context/post_provider.dart';
import 'package:blog_mobile/controllers/home_controller.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/auth/components/auth_snackbar.dart';
import 'package:blog_mobile/view/home/components/card_post.dart';
import 'package:blog_mobile/view/posts/edit_and_create_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({super.key, required this.userLogged});

  final User userLogged;

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  @override
  void initState() {
    super.initState();

    final postProvider = Provider.of<PostProvider>(context, listen: false);
    if (postProvider.posts.isEmpty) {
      postProvider.fetchPosts(widget.userLogged.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          if (postProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ThemeColors.colorCircularProgressIndicator,
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: postProvider.posts.isNotEmpty
                    ? ListView.builder(
                        itemCount: postProvider.posts.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= postProvider.posts.length) {
                            return const SizedBox(
                              height: 63,
                            );
                          } else {
                            return CardPost(
                              post: postProvider.posts[index],
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
                      ),
              ),
            ],
          );
        },
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
                  imageUser: widget.userLogged.image,
                  username: widget.userLogged.userName,
                  fullName: widget.userLogged.firstame != null &&
                          widget.userLogged.lastName != null
                      ? '${widget.userLogged.firstame!} ${widget.userLogged.lastName!}'
                      : 'No name',
                  userId:
                      widget.userLogged.id == 209 ? 1 : widget.userLogged.id,
                ),
                isEditPost: false,
              ),
            ),
          );
          if (newPost != null) {
            final postProvider =
                Provider.of<PostProvider>(context, listen: false);
            postProvider.addPost(newPost);
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Future<void> _editPost(int index) async {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAndCreatePost(
          post: postProvider.posts[index],
          isEditPost: true,
        ),
      ),
    );
    setState(() {});
  }

  Future<void> _deletePost(int index) async {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    final Post postRemoved = postProvider.posts[index];
    postProvider.deletePost(postRemoved);

    bool deleted = true;
    final SnackBarAction action = SnackBarAction(
      label: 'undo',
      textColor: Colors.black,
      onPressed: () {
        postProvider.addPost(postRemoved);
        deleted = false;
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
