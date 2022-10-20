// import 'dart:convert';

import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/category.dart';
// import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/model/products.dart';
import 'package:mvvm/res/app_url.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<List<ProductsModel>> fetchProductsList(
      String catId, String search, int pageNum) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        url: AppUrl.myurl + AppUrl.products,
        catId: catId,
        search: search,
        pageNum: pageNum,
      );
      List jsonResponse = response;
      return jsonResponse.map((data) => ProductsModel.fromJson(data)).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<CategoryModel>> fetchCatList() async {
    try {
      dynamic response = await _apiServices
          .getCatResponse(AppUrl.myurl + AppUrl.categoriesURL);
      List jsonResponse = response;
      return jsonResponse.map((data) => CategoryModel.fromJson(data)).toList();
    } catch (e) {
      throw e;
    }
  }

  Future oductsList() async {
    await _apiServices.getApiResponse(AppUrl.myurl + AppUrl.products);
  }
}
