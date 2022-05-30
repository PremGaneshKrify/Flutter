import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sajilo_khata/provider/locale_provider.dart';
import 'package:sajilo_khata/screens/splash_screen.dart';
import 'package:sajilo_khata/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'l10n/l10n.dart';

// void main(){
//   runApp(const SajiloKhata());
// }
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const SajiloKhata());
}

class SajiloKhata extends StatelessWidget {
  const SajiloKhata({Key? key}) : super(key: key);

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
              locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home: const SplashScreen());
        },
      );
  // Widget build(BuildContext context) {
  //   return const MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: SplashScreen()
  //   );
  // }
}
