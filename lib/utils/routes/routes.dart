import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/cart_view.dart';
import 'package:mvvm/view/detail_screen.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/orderDetail.dart';
import 'package:mvvm/view/order_history.dart';
import 'package:mvvm/view/signp_view.dart';
import 'package:mvvm/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());
      case RoutesName.detail:
        return MaterialPageRoute(
            builder: (BuildContext context) => DeatilScreenView(),
            settings: RouteSettings(arguments: settings.arguments));
      case RoutesName.cart:
        return MaterialPageRoute(
          builder: (BuildContext context) => CartView(),
        );

      case RoutesName.order_history:
        return MaterialPageRoute(
          builder: (BuildContext context) => OrderHistory(),
        );
      case RoutesName.order_detail:
        return MaterialPageRoute(
          builder: (BuildContext context) => OrderDetails(),
          settings: RouteSettings(arguments: settings.arguments),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}

class DetailArguments {
  final String? title;
  final String? price;
  final bool? inStock;

  DetailArguments({this.title, this.price, this.inStock});
}
