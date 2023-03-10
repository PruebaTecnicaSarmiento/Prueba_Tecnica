import 'package:flutter/material.dart';

class UserRegistrationController {
  final userProvider;
  UserRegistrationController({required this.userProvider});

  void createUser(
      {required String name,
      required String lastName,
      required String birthdate,
      required List<String> address}) {
    userProvider.createUser(
        name: name, lastName: lastName, birthdate: birthdate, address: address);
  }

  void addAddress({required String address}) {
    userProvider.addAddress(address);
  }
}
