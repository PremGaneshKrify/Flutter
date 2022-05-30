import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../custom_widgets/custom_buttton.dart';
import '../custom_widgets/montserrat_text_widget.dart';
import '../helpers/theme_colors.dart';
import 'forgot_password_otp_validation_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: Stack(
                  children: [
                    /// Phone Logo
                    Positioned(
                        top: 15.h,
                        left: 30.w,
                        child: SizedBox(
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
                                  SajiloKhata().darkPink,
                                  SajiloKhata().lightPink,
                                ])),
                        child: Container(
                          padding: const EdgeInsets.only(top:20,left:30,right:30,bottom:30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(height: 2.h),
                              /// OTP Verification Text
                              Center(
                                child: MontserratText(
                                    text: "Forgot Passcode",
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
                                    text: "Enter Mobile Number",
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                              SizedBox(height: 2.h),
                              /// Mobile Number
                              Container(
                                margin:  EdgeInsets.only(left:15.w,right:15.w),
                                child: TextFormField(
                                  cursorColor:Colors.white ,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)
                                  ),
                                    contentPadding: EdgeInsets.only(left:30)
                                ),
                                ),
                              ),


                              SizedBox(height: 4.h),
                              /// NextButton
                              InkWell(
                                  child: Center(
                                    child: CustomButton(
                                        fontWeight: FontWeight.bold,
                                        fontSize:16.sp,
                                        text:"Send",
                                        height:  5.h,
                                        width: 55.w,
                                        buttonColor:SajiloKhata().blue,
                                        textColor: Colors.white),
                                  ),
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPasswordOtpValidationScreen()));
                                  }
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ));
    }
    );
  }
}
