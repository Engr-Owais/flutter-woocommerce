import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/order_history_viewmodel.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  OrderHistoryViewModel orderHistoryModel = OrderHistoryViewModel();
  @override
  void initState() {
    super.initState();
    orderHistoryModel.fetchOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ORDER HISTORY"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ChangeNotifierProvider<OrderHistoryViewModel>(
            create: (BuildContext context) => orderHistoryModel,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Consumer<OrderHistoryViewModel>(
                    builder: (context, value, child) {
                  if (value.orderList.status! == Status.LOADING) {
                    return Center(child: CircularProgressIndicator());
                  } else if (value.orderList.status! == Status.ERROR) {
                    return Center(
                        child: Text(value.orderList.message.toString()));
                  } else if (value.orderList.status == Status.COMPLETED) {
                    return value.orderList.data!.isNotEmpty
                        ? ListView.builder(
                            itemCount: value.orderList.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.order_detail,
                                        arguments:
                                            value.orderList.data![index]);
                                  },
                                  child: Card(
                                    elevation: 2.0,
                                    child: ListTile(
                                      title: Text(
                                          "Order Number ${value.orderList.data![index].id.toString()}"),
                                      trailing: Text(
                                          "Total ${value.orderList.data![index].total}"),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text("No Order History"),
                          );
                  } else
                    return Center(child: CircularProgressIndicator());
                }))),
      ),
    );
  }
}
