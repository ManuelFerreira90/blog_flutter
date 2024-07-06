import 'dart:convert';
import 'dart:core';

import 'package:blog_mobile/api/auth/auth_service.dart';
import 'package:blog_mobile/models/comment.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/utils/posts/functions_post.dart';

class HomeController {
  static Future<List<Post>> allPostsController(int skip) async {
    try {
      final response = await AuthService.fecthPosts(skip);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List<dynamic> posts = responseBody['posts'];
        return await FunctionsPost.convertPostToList(posts);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<List<Post>> searchPostsController(String search, int skip) async {
    try {
      final response = await AuthService.fetchSearchPosts(search, skip);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List<dynamic> posts = responseBody['posts'];
        return await FunctionsPost.convertPostToList(posts);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<List<Post>> myPostsController(int id) async {
    try {
      final response = await AuthService.fetchMyPosts(id);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List<dynamic> posts = responseBody['posts'];
        return await FunctionsPost.convertPostToList(posts);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<List<String>> tagsPostsController() async {
    try {
      final response = await AuthService.fetchPostTags();
      if (response.statusCode == 200) {
        final List<dynamic> tags = jsonDecode(response.body);
        return tags.map((tag) => tag.toString()).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<List<Post>> postsByTagController(String tag, int skip) async {
    try {
      final response = await AuthService.fetchPostByTags(tag, skip);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List<dynamic> posts = responseBody['posts'];
        return await FunctionsPost.convertPostToList(posts);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<List<Comment>> commentsByPostController(int id) async {
    try {
      final response = await AuthService.fetchCommentsByPost(id);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List<dynamic> commentsJson = responseBody['comments'];
        return await FunctionsPost.convertCommentsToList(commentsJson);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<bool> updateUserController (User user) async {
    try {
      final response = await AuthService.updateUser(user);
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> deletePostController(int id) async {
    try {
      await AuthService.deletePost(id);
      return;
    } catch (e) {
      return;
    }
  }

  static Future<bool> updatePostController(Post post) async {
    try {
      final response = await AuthService.updatePost(post);
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      return false;
    }
  }

  static Future<Post?> addPostController(Post post) async {
    try {
      final response = await AuthService.addPost(post);
      if(response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return Post.fromMap(responseBody);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
