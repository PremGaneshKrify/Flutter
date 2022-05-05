import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dashborad.dart';

void main() {
  Stripe.publishableKey =
      "pk_test_51KvfCRSChehlPjEMEVegup147Oap0cojpq3G6k1h3X0vYntdks0qaPm6XyON4eS47ZoTooebfeREmfcJThVbcDgW00Weh9Nkh2";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashBoardPage(title: 'Flutter Demo Home Page'),
    );
  }
}
