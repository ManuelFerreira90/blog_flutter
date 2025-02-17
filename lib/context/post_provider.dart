import 'package:flutter/material.dart';
import 'package:blog_mobile/controllers/home_controller.dart';
import 'package:blog_mobile/models/post.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts(int userId) async {
    _isLoading = true;
    notifyListeners();

    _posts = await HomeController.myPostsController(userId);
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addPost(Post newPost) async {
    _posts.add(newPost);
    notifyListeners();
  }

  Future<void> deletePost(Post post) async {
    _posts.remove(post);
    notifyListeners();
  }
}
