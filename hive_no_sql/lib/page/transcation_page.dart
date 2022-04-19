import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_no_sql/model/transcation.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final List<Transcation> transactions = [];
  @override
  void dispose() {
    Hive.box('transcations').close();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
