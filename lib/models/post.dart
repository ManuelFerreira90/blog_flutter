class Post {
  int? _id;
  String? _body;
  List<dynamic>? _tags;
  Map<String, dynamic>? _reactions;
  int? _views;
  int? _userId;

  Post(int? id, String? body, List<dynamic>? tags, Map<String, dynamic>? reactions,
      int? views, int? userId) {
    _id = id;
    _body = body;
    _tags = tags;
    _reactions = reactions;
    _views = views;
    _userId = userId;
  }

  int? get getId {
    return _id;
  }

  String? get getBody {
    return _body;
  }

  List<dynamic>? get getTags {
    return _tags;
  }

  Map<String, dynamic>? get getReactions {
    return _reactions;
  }

  int? get getViews {
    return _views;
  }

  int? get getUserId {
    return _userId;
  }
}
