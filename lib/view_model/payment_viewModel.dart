import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/payment.dart';

import '../respository/payment_repo.dart';

class PaymentViewModel with ChangeNotifier {
  final _myRepo = PayRepository();

  String _id = '';
  String _title = '';
  String _description = '';
  bool _enabled = false;
  String _methodTitle = '';
  String _methodDescription = '';

  String get id => _id;
  String get title => _title;
  String get description => _description;
  bool get enabled => _enabled;
  String get methodTitle => _methodTitle;
  String get methodDescription => _methodDescription;

  bool _payLoading = false;
  bool get payLoading => _payLoading;

  setOrderLoading(bool value) {
    _payLoading = value;
    notifyListeners();
  }

  setValues({String? id, String? title, String? description, String? methodTitle,
      String? methodDescription, bool? enabled}) {
    id = id;
    title = title;
    description = description;
    methodTitle = methodTitle;
    methodDescription = methodDescription;
    enabled = enabled;
    notifyListeners();
  }

  Future<Payment> fetching() async {
    setOrderLoading(true);
    return _myRepo.fetchPayMethod().whenComplete(() => setOrderLoading(false));
  }
}
