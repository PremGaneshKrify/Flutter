import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_khata/helpers/theme_colors.dart' as color;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //State class
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color.SajiloKhata().lightPink,
    ));
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          key: _bottomNavigationKey,
          items: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/icons/homeIcon.svg",
                height: 4.h,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/icons/shopIcon.svg",

                height: 4.h,
                //  fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/icons/cashIcon.svg",
                height: 4.h,
                //  fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/icons/profileIcon.svg",
                height: 4.h,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: 100.h,
                width: 100.h,
              ),
              Container(
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      color.SajiloKhata().lightPink,
                      color.SajiloKhata().darkPink,
                    ])),
              ),
              Positioned(
                  top: 220,
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: 900,
                    width: 80.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                           boxShadow: [
                    //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                    ),
                    
                  )),
            ],
          ),
        ));
  }
}
