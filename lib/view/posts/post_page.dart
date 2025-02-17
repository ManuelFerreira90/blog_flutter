import 'dart:async';

import 'package:blog_mobile/context/post_provider.dart';
import 'package:blog_mobile/controllers/home_controller.dart';
import 'package:blog_mobile/models/comment.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/home/components/card_post.dart';
import 'package:blog_mobile/view/posts/components/comment_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.post});

  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Comment> _comments = [];
  late Future<bool> isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = _fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${widget.post.getId ?? ''}'),
      ),
      body: FutureBuilder(
        future: isLoading,
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
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _comments.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(children: [
                        CardPost(
                          post: widget.post,
                          isPostPage: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]);
                    } else {
                      return CommentComponent(comment: _comments[index - 1]);
                    }
                  },
                );
              }
          }
        },
      ),
    );
  }

  Future<bool> _fetchComments() async {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    _comments +=
        await HomeController.commentsByPostController(widget.post.getId!);  

    

    return Future.value(true);
  }
}
