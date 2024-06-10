import 'package:blog_mobile/controllers/home/home_controller.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/home/components/post_component.dart';
import 'package:flutter/material.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({
    super.key,
    required this.myPostsController,
    required this.userId,
  });

  final MyPostsController myPostsController;
  final String? userId;

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  List<PostComponent> _cardsPosts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initCards();
  }

  @override
  Widget build(BuildContext context) {
    return buildBodyFeed();
  }

  Widget buildBodyFeed() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      );
    } else {
      return ListView(
        padding: const EdgeInsets.symmetric(vertical: 5),
        children: [
          Column(
            children: _cardsPosts.isEmpty ? const [Text('No posts')]: _cardsPosts,
          ),
          const Divider(
            color: ThemeColors.colorDiviser,
          ),
        ],
      );
    }
  }

  void _initCards() async {
    List<PostComponent> copyCards = [];
    if(widget.userId != null){
      copyCards = await widget.myPostsController.fetchPosts(widget.userId!);
    }
    if(mounted){
      setState(() {
      _cardsPosts = copyCards;
      isLoading = false;
    });
    }
  }
}
