import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/category.dart';
import 'package:mvvm/model/products.dart';
import 'package:mvvm/respository/home_repository.dart';

enum LodeMoreStatus { INITIAL, LOADING, STABLE }

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<List<ProductsModel>> productsList = ApiResponse.loading();
  ApiResponse<List<CategoryModel>> catList = ApiResponse.loading();

  List<ProductsModel> prod = [];
  String _catName = 'All';
  String get catName => _catName;
  String chipSelected = '';
  int? coloredChip;

  List<ProductsModel> allProd = [];
  // int pageSize = 10;

  LodeMoreStatus _lodeMoreStatus = LodeMoreStatus.STABLE;

  getLoadMoreStatus() => _lodeMoreStatus;

  setLoadingStatus(LodeMoreStatus lodeMoreStatus) {
    _lodeMoreStatus = lodeMoreStatus;
    notifyListeners();
  }

  setProdList(ApiResponse<List<ProductsModel>> response) {
    productsList = response;
    notifyListeners();
  }

  setChip(String val, int index) {
    chipSelected = val;
    coloredChip = index;
    notifyListeners();
  }

  setCatProdList(List<ProductsModel> productss) {
    prod = productss;
    notifyListeners();
  }

  setCatList(ApiResponse<List<CategoryModel>> response) {
    catList = response;
    notifyListeners();
  }

  setCat(String value) {
    _catName = value;
    notifyListeners();
  }

  Future<void> fetchProdListApi(
      int pageNum, String catId, String search) async {
    
    setProdList(ApiResponse.loading());

    _myRepo.fetchProductsList(catId, search, pageNum).then((value) {
      allProd.addAll(value);

      setLoadingStatus(LodeMoreStatus.STABLE);
      setProdList(ApiResponse.completed(allProd));
    }).onError((error, stackTrace) {
      setProdList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  fetchCatProducts(int catId) {
    List<ProductsModel> listOfCatProd = productsList.data!
        .where((element) => element.categories!.first.id == catId)
        .toList();

    print("listOfCatProd $listOfCatProd");
    setCatProdList(listOfCatProd);

    notifyListeners();
  }

  Future<void> fetchCatListApi() async {
    setCatList(ApiResponse.loading());

    _myRepo
        .fetchCatList()
        .then((value) => {setCatList(ApiResponse.completed(value))})
        .onError((error, stackTrace) => {
              setCatList(ApiResponse.error(error.toString())),
            });
    notifyListeners();
  }
}
