import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/orderHistory.dart';
import 'package:mvvm/res/app_url.dart';

class OrderHistoryRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<List<OrderHistoryModel>> fetchOrderHistory(int id) async {
    try {
      dynamic response =
          await _apiServices.getOrderHistory(AppUrl.myurl + AppUrl.orders, id);
      List jsonResponse = response;
      return jsonResponse
          .map((data) => OrderHistoryModel.fromJson(data))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
