import 'package:mvvm/model/customer.dart';
import 'package:mvvm/model/order.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(
      {String? url,
      String? catId,
      String? search,
      int? pageNum,
      int? pageSize});

  Future<dynamic> getCatResponse(String url);
//
  Future<dynamic> getOrderHistory(String url, int id);

  Future<dynamic> getApiResponse(String url);

  Future<dynamic> getPaymentDetails(String url);

  Future<dynamic> getPostApiResponse(String url, OrderModel data);

  Future<dynamic> loginAPi(String url, dynamic data);

  Future<dynamic> getTokenSignUp(String url, CustomerModel data);
}
