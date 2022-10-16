import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/orderHistory.dart';
import 'package:mvvm/respository/order_history_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/response/api_response.dart';

class OrderHistoryViewModel with ChangeNotifier {
  final _myRepo = OrderHistoryRepository();

  ApiResponse<List<OrderHistoryModel>> orderList = ApiResponse.loading();

  int? userId;

  setOrderList(ApiResponse<List<OrderHistoryModel>> response) {
    orderList = response;
    notifyListeners();
  }

  Future<void> fetchOrderHistory() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      final extractedUserData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

      setOrderList(ApiResponse.loading());
      _myRepo.fetchOrderHistory(extractedUserData['userId']).then((value) {
        setOrderList(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        setOrderList(ApiResponse.error(error.toString()));
      });
    } else {
      print("ORDER ELSE");
      setOrderList(ApiResponse.loading());
      _myRepo.fetchOrderHistory(50).then((value) {
        setOrderList(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        setOrderList(ApiResponse.error(error.toString()));
      });
    }
  }
}
