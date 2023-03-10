import 'dart:io';

import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  late User _user;
  File? _avatar;

  User get user => _user;
  File? get avatar => _avatar;

  void createUser(
      {required String name,
      required String lastName,
      required String birthdate,
      List<String> address = const [],
      File? avatar}) {
    final user = User(
        name: name, lastName: lastName, birthdate: birthdate, address: address);
    if (avatar != null) {
      _avatar = avatar;
      user.avatarUrl = _avatar!.path;
    }
    _user = user;
    notifyListeners();
  }

  void addAddress(String address) {
    _user.address.add(address);
    notifyListeners();
  }

  void updateAvatar(File image) {
    _avatar = image;
    _user.avatarUrl = _avatar!.path;
    notifyListeners();
  }
}
