import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/respository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) async {
      setLoading(false);
      final prefs = await SharedPreferences.getInstance();

      final loginUserData = json.encode({
        'token': value['data']['token'],
        'displayName': value['data']['displayName'],
        'userEmail': value['data']['email'],
        'firstName': value['data']['firstName'],
        'lastName': value['data']['lastName'],
        'userId': value['data']['id'],
      });

      if (prefs.containsKey('userData')) {
        prefs.clear();
        prefs.setString('userData', loginUserData);
      } else {
        prefs.setString('userData', loginUserData);
      }
      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    print("object");
    setSignUpLoading(true);

    _myRepo.createAccount(data).then((value) async {
      setSignUpLoading(false);
      print("YAAN");

      final prefs = await SharedPreferences.getInstance();

      final userdata = json.encode({
        'token': value['meta_data'][0]['value'],
        'userId': value['id'],
        'userEmail': value['email'],
        'firstName': value['first_name'],
        'lastName': value['last_name'],
      });

      if (prefs.containsKey('userData')) {
        prefs.clear();
        prefs.setString('userData', userdata);
      } else {
        prefs.setString('userData', userdata);
      }

      // String encodedData = UserModel.encode(userData);
      // await prefs.setString('userData', encodedData);

      Utils.flushBarErrorMessage("Succes", context);

      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
