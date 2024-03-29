import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cartItem.dart';

class DetailViewViewModel with ChangeNotifier {
  int _quantityOfProducts = 0;
  num get quantity => _quantityOfProducts;
  List<Cart> _cartItems = [];
  num get cartLength => _cartItems.length;
  num? sum;

  num _value = 0;

  num get value => _value;

  CartCounterNotifier({List? cartItems}) async {
    final prefs = await SharedPreferences.getInstance();
    List cartItemsLenth = [];
    if (prefs.containsKey('cartData')) {
      String? items = await prefs.getString('cartData');
      cartItemsLenth = Cart.decode(items!);
      _value = cartItemsLenth.length;
    } else {
      if (cartItems!.isNotEmpty) {
        _value = cartItems.length;
      } else {
        _value = 0;
      }
    }

    notifyListeners();
  }

  incProduct(num stock) {
    print(stock.toString() + " " + _quantityOfProducts.toString());
    if (_quantityOfProducts != stock) {
      _quantityOfProducts = _quantityOfProducts + 1;
    } else {
      Fluttertoast.showToast(msg: 'Stock Quantity Of Product Is Ended');
    }
    notifyListeners();
  }

  decProduct(num stock) {
    if (_quantityOfProducts != 0) {
      _quantityOfProducts = _quantityOfProducts - 1;
    } else {
      Fluttertoast.showToast(msg: 'Sorry You Cannot Decrease More');
    }
    notifyListeners();
  }

  addToCart(int prodId, num quantity, String name, num price) async {
    final prefs = await SharedPreferences.getInstance();
    List<Cart> cartItems = [];

    var IssharedCartData = prefs.containsKey('cartData');
    if (IssharedCartData) {
      String? items = await prefs.getString('cartData');
      cartItems = Cart.decode(items!);
      print(cartItems);
      CartCounterNotifier(cartItems: cartItems);
    }
    var cartIndex = cartItems.indexWhere((element) => element.prodId == prodId);

    if (cartIndex == -1) {
      final userId =
          jsonDecode(prefs.getString('userData')!) as Map<String, dynamic>;
      print("userId['userId'] ${userId['userId']}");
      sum = cartItems.fold(0, (sum, element) => sum! + element.price!);
      cartItems.add(Cart(
          prodId: prodId,
          quantity: quantity,
          name: name,
          price: price * quantity,
          sum: sum,
          userId: userId['userId']));
      CartCounterNotifier(cartItems: cartItems);
    } else {
      num? item = cartItems[cartIndex].quantity! + 1;
      num? pricing = cartItems[cartIndex].price! * item;
      cartItems[cartIndex].quantity = item;
      cartItems[cartIndex].price = pricing;
    }

    String encodedData = Cart.encode(cartItems);
    await prefs.setString('cartData', encodedData);

    notifyListeners();
  }
}
