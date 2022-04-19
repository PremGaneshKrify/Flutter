import 'package:hive/hive.dart';
import 'package:hive_no_sql/model/transcation.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}
