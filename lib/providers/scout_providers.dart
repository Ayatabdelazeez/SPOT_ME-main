import 'dart:io';

import 'package:flutter/material.dart';

class ScoutProvider extends ChangeNotifier {
  String scoutName = "Ahly Club Scout";
  String phone = "";
  String email = "";
  String city = "";
  String club = "Al Ahly";

  File? profileImage;

  void updateProfile({
    required String scoutName,
    required String phone,
    required String email,
    required String city,
    required String club,
    File? profileImage,
  }) {
    this.scoutName = scoutName;
    this.phone = phone;
    this.email = email;
    this.city = city;
    this.club = club;

    if (profileImage != null) {
      this.profileImage = profileImage;
    }

    notifyListeners();
  }
}
