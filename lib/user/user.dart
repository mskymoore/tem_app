import 'dart:async';
import 'package:tem_app/models/models.dart';
import 'package:tem_app/rest/auth.dart';

class UserRepo {
  User _user;

  Future<User> getUser() async {
    if (_user != null) return _user;

    this._user = await usersMe();
    return this._user;
  }
}
