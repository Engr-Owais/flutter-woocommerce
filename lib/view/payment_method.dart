import 'package:flutter/material.dart';
import 'package:mvvm/model/payment.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/respository/payment_repo.dart';
import 'package:mvvm/utils/routes/routes_name.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PayRepository _payRepository = PayRepository();
  late Future<Payment> pay;

  @override
  void initState() {
    pay = _payRepository.fetchPayMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("PAY HERE"),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder<Payment>(
                  future: _payRepository.fetchPayMethod(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.data != null) {
                      return Column(
                        children: [
                          Text(
                            "${snapshot.data!.title}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${snapshot.data!.description}",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${snapshot.data!.methodDescription}",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RoundButton(
                              title: 'Confirm',
                              onPress: () {
                                Navigator.pushReplacementNamed(
                                    context, RoutesName.home);
                              })
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
