import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_khata/screens/registraction_otp_verification_screen.dart';

import '../custom_widgets/custom_buttton.dart';
import '../custom_widgets/montserrat_text_widget.dart';
import '../custom_widgets/text_field_widget.dart';
import '../helpers/theme_colors.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController passCode = TextEditingController();
  int  customerSelected = 1;
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Container(
            height: 100.h,
            width: 100.w,
            child: Stack(
              children: [
                /// Logo
                Positioned(
                    top: 8.h,
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
                      padding: const EdgeInsets.only(
                          top: 20, left: 30, right: 30, bottom: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// register Text
                            Center(
                              child: MontserratText(
                                  text: "Register",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 16.sp),
                            ),
                            SizedBox(height: 4.h),

                            ///  Full Name Text
                            const MontserratText(
                                text: "Full Name *",
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 10),
                            SizedBox(height: 0.5.h),

                            /// Full Name Text Field
                            CustomTextFormField(
                              controller: fullName,
                              prefixText: "",
                              textInputType: TextInputType.text, focusname: null,
                            ),
                            SizedBox(height: 1.h),

                            /// Business Name Text
                            if(customerSelected == 0)
                            const MontserratText(
                                text: "Business Name *",
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 10),
                            if(customerSelected == 0)
                            SizedBox(height: 0.5.h),

                            /// Business Name Text Field
                            if(customerSelected == 0)
                            CustomTextFormField(
                              controller: businessName,
                              prefixText: "",
                              textInputType: TextInputType.text, focusname: null,
                            ),
                            if(customerSelected == 0)
                            SizedBox(height: 1.h),
                            /// 10-digit Phone number * text widget
                            const MontserratText(
                                text: "10-digit Phone number *",
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 10),
                            SizedBox(height: 0.5.h),

                            /// Mobile Number Text Field
                            CustomTextFormField(
                              controller: businessName,
                              prefixText: "",
                              textInputType: TextInputType.number, focusname: null,
                            ),
                            SizedBox(height: 1.h),

                            /// Passcode Text
                            const MontserratText(
                                text: "Passcode *",
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 10),

                            SizedBox(height: 0.5.h),

                            /// Passcode Text Field
                            CustomTextFormField(
                              controller: passCode,
                              prefixText: "",
                              textInputType: TextInputType.number, focusname: null,
                            ),

                            SizedBox(height: 1.5.h),
                            /// Category Selection Part i.e., Customer and Shop owner
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    ///  Customer select and un select icons
                                    Container(
                                        height:50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          // color:Colors.yellow,
                                            shape: BoxShape.circle
                                        ),
                                        child: InkWell(
                                            onTap:(){ setState(() {
                                              customerSelected =  1;
                                            });
                                            },
                                            child:Image.asset(customerSelected== 1?"assets/images/Customer select.png":"assets/images/Customer unselect.png",fit: BoxFit.fill,)
                                        )),
                                    /// Customer text widget
                                    const MontserratText(
                                        text: "Customer",
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 10),
                                  ],
                                ),
                                SizedBox(width: 5.w),
                                Column(
                                  children: [
                                    /// Shop Owner select and un select icons
                                    Container(
                                        height:50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                            // color:Colors.yellow,
                                          shape: BoxShape.circle
                                        ),
                                        child: InkWell(
                                          onTap:(){ setState(() {
                                            customerSelected  = 0;
                                          });
                                          },
                                          child:Image.asset(customerSelected !=0?"assets/images/Shop Owner unselect.png":"assets/images/Shop Owner select.png",fit: BoxFit.fill,)
                                        )),
                                    /// Shop owner text widget
                                    const MontserratText(
                                        text: "Shop Owner",
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 10),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),

                            /// Register Button
                            InkWell(
                                child: Center(
                                  child: CustomButton(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                      text: "Register",
                                      height: 5.h,
                                      width: 55.w,
                                      buttonColor: Colors.white,
                                      textColor: SajiloKhata().blue),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FirstOtpScreen()));
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ));
    });
  }
}

///.................................................
// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sajilo_khata/custom_widgets/custom_buttton.dart';
// import 'package:sajilo_khata/custom_widgets/montserrat_text_widget.dart';
// import 'package:sajilo_khata/custom_widgets/text_field_widget.dart';
//
// import '../helpers/theme_colors.dart';
//
// class LoginScreen extends StatefulWidget {
//   LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController mobileNumber = TextEditingController();
//   TextEditingController passCode = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveSizer(builder: (context, orientation, screenType) {
//       return Scaffold(
//           body: Container(
//               height: 100.h,
//               width: 100.w,
//               child: Stack(
//                 children: [
//                   /// Logo
//                   Positioned(
//                       top: 10.h,
//                       left: 30.w,
//                       child: Container(
//                           height: 20.h,
//                           child: Image.asset("assets/logos/logo.png"))),
//                   /// Bottom Part(Pink color containner )
//                   Positioned(
//                     top: 45.h,
//                     child: Container(
//                       height: 55.h,
//                       width: 100.w,
//                       decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(60),
//                               topRight: Radius.circular(60)),
//                           gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 ShajiloKhata().darkPink,
//                                 ShajiloKhata().lightPink,
//                               ])),
//                       child: Container(
//                         padding: const EdgeInsets.only(top:20,left:30,right:30,bottom:30),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             /// Login Text
//                             Center(
//                               child: MontserratText(
//                                   text: "Login",
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.white,
//                                   fontSize: 16.sp),
//                             ),
//                             SizedBox(height: 4.h),
//                             /// Enter 10-digit Phone number Text
//                             const MontserratText(
//                                 text: "Enter 10-digit Phone number",
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.white,
//                                 fontSize: 10),
//                             SizedBox(height: 0.5.h),
//                             /// Mobile Number Text Field
//                             CustomTextFormField(controller: mobileNumber, prefixText: "+977  ", textInputType: TextInputType.number,),
//                             SizedBox(height: 1.h),
//                             /// Passcode Text
//                             const MontserratText(
//                                 text: "Passcode",
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.white,
//                                 fontSize: 10),
//                             SizedBox(height: 0.5.h),
//                             /// Passcode Text Field
//                             CustomTextFormField(controller: mobileNumber, prefixText: "", textInputType: TextInputType.number,),
//                             SizedBox(height: 1.h),
//                             /// Don't have account? Register text fields
//                             Row(
//                               children:  [
//                                 const MontserratText(
//                                     text: "Don’t have account? ",
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.white,
//                                     fontSize: 10),
//                                 InkWell(
//                                     child: const MontserratText(
//                                         text: " Register",
//                                         fontWeight: FontWeight.normal,
//                                         color: Colors.yellow,
//                                         fontSize: 10),
//                                     onTap:(){}
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 4.h),
//                             /// Login Button
//                             Center(
//                               child: CustomButton(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize:14.sp,
//                                   text:"Login",
//                                   height:  5.h,
//                                   width: 55.w,
//                                   buttonColor: Colors.white,
//                                   textColor: ShajiloKhata().blue),
//                             ),
//
//
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )));
//     });
//   }
// }
//
