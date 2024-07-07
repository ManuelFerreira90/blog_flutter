import 'dart:convert';

import 'package:blog_mobile/api/auth_service.dart';
import 'package:blog_mobile/models/comment.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/models/user.dart';

class FunctionsPost {
  static Future<List<Post>> convertPostToList(List<dynamic> posts) async {
    return Future.wait(posts.map((e) async {
      final response =
          await AuthService.fetchImageUserMakedPost(e['userId'].toString());
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return Post(
          id: e['id'],
          title: e['title'],
          body: e['body'],
          tags: List<String>.from(e['tags']),
          reactions: e['reactions'],
          views: e['views'],
          userId: e['userId'],
          imageUser: responseBody?['image'],
          fullName:
              "${responseBody?['firstName']} ${responseBody?['lastName']}",
          username: "@${responseBody?['username']}",
        );
      } else {
        return Post(
          id: e['id'],
          title: e['title'],
          body: e['body'],
          tags: e['tags'],
          reactions: e['reactions'],
          views: e['views'],
          userId: e['userId'],
          imageUser: null,
          fullName: 'Unknown',
          username: '@unknown',
        );
      }
    }).toList());
  }

  static Future<List<Comment>> convertCommentsToList(
      List<dynamic> comments) async {
    return Future.wait(comments.map((e) async {
      final response =
          await AuthService.fetchImageUserMakedPost(e['user']['id'].toString());
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return Comment(
          e['id'],
          e['body'],
          e['postId'],
          e['likes'],
          // ignore: prefer_interpolation_to_compose_strings
          User(e['user']['id'], e['user']['fullName'], null, null, '@' + e['user']['username'], responseBody['image'],
              null, null),
        );
      } else {
        return Comment(
          e['id'],
          e['body'],
          e['postId'],
          e['likes'],
          // ignore: prefer_interpolation_to_compose_strings
          User(e['user']['id'], e['user']['fullName'], null, null, '@' + e['user']['username'], null,
              null, null),
        );
      }
    }).toList());
  }
}
