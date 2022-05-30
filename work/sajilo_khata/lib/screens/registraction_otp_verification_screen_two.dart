import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../custom_widgets/custom_buttton.dart';
import '../custom_widgets/montserrat_text_widget.dart';
import '../helpers/theme_colors.dart';
import 'choose_language_screen.dart';
class SecondOtpScreen extends StatefulWidget {
  const SecondOtpScreen({Key? key}) : super(key: key);

  @override
  State<SecondOtpScreen> createState() => _SecondOtpScreenState();
}

class _SecondOtpScreenState extends State<SecondOtpScreen> {
  TextEditingController otp = TextEditingController();
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
                                    text: "OTP Verification",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 18.sp),
                              ),
                              SizedBox(height: 4.h),
                              /// Enter the OTP Text Field
                              Center(
                                child: MontserratText(
                                    text: "Enter the OTP send to 9553098188",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 15.sp),
                              ),
                              SizedBox(height: 5.h),
                              /// OTP pin code fields
                              Center(
                                child:  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 30),
                                    child: Container(
                                      width: 50.w,
                                      child: PinCodeTextField(
                                        appContext: context,
                                        pastedTextStyle: TextStyle(
                                            fontSize:  17.h,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                        length: 4,
                                        obscureText: false,
                                        // obscuringCharacter: '*',
                                        // obscuringWidget: const FlutterLogo(
                                        //   size: 24,
                                        // ),
                                        blinkWhenObscuring: true,
                                        animationType: AnimationType.fade,
                                        textStyle:TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),

                                        validator: (v) {
                                          // if (v!.length < 3) {
                                          //   return "I'm from validator";
                                          // } else {
                                          //   return null;
                                          // }
                                        },
                                          pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.underline,
                                            borderRadius: BorderRadius.circular(5),
                                            fieldHeight: MediaQuery.of(context).size.width * 0.1,
                                            fieldWidth: MediaQuery.of(context).size.width * 0.1,
                                            activeFillColor: Colors.white,
                                            activeColor:Colors.white,
                                            inactiveFillColor:Colors.white,
                                            inactiveColor: Colors.grey.shade400,
                                            selectedFillColor:  Colors.white,
                                            selectedColor: Colors.white,
                                            errorBorderColor: Colors.red,
                                          ),
                                        cursorColor: Colors.white,
                                        animationDuration: const Duration(milliseconds: 300),
                                        keyboardType: TextInputType.number,
                                        onCompleted: (v) {
                                          debugPrint("Completed");
                                        },
                                        onChanged: (value) {
                                          debugPrint(value);
                                          setState(() {
                                            // currentText = value;
                                          });
                                        },
                                        beforeTextPaste: (text) {
                                          debugPrint("Allowing to paste $text");
                                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                          return true;
                                        },
                                      ),
                                    )),
                              ),
                              SizedBox(height: 1.h),
                              /// OTP didn't match text field
                              Center(
                                child: MontserratText(
                                    text: "OTP Did Not match",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 14.sp),
                              ),
                              SizedBox(height: 1.h),
                              /// Didn't receive the OTP  Text Field
                              Center(
                                child: MontserratText(
                                    text: "Didn’t you recieve the OTP ? Resend OTP",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 13.sp),
                              ),
                              SizedBox(height: 5.h),
                              /// NextButton
                              InkWell(
                                child: Center(
                                  child: CustomButton(
                                      fontWeight: FontWeight.bold,
                                      fontSize:16.sp,
                                      text:"Next",
                                      height:  5.h,
                                      width: 55.w,
                                      buttonColor:SajiloKhata().blue,
                                      textColor: Colors.white),
                                ),
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseLanguage()));
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
