class Comment {
  int? _id;
  String? _body;
  int? _postId;
  int? _likes;
  Map<String, dynamic>? _user;

  Comment(int? id, String? body, int? postId, int? likes,
      Map<String, dynamic>? user) {
    _id = id;
    _body = body;
    _postId = postId;
    _likes = likes;
    _user = user;
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

  Map<String, dynamic>? get getUser {
    return _user;
  }
}
