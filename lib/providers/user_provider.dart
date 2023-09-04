import 'package:flutter/material.dart';
import 'package:foodapplication/models/user.dart';

import '../models/product.dart';

class UserProvider extends ChangeNotifier {


  
  User _user = User(
    id: '',
    email: '',
    password: '',
    username: '',
    birth: '',
    adress: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
