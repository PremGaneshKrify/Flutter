import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_khata/custom_widgets/montserrat_text_widget.dart';
import 'package:sajilo_khata/screens/home_screen.dart';

import '../helpers/theme_colors.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return ResponsiveSizer(
        builder: (context, orientation, screenType) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [ SajiloKhata().lightPink,SajiloKhata().darkPink,])
                ),
              ),
              const AnimatedLogo(),



            ],
          )
        );
      }
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash:  SizedBox(
          height:100.h,
          width:100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Image.asset("assets/logos/logo.png")),
              const SizedBox(height:20),
              MontserratText(
                  text: "Sajilo Khata",
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 3.h)
            ],
          ),
        ),
        splashIconSize:  40.h,
      //   nextScreen: const LoginScreen(),
        nextScreen: const HomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        // pageTransitionType: PageTransitionType.scale,
        backgroundColor: Colors.transparent);
  }
}
