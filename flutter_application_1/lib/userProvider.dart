import 'package:flutter/material.dart';
import 'package:flutter_application_1/currentUser.dart';

class UserProvider extends ChangeNotifier {
  CurrentUser? _user;

  CurrentUser? get user => _user;

  void setUser(CurrentUser user) {
    _user = user;
    notifyListeners();
  }
}