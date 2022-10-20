import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  void checkAuthentication(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      print("sshshshshs");

      await Future.delayed(Duration(seconds: 3));
      Navigator.pushNamed(context, RoutesName.home);
    } else {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushNamed(context, RoutesName.signUp);
    }
  }
}
