import 'dart:convert';

class UserModel {
  String? token;
  int? custId;
  String? email;
  String? firstName;
  String? secName;

  UserModel(
      {this.token, this.custId, this.email, this.firstName, this.secName});

  static Map<String, dynamic> toMap(UserModel userModel) => {
        'id': userModel.custId,
        'email': userModel.email,
        'value': userModel.token,
        'first_name': userModel.firstName,
        'last_name': userModel.secName,
      };

  static String encode(List<dynamic> users) => json.encode(
        users
            .map<Map<String, dynamic>>((music) => UserModel.toMap(music))
            .toList(),
      );

  static List<UserModel> decode(String carts) =>
      (json.decode(carts) as List<dynamic>)
          .map<UserModel>((item) => UserModel.fromJson(item))
          .toList();

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['value'];
    custId = json['id'];
    email = json['email'];
    secName = json['last_name'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.token;
    data['id'] = this.custId;
    data['email'] = this.email;

    return data;
  }
}
