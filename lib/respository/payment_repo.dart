import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/payment.dart';
import 'package:mvvm/res/app_url.dart';

class PayRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<Payment> fetchPayMethod() async {
    try {
      dynamic response = await _apiServices.getPaymentDetails(
        AppUrl.myurl + AppUrl.payment,
      );

      return Payment.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
