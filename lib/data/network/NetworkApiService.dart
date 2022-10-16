// import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';
import 'package:mvvm/data/app_excaptions.dart';
import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/model/customer.dart';
import 'package:mvvm/model/order.dart';
// import 'package:mvvm/model/products.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future<dynamic> getGetApiResponse(
      {String? url,
      String? catId,
      String? search,
      int? pageNum,
      int? pageSize}) async {
    dynamic responseJson;

    Map<String, dynamic> queryParams = {
      "consumer_key": "ck_d47bdf50021f8af4339a61d72d9a37077cb6f274",
      "consumer_secret": "cs_a3aedead188d4dd4987def04e3662dfcce63db51",
    };

    if (catId != null) {
      queryParams.addAll({
        'category': catId,
      });
    }

    if (search != null) {
      queryParams.addAll({
        'search': search,
      });
    }

    if (pageNum != null) {
      queryParams.addAll({
        'page': pageNum,
      });
    }

    if (pageSize != null) {
      queryParams.addAll({
        'per_page': pageSize,
      });
    }

    print("queryParams.values ${queryParams.values}");

    try {
      final response = await dio.Dio().get(
        url!,
        queryParameters: queryParams,
      );
      responseJson = returnResponse(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  Future<dynamic> getOrderHistory(String url, int id) async {
    dynamic responseJson;

    Map<String, dynamic> queryParams = {
      "consumer_key": "ck_d47bdf50021f8af4339a61d72d9a37077cb6f274",
      "consumer_secret": "cs_a3aedead188d4dd4987def04e3662dfcce63db51",
      'customer': id,
    };

    try {
      final response = await dio.Dio().get(
        url,
        queryParameters: queryParams,
      );
      responseJson = returnResponse(response);
      print("Order History = $responseJson");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future<dynamic> getCatResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await dio.Dio().get(
        url,
        queryParameters: {
          "consumer_key": "ck_d47bdf50021f8af4339a61d72d9a37077cb6f274",
          "consumer_secret": "cs_a3aedead188d4dd4987def04e3662dfcce63db51",
        },
      );
      responseJson = returnResponse(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future<dynamic> getApiResponse(String url) async {
    dynamic responseJson;

    try {
      for (var v = 1; v < 95; v++) {
        final response = await dio.Dio().get(
          url,
          queryParameters: {
            "consumer_key": "ck_d47bdf50021f8af4339a61d72d9a37077cb6f274",
            "consumer_secret": "cs_a3aedead188d4dd4987def04e3662dfcce63db51",
            "page": v
          },
        );
        responseJson = returnResponse(response);
        print("MYYYYYYY $responseJson");
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future<dynamic> getPostApiResponse(String url, OrderModel data) async {
    dio.Response res;
    dynamic finalRes;
    try {
      res = await dio.Dio().post(
        url,
        data: data.toJson(),
        queryParameters: {
          "consumer_key": "ck_d47bdf50021f8af4339a61d72d9a37077cb6f274",
          "consumer_secret": "cs_a3aedead188d4dd4987def04e3662dfcce63db51",
        },
      );
      finalRes = returnResponse(res);

      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return finalRes;
  }

  @override
  Future<dynamic> getTokenSignUp(String url, CustomerModel data) async {
    dynamic responseJson;
    try {
      print("ENTERT");
      final response = await http
          .post(
            Uri.parse(url +
                "?consumer_key=ck_d47bdf50021f8af4339a61d72d9a37077cb6f274&consumer_secret=cs_a3aedead188d4dd4987def04e3662dfcce63db51"),
            body: data.toJson(),
          )
          .timeout(const Duration(seconds: 10));
      print(response);
      responseJson = returnHttpResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Conection");
    }

    //if true then it'll return jso respose
    return responseJson;
  }

  dynamic returnHttpResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(jsonDecode(response.body)['message']);
      case 500:
      case 404:
      case 401:
        throw UnauthorisedException(jsonDecode(response.body)['message']);
      default:
        throw FetchDataException(
            "Error occured while communicating with server" +
                "with ctatus code" +
                response.statusCode.toString());
    }
  }

  returnResponse(dio.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;
      case 201:
        dynamic responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException(response.data);
      case 500:
      case 404:
        throw UnauthorisedException(response.statusMessage);
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
