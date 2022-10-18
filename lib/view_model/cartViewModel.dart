import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/order.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/respository/cart_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cartItem.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view/webview_screen.dart';
import 'user_view_model.dart';

class CartModel with ChangeNotifier {
  List<Cart> _cartItems = [];
  List<Cart> get cart => _cartItems;
  CartRepo _cartRepo = CartRepo();
  bool _loading = false;
  bool get loading => _loading;

  List<UserModel> _userData = [];
  List<UserModel> get userData => _userData;

  bool _orderLoading = false;
  bool get orderLoading => _orderLoading;
  double? sum;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setOrderLoading(bool value) {
    _orderLoading = value;
    notifyListeners();
  }

  // getUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var IssharedCartData = prefs.containsKey('userData');
  //   if (IssharedCartData) {
  //     String? users = prefs.getString('userData');
  //     _userData = UserModel.decode(users!);
  //   }

  //   notifyListeners();
  // }

  getCart() async {
    final prefs = await SharedPreferences.getInstance();
    var IssharedCartData = prefs.containsKey('cartData');

    var extractUser =
        jsonDecode(prefs.getString('userData')!) as Map<String, dynamic>;
    if (IssharedCartData) {
      String? items = await prefs.getString('cartData');

      List<Cart> allItems = Cart.decode(items!);
      _cartItems = allItems.where((element) {
        print("element.userId ${element.userId} "
            "hehehe"
            " ${extractUser['userId']}");
        return element.userId == extractUser['userId'];
      }).toList();
      sum = _cartItems.fold(0, (sum, element) => sum! + element.price!);
    }

    notifyListeners();
  }

  Future orderApi(OrderModel data, BuildContext context) async {
    setOrderLoading(true);
    final prefs = await SharedPreferences.getInstance();

    _cartRepo.createOrder(data).then((value) {
      setOrderLoading(false);
      Utils.flushBarErrorMessage('Order Placed Successfully', context);
      prefs.remove('cartData');

      
      Navigator.pushReplacementNamed(context, RoutesName.payment);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setOrderLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
