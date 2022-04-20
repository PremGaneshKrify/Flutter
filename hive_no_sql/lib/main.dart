import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_no_sql/model/testing.dart';
import 'package:hive_no_sql/model/transcation.dart';
import 'package:hive_no_sql/page/transcation_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  var box1 = await Hive.openBox<Transaction>("transactions");
  var box2 = await Hive.openBox<Testing>("testing");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Center(child: MyHomePage(title: 'Hive Expense Tracker ')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: TransactionPage(),
      );
}
