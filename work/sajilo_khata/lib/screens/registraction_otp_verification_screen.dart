import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_khata/helpers/theme_colors.dart' as color;
import 'package:sajilo_khata/main.dart';
import '../custom_widgets/custom_buttton.dart';
import '../custom_widgets/montserrat_text_widget.dart';
import '../custom_widgets/text_field_widget.dart';
import 'registraction_otp_verification_screen_two.dart';

class FirstOtpScreen extends StatelessWidget {
  const FirstOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
          body: Container(
              height: 100.h,
              width: 100.w,
              child: Stack(
                children: [
                  /// Phone Logo
                  Positioned(
                      top: 15.h,
                      left: 30.w,
                      child: Container(
                          height: 20.h,
                          // child: Image.asset("assets/logos/logo.png")

                      child: SvgPicture.asset(
                        "assets/images/Phone.svg",
                        // placeholderBuilder: (context) => CircularProgressIndicator(),
                        height: 20.h,
                      )

                      )),
                  /// Bottom Part(Pink color container )
                  Positioned(
                    top: 45.h,
                    child: Container(
                      height: 55.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                color.SajiloKhata().darkPink,
                                color.SajiloKhata().lightPink,
                              ])),
                      child: Container(
                        padding: const EdgeInsets.only(top:20,left:30,right:30,bottom:30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// OTP Verification Text
                            SizedBox(height: 2.h),
                            Center(
                              child: MontserratText(
                                  text: "OTP Verification",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18.sp),
                            ),
                            SizedBox(height: 4.h),
                            ///  Text widget
                             const Center(
                              child: MontserratText(
                                  text: "We will send you a one-time password",
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 13),
                            ),
                            SizedBox(height: 0.5.h),
                            /// Text Widget
                            const Center(
                              child: MontserratText(
                                  text: "to this mobile number",
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 13),
                            ),
                             SizedBox(height: 3.h),
                            const Center(
                              child: MontserratText(
                                  text: "Entered Mobile Number",
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 2.5.h),
                            /// Mobile Number
                            const Center(
                              child: MontserratText(
                                  text: "9553098188",
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            /// Horizontal Line
                            Center(
                              child: SizedBox(
                                width: 55.w,
                                child: const Divider(
                                  thickness: 1, // thickness of the line
                                  indent: 20, // empty space to the leading edge of divider.
                                  endIndent: 20, // empty space to the trailing edge of the divider.
                                  color: Colors.white, // The color to use when painting the line.
                                  height: 10, // The divider's height extent.
                                ),
                              ),
                            ),
                             SizedBox(height: 4.h),
                            /// Register Button
                            InkWell(
                              child: Center(
                                child: CustomButton(
                                    fontWeight: FontWeight.bold,
                                    fontSize:16,
                                    text:"Next",
                                    height:  5.h,
                                    width: 55.w,
                                    buttonColor: color.SajiloKhata().blue,
                                    textColor: Colors.white),
                              ),
                              onTap:(){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> SecondOtpScreen()));
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )));
    }
    );
  }
}
