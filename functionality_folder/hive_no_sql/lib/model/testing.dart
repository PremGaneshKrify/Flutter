import 'package:hive/hive.dart';
part "testing.g.dart";

@HiveType(typeId: 1)
class Testing extends HiveObject {
  @HiveField(0)
  late String testname;
  @HiveField(1)
  late DateTime testcreatedDate;
  @HiveField(2)
  late bool testisExpense = true;
  @HiveField(3)
  late double testamount;
}
