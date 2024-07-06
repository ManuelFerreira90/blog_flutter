import 'dart:async';

import 'package:blog_mobile/controllers/auth/home_controller.dart';
import 'package:blog_mobile/models/comment.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/home/components/card_post.dart';
import 'package:blog_mobile/view/posts/components/comment_component.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.post});

  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<List<Comment>> _comments;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${widget.post.getId ?? ''}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          CardPost(post: widget.post, isPostPage: true,),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: _comments,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ThemeColors.colorCircularProgressIndicator,
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return const SizedBox.shrink();
                  } else {
                    return Column(
                      children: snapshot.hasData
                          ? snapshot.data!
                              .map(
                                (e) => CommentComponent(comment: e),
                              )
                              .toList()
                          : [
                              const SizedBox.shrink(),
                            ],
                    );
                  }
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _fetchComments() async {
    _comments = HomeController.commentsByPostController(widget.post.getId!);
  }
}
