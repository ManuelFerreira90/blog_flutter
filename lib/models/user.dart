class User {
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _userName;
  String? _birthDate;
  String? _image;
  String? _country;
  String? _phone;

  User(
      int? id,
      String? firstName,
      String? lastName,
      String? email,
      String? userName,
      String? birthDate,
      String? image,
      String? country,
      String? phone) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _userName = userName;
    _birthDate = birthDate;
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

  String? get birthDate {
    return _birthDate;
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
}
