import 'dart:io';

import 'package:flutter/foundation.dart';

class RegisterProvider extends ChangeNotifier {
  String? _firstName;

  String? get firstName => _firstName;

  void setFirstName(String firstName) {
    if (_firstName != firstName) {
      _firstName = firstName;
      notifyListeners();
    }
  }

  String? _lastName;

  String? get lastName => _lastName;

  void setLastName(String lastName) {
    if (_lastName != lastName) {
      _lastName = lastName;
      notifyListeners();
    }
  }

  String? _about;

  String? get about => _about;

  void setAbout(String about) {
    if (_about != about) {
      _about = about;
      notifyListeners();
    }
  }

  List<int>? _skills;

  List<int>? get skills => _skills;

  void setSkills(List<int> skills) {
    _skills = skills;
    notifyListeners();
  }

  List<String>? _favoriteSocialMedia;

  List<String>? get favoriteSocialMedia => _favoriteSocialMedia;

  void setFavoriteSocialMedia(List<String> favoriteSocialMedia) {
    _favoriteSocialMedia = favoriteSocialMedia;
    notifyListeners();
  }

  int? _salary;

  int? get salary => _salary;

  void setSalary(int salary) {
    if (_salary != salary) {
      _salary = salary;
      notifyListeners();
    }
  }

  String? _password;

  String? get password => _password;

  void setPassword(String password) {
    if (_password != password) {
      _password = password;
      notifyListeners();
    }
  }

  String? _passwordConfirmation;

  String? get passwordConfirmation => _passwordConfirmation;

  void setPasswordConfirmation(String passwordConfirmation) {
    if (_passwordConfirmation != passwordConfirmation) {
      _passwordConfirmation = passwordConfirmation;
      notifyListeners();
    }
  }

  String? _email;

  String? get email => _email;

  void setEmail(String email) {
    if (_email != email) {
      _email = email;
      notifyListeners();
    }
  }

  String? _birthDate;

  String? get birthDate => _birthDate;

  void setBirthDate(String birthDate) {
    if (_birthDate != birthDate) {
      _birthDate = birthDate;
      notifyListeners();
    }
  }

  int? _gender;

  int? get gender => _gender;

  void setGender(int gender) {
    if (_gender != gender) {
      _gender = gender;
      notifyListeners();
    }
  }

  int? _userType;

  int? get userType => _userType;

  void setUserType(int userType) {
    if (_userType != userType) {
      _userType = userType;
      notifyListeners();
    }
  }

  File? _avatar;

  File? get avatar => _avatar;

  void setAvatar(File avatar) {
    if (_avatar != avatar) {
      _avatar = avatar;
      notifyListeners();
    }
  }
}
