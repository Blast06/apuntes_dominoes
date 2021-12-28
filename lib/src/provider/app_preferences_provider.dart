


import 'dart:core';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesProvider with ChangeNotifier {

  String version;

  bool _openModal = false;
   
  AppPreferencesProvider(this.version);

  late SharedPreferences _preferences;


  initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setBool('sound', true);
    _preferences.setInt('limitScore', 100);
  }

  
  bool get openModal => _openModal;
  set openModal(bool value){
    _openModal = value;
    notifyListeners();
  } 


  set limitScore(int value){
    _preferences.setInt('limitScore', value);
    notifyListeners();
  }

  int get limitScore => _preferences.getInt('limitScore')!;

  set sound(bool value){
    _preferences.setBool('sound', value);
    notifyListeners();
  }

  bool get sound => _preferences.getBool('sound')!;


}