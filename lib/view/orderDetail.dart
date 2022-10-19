import 'package:flutter/material.dart';
import 'package:mvvm/model/orderHistory.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final firstargs =
        ModalRoute.of(context)!.settings.arguments as OrderHistoryModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("DETAILS OF ORDER ${firstargs.id}"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: firstargs.lineItems!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    "${firstargs.lineItems![index].name}",
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing:
                      Text("Quan ${firstargs.lineItems![index].quantity}"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
