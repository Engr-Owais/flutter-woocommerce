import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/view_model/cartViewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/order.dart';
import '../res/components/round_button.dart';
import 'Widget/FormField.dart';

class CartView extends StatefulWidget {
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartModel cartModel = CartModel();
  late TextEditingController _adress;
  late TextEditingController _country;
  late TextEditingController _state;
  late TextEditingController _postCode;

  @override
  void initState() {
    super.initState();
    _adress = TextEditingController();
    _country = TextEditingController();
    _postCode = TextEditingController();
    _state = TextEditingController();
    cartModel.getCart();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);

    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider<CartModel>(
          create: (BuildContext context) => cartModel,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Consumer<CartModel>(
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        Expanded(
                            child: value.cart.isNotEmpty
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: value.cart.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: Text(
                                                  "${value.cart[index].price.toString()}"),
                                              title: Text(
                                                  "${value.cart[index].name}",
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              trailing: Text(
                                                  "${value.cart[index].quantity}"),
                                            );
                                          },
                                        ),
                                      ),
                                      Consumer<CartModel>(
                                        builder: (context, value, child) {
                                          return Text(
                                              "TOTAL [ ${value.sum.toString()} ]");
                                        },
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: Text("No Items In Cart"),
                                  )),
                        value.cart.isNotEmpty
                            ? RoundButton(
                                title: 'Order',
                                loading: cartProvider.orderLoading,
                                onPress: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();

                                  if (prefs.containsKey('userData') &&
                                      _adress.text != '') {
                                    final extractedUserData = json.decode(
                                            prefs.getString('userData')!)
                                        as Map<String, dynamic>;
                                    cartProvider.orderApi(
                                      OrderModel(
                                        customer_id:
                                            extractedUserData['userId'],
                                        billing: Billing(
                                            firstName:
                                                extractedUserData['firstName'],
                                            lastName:
                                                extractedUserData['lastName'],
                                            address1: _adress.text,
                                            address2: "",
                                            city: "",
                                            state: _state.text,
                                            postcode: "94103",
                                            country: _country.text,
                                            email:
                                                extractedUserData['userEmail'],
                                            phone: "022222222"),
                                        shippingLines: [
                                          ShippingLines(
                                            total: value.sum.toString(),
                                          ),
                                        ],
                                        paymentMethod: 'basc',
                                        shipping: Shipping(
                                          firstName:
                                              extractedUserData['firstName'],
                                          lastName:
                                              extractedUserData['lastName'],
                                          address1: _adress.text,
                                          address2: "",
                                          city: "",
                                          state: _state.text,
                                          postcode: "94103",
                                          country: _country.text,
                                        ),
                                        lineItems: value.cart,
                                      ),
                                      context,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration: Duration(
                                              milliseconds: 400,
                                            ),
                                            content: Text(
                                                "Please Fill Out The Details For Shipping")));
                                  }
                                },
                              )
                            : SizedBox(),
                        value.cart.isNotEmpty
                            ? MaterialButton(
                                child: Text("Add Details Of Address"),
                                color: Colors.blue,
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();

                                  if (prefs.containsKey('userData')) {
                                    final extractedUserData =
                                        jsonDecode(prefs.getString('userData')!)
                                            as Map<String, dynamic>;
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return Container(
                                          child: TestForm(
                                            context: context,
                                            loadingOrder: value.loading,
                                            firstName:
                                                extractedUserData['firstName'],
                                            secName:
                                                extractedUserData['lastName'],
                                            adress: _adress,
                                            country: _country,
                                            postCode: _postCode,
                                            state: _state,
                                          ),
                                        );
                                      },
                                    );
                                  }
                                })
                            : SizedBox(),
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}
