class CustomerModel {
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? username;

  CustomerModel(
      {this.email,
      this.firstName,
      this.lastName,
      this.username,
      this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map.addAll({
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "username": username,
    });

    return map;
  }
}
