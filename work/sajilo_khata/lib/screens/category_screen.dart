import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../custom_widgets/custom_buttton.dart';
import '../custom_widgets/montserrat_text_widget.dart';
import '../helpers/theme_colors.dart';
import 'address_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
          body: Stack(
            children: [
              /// Background curve shadow widget
              Positioned(
                bottom : 8.h,
                child: Container(
                  height:40.h,
                  width: 100.w,
                  // color:Colors.red,
                  child: SvgPicture.asset(
                    "assets/images/curve_shape_shadow_background.svg",
                    color: Colors.blue.shade50,
                    height: 40.h,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              /// Whole container of the screen
              Container(
                  height:100.h,
                  width:100.w,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:5.h,
                      ),
                      /// Svg Image
                      Center(
                        child: SvgPicture.asset(
                          "assets/images/Card Svg.svg",
                          height: 40.h,
                        ),
                      ),
                      SizedBox(
                        height:3.h,
                      ),
                      ///
                      MontserratText(
                          text: "What would you",
                          fontWeight: FontWeight.w700,
                          color: SajiloKhata().blue,
                          fontSize: 25),
                      MontserratText(
                          text: "want to use ",
                          fontWeight: FontWeight.w700,
                          color: SajiloKhata().blue,
                          fontSize: 25),
                      SizedBox(
                        height:13.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            elevation:3,
                            borderRadius: BorderRadius.all(const Radius.circular(10)),
                            child: Container(
                                height: 8.h,
                                width:30.w,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [SajiloKhata().lightOrange,SajiloKhata().darkOrange]
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: MontserratText(
                                      text: "Shop Owner",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 15),
                                )
                            ),
                          ),
                          SizedBox(
                            width:1.h,
                          ),
                          Material(
                            elevation:3,
                            borderRadius: BorderRadius.all(const Radius.circular(10)),
                            child: Container(
                                height: 8.h,
                                width:30.w,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [SajiloKhata().lightViolet,SajiloKhata().darkViolet]
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: MontserratText(
                                      text: "Customer",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 15),
                                )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:5.h,
                      ),
                      Center(
                        child: InkWell(
                          child: CustomButton(
                              fontWeight: FontWeight.bold,
                              fontSize:16.sp,
                              text:"Next",
                              height:  5.h,
                              width: 55.w,
                              buttonColor:SajiloKhata().blue,
                              textColor: Colors.white),
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddressScreen()));
                          }
                        ),
                      ),
                    ],
                  )
              ),
            ],
          )
      );
    }
    );
  }
}
