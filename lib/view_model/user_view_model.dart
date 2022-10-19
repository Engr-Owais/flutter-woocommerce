

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  // Future saveUser(List<dynamic> userData) async {
  //   final sp = await SharedPreferences.getInstance();
  //   String encodedData = UserModel.encode(userData);
  //   await sp.setString('userData', encodedData);
  //   notifyListeners();
  // }

  // Future getUser() async {
  //   final sp = await SharedPreferences.getInstance();

  //   if (sp.containsKey('userData')) {
  //     String? dataUser = await sp.getString('userData');
  //     return jsonDecode(dataUser!);
  //   } else {
  //     String? dataUser = "null";
  //     return jsonDecode(dataUser);
  //   }
  // }

  
  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
