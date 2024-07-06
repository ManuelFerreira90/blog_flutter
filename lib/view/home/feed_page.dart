import 'package:blog_mobile/controllers/auth/home_controller.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/auth/components/auth_snackbar.dart';
import 'package:blog_mobile/view/home/components/card_post.dart';
import 'package:blog_mobile/view/home/components/loading_refresh.dart';
import 'package:blog_mobile/view/posts/edit_and_create_post.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key, required this.userId});

  final int userId;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Post> _posts = [];
  late Future<bool> isLoading;
  final _scrollController = ScrollController();
  final loadingRefresh = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    isLoading = _fetchAllPosts();
    _scrollController.addListener(infinityScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(infinityScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void infinityScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !loadingRefresh.value) {
      setState(() {
        loadingRefresh.value = true;
        _fetchAllPosts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: _posts.length,
                          itemBuilder: (context, index) {
                            return CardPost(
                              post: _posts[index],
                              isPostPage: false,
                              isMyPost: widget.userId == _posts[index].getUserId
                                  ? true
                                  : false,
                              delete: () async {
                                await _deletePost(index);
                              },
                              edit: () async {
                                await _editPost(index);
                              },
                            );
                          },
                        ),
                      ),
                      loadingWidget(loadingRefresh),
                    ],
                  )
                : const Center(
                    child: Text('No results'),
                  );
        }
      },
    );
  }

  Future<bool> _fetchAllPosts() async {
    _posts += await HomeController.allPostsController(_posts.length);
    loadingRefresh.value = false;
    if (mounted) {
      setState(() {});
    }
    return Future.value(true);
  }

  Future<void> _editPost(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAndCreatePost(post: _posts[index], isEditPost: true,),
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
