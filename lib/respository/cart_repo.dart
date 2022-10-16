import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/order.dart';
import 'package:mvvm/res/app_url.dart';

class CartRepo {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> createOrder(OrderModel orderModel) async {
    try {
      var res = await _apiServices.getPostApiResponse(
          AppUrl.myurl + AppUrl.orders, orderModel);

      return res;
    } catch (e) {
      throw e;
    }
  }
}
