import 'dart:io';

import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier {
  String playerName = "Player Name";
  String phone = "";
  String email = "";
  String city = "";
  String nationality = "";
  String selectedSport = "Football";

  int age = 19;
  String height = "181 cm";
  String weight = "72 kg";
  String position = "Midfielder";
  String club = "Al Ahly";
  String experience = "3 years";
  String bio =
      "Passionate football player with 3 years of experience playing as a midfielder. Always looking to improve my skills and reach a professional level.";
  int goals = 24;
  int assists = 15;
  int matches = 42;

  File? profileImage;

  void updateProfile({
    required String playerName,
    required String phone,
    required String email,
    required String city,
    required String nationality,
    File? profileImage,
  }) {
    this.playerName = playerName;
    this.phone = phone;
    this.email = email;
    this.city = city;
    this.nationality = nationality;

    if (profileImage != null) {
      this.profileImage = profileImage;
    }

    notifyListeners();
  }

  void updateSport(String sport) {
    selectedSport = sport;
    notifyListeners();
  }
}
