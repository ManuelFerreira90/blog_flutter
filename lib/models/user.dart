class User {
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _userName;
  String? _image;
  String? _country;
  String? _phone;

  User(
      int? id,
      String? firstName,
      String? lastName,
      String? email,
      String? userName,
      String? image,
      String? country,
      String? phone) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _userName = userName;
    _image = image;
    _country = country;
    _phone = phone;
  }

  int? get id {
    return _id;
  }

  String? get firstame {
    return _firstName;
  }

  String? get lastName {
    return _lastName;
  }

  String? get email {
    return _email;
  }

  String? get userName {
    return _userName;
  }

  String? get image {
    return _image;
  }

  String? get country {
    return _country;
  }

  String? get phone {
    return _phone;
  }

  set setFirstName(String? firstName) {
    _firstName = firstName;
  }

  set setLastName(String? lastName) {
    _lastName = lastName;
  }

  set setEmail(String? email) {
    _email = email;
  }

  set setUserName(String? userName) {
    _userName = userName;
  }

  set setImage(String? image) {
    _image = image;
  }

  set setCountry(String? country) {
    _country = country;
  }

  set setPhone(String? phone) {
    _phone = phone;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _id == 209 ? 1 : _id,
      'firstName': _firstName ?? '',
      'lastName': _lastName ?? '',
      'email': _email,
      'username': _userName,
      'image': _image ?? '',
      'address' : {
        'country' : _country ?? '',
      },
      'phone': _phone
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _firstName = map['firstName'];
    _lastName = map['lastName'];
    _email = map['email'];
    _userName = map['username'];
    _image = map['image'];
    _country = map['address']['country'];
    _phone = map['phone'];
  }

  @override
  String toString() {
    return 'User{id: $_id, firstName: $_firstName, lastName: $_lastName, email: $_email, userName: $_userName, image: $_image, country: $_country, phone: $_phone}';
  }
}
