import 'dart:convert';

class Cart {
  int? prodId;
  num? quantity;
  int? userId;
  String? name;
  num? price;
  num? sum;

  Cart({this.prodId, this.quantity, this.name, this.price, this.userId , this.sum});

  factory Cart.fromJson(Map<String, dynamic> jsonData) {
    return Cart(
      prodId: jsonData['prodId'],
      quantity: jsonData['quantity'],
      name: jsonData['name'],
      price: jsonData['price'],
      userId: jsonData['userId'],
      sum: jsonData['sum']
    );
  }

  static Map<String, dynamic> toMap(Cart music) => {
        'prodId': music.prodId,
        'quantity': music.quantity,
        'name': music.name,
        'price': music.price,
        'userId': music.userId,
        'sum':music.sum,
      };

  static String encode(List<Cart> carts) => json.encode(
        carts.map<Map<String, dynamic>>((music) => Cart.toMap(music)).toList(),
      );

  static List<Cart> decode(String carts) =>
      (json.decode(carts) as List<dynamic>)
          .map<Cart>((item) => Cart.fromJson(item))
          .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.prodId;
    data['quantity'] = this.quantity;
    return data;
  }
}
