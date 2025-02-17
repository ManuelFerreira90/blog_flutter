import 'dart:convert';
import 'dart:io';

import 'package:blog_mobile/api/endpoints.dart';
import 'package:blog_mobile/models/comment.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>> login(
      String userName, String password) async {
    try {
      var url = Uri.https(Endpoints.urlApi, Endpoints.authLogin);
      Map<String, dynamic> body = {
        'username': userName.trim(),
        'password': password.trim(),
        'expiresInMins': 60,
      };

      var jsonBody = jsonEncode(body);

      final response = await http.post(url,
          body: jsonBody, headers: {'Content-Type': 'application/json'});

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('accessToken', responseBody['accessToken']);
        return {
          'sucess': true,
        };
      } else {
        return {
          'sucess': false,
          'error': responseBody['message'],
        };
      }
    } catch (error) {
      if (error is HttpException) {
        return {
          'sucess': false,
          'error': 'Network error: ${error.message}',
        };
      } else if (error is FormatException) {
        return {
          'sucess': false,
          'error': 'JSON parsing error: ${error.message}',
        };
      } else {
        return {
          'sucess': false,
          'error': 'Unexpected error: $error',
        };
      }
    }
  }

  static Future<Map<String, dynamic>?> currentAuthUser(String token) async {
    try {
      var url = Uri.https(Endpoints.urlApi, Endpoints.authMe);
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        return map;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> register(
      String userName, String phone, String email, String password) async {
    try {
      var url = Uri.https(Endpoints.urlApi, Endpoints.addUser);
      Map<String, dynamic> body = {
        'username': userName.trim(),
        'phone': phone.trim(),
        'email': email.trim(),
        'password': password.trim(),
      };

      var jsonBody = jsonEncode(body);

      final response = await http.post(url,
          body: jsonBody, headers: {'Content-Type': 'application/json'});
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {'sucess': true, 'user': responseBody};
      } else {
        return {'sucess': false, 'error': '${responseBody['message']}'};
      }
    } catch (error) {
      if (error is HttpException) {
        return {
          'sucess': false,
          'error': 'Network error: ${error.message}',
        };
      } else if (error is FormatException) {
        return {
          'sucess': false,
          'error': 'JSON parsing error: ${error.message}',
        };
      } else {
        return {
          'sucess': false,
          'error': 'Unexpected error: $error',
        };
      }
    }
  }

  static Future<http.Response> fecthPosts(int skip) async {
    final url = Uri.https(
      Endpoints.urlApi,
      Endpoints.posts,
      {'skip': '$skip'},
    );
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> fetchImageUserMakedPost(String id) async {
    final url = Uri.https(Endpoints.urlApi, '${Endpoints.getUser}/$id',
        {'select': 'image,firstName,lastName,username'});
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> fetchSearchPosts(String search, int skip) async {
    final url = Uri.https(
      Endpoints.urlApi,
      Endpoints.searchPost,
      {'q': search, 'skip': '$skip'},
    );
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> fetchMyPosts(int id) async {
    final url = Uri.https(Endpoints.urlApi, '${Endpoints.getPostsUser}/$id');
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> fetchPostTags() async {
    final url = Uri.https(Endpoints.urlApi, Endpoints.postTagList);
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> fetchPostByTags(String tag, int skip) async {
    final url = Uri.https(
      Endpoints.urlApi,
      '${Endpoints.postByTag}/$tag',
      {'skip': '$skip'},
    );
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> fetchCommentsByPost(int id) async {
    final url =
        Uri.https(Endpoints.urlApi, '${Endpoints.getCommentByPost}/$id');
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> updateUser(User user) async {
    final url = Uri.https(
      Endpoints.urlApi,
      '${Endpoints.updateUser}/${user.id == 209 ? 1 : user.id}',
    );
    final body = jsonEncode(user.toMap());
    final response = await http.put(
      url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  static Future<http.Response> deletePost(int id) async {
    final url = Uri.https(Endpoints.urlApi, '${Endpoints.deletePost}/$id');
    final response = await http.delete(url);
    return response;
  }

  static Future<http.Response> updatePost(Post post) async {
    final url = Uri.https(Endpoints.urlApi, '${Endpoints.updatePost}/${post.getId}');
    final body = jsonEncode(post.toMap());
    final response = await http.put(url, body: body, headers: { 'Content-Type': 'application/json' });
    return response;
  }

  static Future<http.Response> addPost(Post post) async {
    final url = Uri.https(Endpoints.urlApi, Endpoints.addPost);
    final body = jsonEncode(post.toMap());
    final response = await http.post(url, body: body, headers: { 'Content-Type': 'application/json' });
    return response;
  }

  static Future<http.Response> addComment(Comment comment) async {
    final url = Uri.https(Endpoints.urlApi, Endpoints.addComment);
    final body = jsonEncode(comment.toMap());
    final response = await http.post(url, body: body, headers: { 'Content-Type': 'application/json' });
    return response;
  }
}
