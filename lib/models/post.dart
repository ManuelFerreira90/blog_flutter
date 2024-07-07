class Post {
  int? _id;
  String? _title;
  String? _body;
  List<dynamic>? _tags;
  Map<String, dynamic>? _reactions;
  int? _views;
  int? _userId;
  String? _imageUser;
  String? _fullName;
  String? _username;
  bool _like = false;
  bool _dislike = false;

  Post(
      {int? id,
      String? title,
      String? body,
      List<dynamic>? tags,
      Map<String, dynamic>? reactions,
      int? views,
      int? userId,
      String? imageUser,
      String? fullName,
      String? username}) {
    _id = id;
    _title = title;
    _body = body;
    _tags = tags;
    _reactions = reactions;
    _views = views;
    _userId = userId;
    _imageUser = imageUser;
    _fullName = fullName;
    _username = username;
  }

  set imageUser(String? image) {
    _imageUser = image;
  }

  set fullName(String name) {
    _fullName = name;
  }

  set username(String username) {
    _username = username;
  }

  set setLikes(int likes) {
    _reactions?['likes'] = likes;
  }

  set setDislikes(int dislikes) {
    _reactions?['dislikes'] = dislikes;
  }

  set setLike(bool like) {
    _like = like;
  }

  set setDislike(bool dislike) {
    _dislike = dislike;
  }

  set setTitle(String title) {
    _title = title;
  }

  String? get getImageUser {
    return _imageUser;
  }

  String? get getFullName {
    return _fullName;
  }

  String? get getUserName {
    return _username;
  }

  bool get getLike {
    return _like;
  }

  bool get getDislike {
    return _dislike;
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

  String? get getTitle {
    return _title;
  }

  set title(String title) {
    _title = title;
  }

  set body(String body) {
    _body = body;
  }

  set tags(List<dynamic> tags) {
    _tags = tags;
  }

  set reactions(Map<String, dynamic> reactions) {
    _reactions = reactions;
  }

  set views(int views) {
    _views = views;
  }

  set userId(int userId) {
    _userId = userId;
  }

  Map<String, dynamic> toMap() {
    if (_id != null) {
      final map = <String, dynamic>{
        'id': _id == 252 ? 1 : _id,
        'title': _title,
        'body': _body,
        'tags': _tags,
        'reactions': _reactions,
        'views': _views,
        'userId': _userId,
      };
      return map;
    } else {
      final map = <String, dynamic>{
        'title': _title,
        'body': _body,
        'userId': _userId,
        'views': '0',
        'reactions': {
          'likes': 0,
          'dislikes': 0,
        }
      };
      return map;
    }
  }

  Post.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _body = map['body'];
    _tags = map['tags'];
    _reactions = map['reactions'];
    _views = map['views'];
    _userId = map['userId'];
    _imageUser = map['imageUser'];
    _fullName = map['fullName'];
    _username = map['username'];
  }

  @override
  String toString() {
    return 'Post{_id: $_id, _title: $_title, _body: $_body, _tags: $_tags, _reactions: $_reactions, _views: $_views, _userId: $_userId, _imageUser: $_imageUser, _fullName: $_fullName, _username: $_username}';
  }
}
