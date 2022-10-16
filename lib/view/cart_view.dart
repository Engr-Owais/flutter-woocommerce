import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/view_model/cartViewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/components/round_button.dart';
import 'Widget/FormField.dart';

class CartView extends StatefulWidget {
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartModel cartModel = CartModel();
  late TextEditingController _firstName;
  late TextEditingController _secName;
  late TextEditingController _adress;
  late TextEditingController _country;
  late TextEditingController _state;
  late TextEditingController _postCode;

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController();
    _secName = TextEditingController();
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

                                  // if (prefs.containsKey('userData')) {
                                  //   final extractedUserData = json.decode(
                                  //           prefs.getString('userData')!)
                                  //       as Map<String, dynamic>;
                                  //   cartProvider.orderApi(
                                  //     OrderModel(
                                  //       customer_id:
                                  //           extractedUserData['userId'],
                                  //       billing: Billing(
                                  //           firstName: "John",
                                  //           lastName: "Doe",
                                  //           address1: "969 Market",
                                  //           address2: "",
                                  //           city: "San Francisco",
                                  //           state: "CA",
                                  //           postcode: "94103",
                                  //           country: "US",
                                  //           email:
                                  //               extractedUserData['userEmail'],
                                  //           phone: "022222222"),
                                  //       shippingLines: [
                                  //         ShippingLines(
                                  //           total: value.sum.toString(),
                                  //         ),
                                  //       ],
                                  //       lineItems: value.cart,
                                  //     ),
                                  //     context,
                                  //   );
                                  // }

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
                                },
                              )
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
