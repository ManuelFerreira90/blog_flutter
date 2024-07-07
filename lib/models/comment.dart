import 'package:blog_mobile/models/user.dart';

class Comment {
  int? _id;
  String? _body;
  int? _postId;
  int? _likes;
  User? _user;
  bool _like = false;

  Comment(int? id, String? body, int? postId, int? likes, User user) {
    _id = id;
    _body = body;
    _postId = postId;
    _likes = likes;
    _user = user;
  }

  set setBody(String body){
    _body = body;
  }

  set setLike(bool like) {
    _like = like;
  }

  set setLikes(int likes) {
    _likes = likes;
  }

  set setUser(User user) {
    _user = user;
  }

  User? get getUser {
    return _user;
  }

  bool get getLike {
    return _like;
  }

  int? get getId {
    return _id;
  }

  String? get getBody {
    return _body;
  }

  int? get getPostId {
    return _postId;
  }

  int? get getLikes {
    return _likes;
  }

  Map<String, dynamic> toMap() {
    if (_id != null) {
      final map = <String, dynamic>{
        'id': _id,
        'body': _body,
        'post_id': _postId,
        'likes': _likes,
        'user': _user,
      };
      return map;
    } else {
      var map = <String, dynamic>{
        'body': _body,
        'post_id': _postId,
        'likes': _likes,
        'user': _user,
      };
      return map;
    }
  }

  Comment.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _body = map['body'];
    _postId = map['postId'];
    _likes = map['likes'];
    _user = null;
  }

  @override
  String toString() {
    return 'Comment{id: $_id, body: $_body, post_id: $_postId, likes: $_likes, user: $_user}';
  }
}
