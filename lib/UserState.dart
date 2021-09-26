import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserState extends ChangeNotifier {
  User? user;
  User? player;

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }

  void setPlayer(User newUser) {
    player = newUser;
    notifyListeners();
  }
}
