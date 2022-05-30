import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization_example/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import 'provider/locale_provider.dart';
import 'widget/language_picker_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.deepPurple.shade100,
              primaryColor: Colors.deepPurpleAccent,
            ),
            //    locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: const MyHomePage(
              title: 'localization',
            ),
          );
        },
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LocaleProvider>(context, listen: false);

      provider.clearLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                color: Colors.white,
                height: 50,
                width: 150,
                child: const LanguagePickerWidget()),
            const LanguageWidget(),
            const SizedBox(height: 32),
            Text(
              AppLocalizations.of(context)!.language,
              style: const TextStyle(color: Colors.blue, fontSize: 30),
            ),
            Text(
              AppLocalizations.of(context)!.helloworld,
              style: const TextStyle(color: Colors.blue, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
