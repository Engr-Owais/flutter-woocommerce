import 'package:flutter/material.dart';
import 'package:mvvm/model/products.dart';
import 'package:mvvm/view_model/detail_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class DeatilScreenView extends StatelessWidget {
  final DetailViewViewModel detailViewViewModel = DetailViewViewModel();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductsModel;
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.cart);
            },
            icon: Icon(Icons.shop),
          )
        ],
      ),
      body: ChangeNotifierProvider<DetailViewViewModel>(
        create: (BuildContext context) => detailViewViewModel,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Icon(
                      Icons.circle,
                      color: args.stockQuantity == null
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "${args.name}",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Text(
                args.price.isNotEmpty ? "${args.price}" : "No Price",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              Text(
                "${args.categories.first.name}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
              ),
              args.stockQuantity != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: FloatingActionButton.small(
                            heroTag: 'decProduct',
                            onPressed: args.stockQuantity != null
                                ? () {
                                    detailViewViewModel
                                        .decProduct(args.stockQuantity);
                                  }
                                : () {},
                            backgroundColor: args.stockQuantity != null
                                ? Colors.amber
                                : Colors.black,
                            child: Center(child: Icon(Icons.minimize_outlined)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Consumer<DetailViewViewModel>(
                            builder: (context, value, _) {
                          return Text(
                              "Quantity : ${value.quantity.toString()}");
                        }),
                        SizedBox(
                          width: 5,
                        ),
                        FloatingActionButton.small(
                          heroTag: 'incProduct',
                          onPressed: args.stockQuantity != null
                              ? () {
                                  detailViewViewModel
                                      .incProduct(args.stockQuantity);
                                }
                              : () {},
                          backgroundColor: args.stockQuantity != null
                              ? Colors.amber
                              : Colors.black,
                          child: Center(child: Icon(Icons.add)),
                        ),
                      ],
                    )
                  : Text(
                      "THIS PRODUCT IS OUT OF STOCK",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
              args.stockQuantity != null
                  ? Consumer<DetailViewViewModel>(
                      builder: (context, value, child) {
                        return MaterialButton(
                            child: Text("ADD TO CART",
                                overflow: TextOverflow.ellipsis),
                            color: value.quantity != 0
                                ? Colors.amber
                                : Colors.grey[200],
                            onPressed: value.quantity != 0
                                ? () {
                                    value.addToCart(
                                      args.id,
                                      value.quantity,
                                      args.name,
                                      num.parse(args.price),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration:
                                                Duration(milliseconds: 400),
                                            content:
                                                Text("Item Added To Cart!")));
                                  }
                                : () {});
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
