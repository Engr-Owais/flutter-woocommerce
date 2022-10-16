import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/res/app_url.dart';

import '../model/customer.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  // Future<dynamic> loginApi(dynamic data) async {
  //   try {
  //     dynamic response =
  //         await _apiServices.getPostApiResponse(AppUrl.loginEndPint, data);
  //     return response;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<dynamic> createAccount(dynamic customerModel) async {
    print("ssdad");
    dynamic res =
        await _apiServices.getTokenSignUp(AppUrl.signup, customerModel);
    try {
      return res;
    } catch (e) {
      throw e;
    }
  }

  // Future<dynamic> signUpApi(dynamic data) async {
  //   try {
  //     dynamic response = await _apiServices.getPostApiResponse(
  //         AppUrl.registerApiEndPoint, data);
  //     return response;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
