import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../custom_widgets/custom_buttton.dart';
import '../custom_widgets/montserrat_text_widget.dart';
import '../custom_widgets/text_field_widget.dart';
import '../helpers/theme_colors.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController state = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController localBody = TextEditingController();
  TextEditingController wordNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
          body: Container(
              height: 100.h,
              width: 100.w,
              child: Stack(
                children: [
                  /// Logo
                  Positioned(
                      top: 10.h,
                      left: 30.w,
                      child: Container(
                          height: 20.h,
                          child: Image.asset("assets/logos/logo.png"))),
                  /// Bottom Part(Pink color container )
                  Positioned(
                    top: 35.h,
                    child: Container(
                      height: 65.h,
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
                            /// Address Text
                            Center(
                              child: MontserratText(
                                  text: "Address :",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 16.sp),
                            ),
                            SizedBox(height: 4.h),
                            ///  State Text
                            const MontserratText(
                                text: "State",
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 10),
                            SizedBox(height: 0.5.h),
                            /// State Text Field
                            CustomTextFormField(controller: state, prefixText: "", textInputType: TextInputType.text, focusname: null,),
                            SizedBox(height: 1.h),
                            /// District Text
                            const MontserratText(
                                text: "District",
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 10),
                            SizedBox(height: 0.5.h),
                            /// Business Name Text Field
                            CustomTextFormField(controller: district, prefixText: "", textInputType: TextInputType.text, focusname: null,),
                            SizedBox(height: 1.h),
                            /// Local body text
                            const MontserratText(
                                text: "Local Body",
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 10),
                            SizedBox(height: 0.5.h),
                            /// Mobile Number Text Field
                            CustomTextFormField(controller: localBody, prefixText: "", textInputType: TextInputType.number, focusname: null,),
                            SizedBox(height: 1.h),
                            /// Word Number text
                            const MontserratText(
                                text: "Word Number",
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 10),
                            SizedBox(height: 0.5.h),
                            /// Mobile Number Text Field
                            CustomTextFormField(controller: wordNumber, prefixText: "", textInputType: TextInputType.number, focusname: null,),
                            SizedBox(height: 4.h),
                            /// Get Start Button
                            Center(
                              child: CustomButton(
                                  fontWeight: FontWeight.bold,
                                  fontSize:14.sp,
                                  text:"Get Start",
                                  height:  5.h,
                                  width: 55.w,
                                  buttonColor: Colors.white,
                                  textColor: SajiloKhata().blue),
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

