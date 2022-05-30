// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sajilo_khata/custom_widgets/custom_buttton.dart';
// import 'package:sajilo_khata/custom_widgets/montserrat_text_widget.dart';
// import 'package:sajilo_khata/custom_widgets/text_field_widget.dart';
// import 'package:sajilo_khata/screens/forgot_screen.dart';
// import 'package:sajilo_khata/screens/registration_screen.dart';
//
// import '../helpers/theme_colors.dart';
// import 'registraction_otp_verification_screen.dart';
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
//   /// Optional
//   TextEditingController fullName = TextEditingController();
//   TextEditingController businessName = TextEditingController();
//   bool isLogin = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveSizer(builder: (context, orientation, screenType) {
//       return Scaffold(
//           body: SingleChildScrollView(
//             child: SizedBox(
//                 height: 100.h,
//                 width: 100.w,
//                 child: Stack(
//                   children: [
//                     /// Logo
//                     Positioned(
//                         top: isLogin? 10.h:7.h,
//                         left: 30.w,
//                         child: SizedBox(
//                             height: 20.h,
//                             child: Image.asset("assets/logos/logo.png"))),
//                     /// Bottom Part(Pink color container)
//                     Positioned(
//                       top: isLogin? 45.h : 33.h,
//                       child: Container(
//                         height: isLogin  ? 55.h: 67.h,
//                         width: 100.w,
//                         decoration: BoxDecoration(
//                             borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(60),
//                                 topRight: Radius.circular(60)),
//                             gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   ShajiloKhata().darkPink,
//                                   ShajiloKhata().lightPink,
//                                 ])),
//                         child: Container(
//                           padding: const EdgeInsets.only(top:15,left:30,right:30,bottom:30),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               /// Login Text
//                               Center(
//                                 child: MontserratText(
//                                     text: isLogin? "Login": "Register",
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.white,
//                                     fontSize: 16.sp),
//                               ),
//                               SizedBox(height: 4.h),
//                               ///  Full Name Text
//                               if(!isLogin)
//                               const MontserratText(
//                                   text: "Full Name *",
//                                   fontWeight: FontWeight.normal,
//                                   color: Colors.white,
//                                   fontSize: 10),
//                               SizedBox(height: 0.5.h),
//                               /// Full Name Text Fiesld
//                               if(!isLogin)
//                               CustomTextFormField(controller: fullName, prefixText: "", textInputType: TextInputType.text,),
//                               if(!isLogin)
//                               SizedBox(height: 0.5.h),
//
//                               /// Business Name Text
//                               if(!isLogin)
//                               const MontserratText(
//                                   text: "Business Name *",
//                                   fontWeight: FontWeight.normal,
//                                   color: Colors.white,
//                                   fontSize: 10),
//                               if(!isLogin)
//                               SizedBox(height: 0.5.h),
//                               /// Business Name Text Field
//                               if(!isLogin)
//                               CustomTextFormField(controller: businessName, prefixText: "", textInputType: TextInputType.text,),
//                               if(!isLogin)
//                               SizedBox(height: 1.h),
//                               /// Enter 10-digit Phone number Text
//                               MontserratText(
//                                   text: isLogin? "Enter 10-digit Phone number":"Enter 10-digit Phone number *",
//                                   fontWeight: FontWeight.normal,
//                                   color: Colors.white,
//                                   fontSize: 10),
//                               SizedBox(height: 0.5.h),
//                               /// Mobile Number Text Field
//                               CustomTextFormField(controller: mobileNumber, prefixText: "+977  ", textInputType: TextInputType.number,),
//                               SizedBox(height: 1.h),
//                               /// Passcode Text
//                               if(isLogin)
//                               const MontserratText(
//                                   text: "Passcode ",
//                                   fontWeight: FontWeight.normal,
//                                   color: Colors.white,
//                                   fontSize: 10),
//                               if(isLogin)
//                               SizedBox(height: 0.5.h),
//                               /// Passcode Text Field
//                               if(isLogin)
//                               CustomTextFormField(controller: passCode, prefixText: "", textInputType: TextInputType.number,),
//
//                               /// Passcode Text
//                               if(!isLogin)
//                                 const MontserratText(
//                                     text: "Passcode *",
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.white,
//                                     fontSize: 10),
//                               if(!isLogin)
//                                 SizedBox(height: 0.5.h),
//                               /// Passcode Text Field
//                               if(!isLogin)
//                                 CustomTextFormField(controller: passCode, prefixText: "", textInputType: TextInputType.number,),
//
//                                 SizedBox(height: 1.h),
//                               /// Forgot Password
//                               if(isLogin)
//                                 InkWell(
//                                   child: const MontserratText(
//                                       text: "Forgot Passcode?",
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.white,
//                                       fontSize: 10),
//                                   onTap:(){
//                                     Navigator.push(context,MaterialPageRoute(builder: (context)=>const ForgotPassword()));
//                                   }
//                                 ),
//                               if (isLogin)
//                               SizedBox(height: 1.h),
//                               /// Don't have account? Register text fields
//                               Row(
//                                 children:  [
//                                   MontserratText(
//                                       text: isLogin ? "Don’t have account? ": "Already have account? ",
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.white,
//                                       fontSize: 10),
//                                   /// Register Button
//                                   InkWell(
//                                       child: MontserratText(
//                                           text: isLogin?"Register":"Login",
//                                           fontWeight: FontWeight.normal,
//                                           color: Colors.yellow,
//                                           fontSize: 10),
//                                       onTap:(){
//                                         setState(() {
//                                           isLogin  = !isLogin;
//                                         });
//                                         // Navigator.push(context,MaterialPageRoute(builder: (context)=> const RegistrationScreen()));
//                                       }
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 4.h),
//                               /// Login Button or Registration button
//                               InkWell(
//                                 child: Center(
//                                   child: CustomButton(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:14.sp,
//                                       text: isLogin?"Login":"Register",
//                                       height:  5.h,
//                                       width: 55.w,
//                                       buttonColor: Colors.white,
//                                       textColor: ShajiloKhata().blue),
//                                 ),
//                                 onTap: (){
//                                   if(!isLogin){
//                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const FirstOtpScreen()));
//                                   }
//                                 }
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),
//           ));
//     });
//   }
// }
///..............
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_khata/custom_widgets/custom_buttton.dart';
import 'package:sajilo_khata/custom_widgets/montserrat_text_widget.dart';
import 'package:sajilo_khata/custom_widgets/text_field_widget.dart';
import 'package:sajilo_khata/screens/registration_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../custom_widgets/animated_toggle.dart';
import '../helpers/theme_colors.dart' as color;
import '../provider/locale_provider.dart';
import 'forgot_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController passCode = TextEditingController();
  final focusmobile = FocusNode();
  final focuspasscode = FocusNode();

  /// Login API call
  loginAPICall(mobileNumber, passcode) async {
    var headers = {
      'Authorization': '346143b2-b645-4af3-9ad2-cd78b6898d43',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request =
        http.Request('POST', Uri.parse('https://sarallekha.com:3000/login'));
    request.bodyFields = {'phone': mobileNumber, 'passcode': passcode};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String stringData = await response.stream.bytesToString();
      var responseData = (jsonDecode(stringData) as Map<String, dynamic>);
      print("$responseData [GREEN]");
      print("${responseData.runtimeType} [GREEN]");
      print("${responseData['status']} [GREEN]");
      if (responseData['status'] == 0) {
        return AwesomeDialog(
          customHeader: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image.asset("assets/images/Customer select.png")
              // Lottie.asset(
              //     'assets/images/mail or mobile not registered case.json')
              ),
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: true,
          title: "This is title",
          desc: "This is Description",
          btnOkOnPress: () {},
          //btnOkIcon: Icons.cancel,
          btnOkColor: color.SajiloKhata().blue,
        ).show();
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Stack(
                children: [
                  /// Logo
                  Positioned(
                      top: 10.h,
                      left: 30.w,
                      child: SizedBox(
                          height: 20.h,
                          child: Image.asset("assets/logos/logo.png"))),

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
                        padding: const EdgeInsets.only(
                            top: 20, left: 30, right: 30, bottom: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Login Text
                              Center(
                                child: MontserratText(
                                    text: AppLocalizations.of(context)!.login,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(height: 4.h),

                              /// Enter 10-digit Phone number Text
                              MontserratText(
                                  text: AppLocalizations.of(context)!
                                      .enterTenDigitPhoneNumber,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 12),
                              SizedBox(height: 0.5.h),

                              /// Mobile Number Text Field
                              CustomTextFormField(
                                focusname: focusmobile,
                                controller: mobileNumber,
                                prefixText: "",
                                textInputType: TextInputType.number,
                              ),
                              SizedBox(height: 1.h),

                              /// Passcode Text
                              MontserratText(
                                  text: AppLocalizations.of(context)!.passcode,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 10),
                              SizedBox(height: 0.5.h),

                              /// Passcode Text Field
                              CustomTextFormField(
                                focusname: focuspasscode,
                                controller: mobileNumber,
                                prefixText: "",
                                textInputType: TextInputType.number,
                              ),
                              SizedBox(height: 1.h),
                              InkWell(
                                  child: MontserratText(
                                      text: AppLocalizations.of(context)!
                                          .forgotPassword,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 10),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPassword()));
                                  }),
                              SizedBox(height: 1.h),

                              /// Don't have account? Register text fields
                              Row(
                                children: [
                                  MontserratText(
                                      text: AppLocalizations.of(context)!
                                          .dontHaveAnAccount,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 10),
                                  InkWell(
                                      child: MontserratText(
                                          text: AppLocalizations.of(context)!
                                              .register,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.yellow,
                                          fontSize: 10),
                                      onTap: () {
                                        print(
                                            "------------clicked-------------");
                                        setState(() {
                                          final provider =
                                              Provider.of<LocaleProvider>(
                                                  context,
                                                  listen: false);
                                          provider
                                              .setLocale(const Locale('ne'));
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegistrationScreen()));
                                      }),
                                ],
                              ),
                              SizedBox(height: 4.h),

                              /// Login Button
                              Center(
                                child: InkWell(
                                    child: CustomButton(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        text:
                                            AppLocalizations.of(context)!.login,
                                        height: 5.h,
                                        width: 55.w,
                                        buttonColor: Colors.white,
                                        textColor: Colors.pink),
                                    onTap: () {}),
                              ),
                              SizedBox(height: 2.h),

                              /// Toggle Switch to languages
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    // color:Colors.white,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: AnimatedToggle(
                                          values: const ['English', 'नेपाली '],
                                          onToggleCallback: (value) {
                                            print(
                                                "The value is $value [GREEN]");
                                            setState(() {});
                                            if (value == 0) {
                                              final provider =
                                                  Provider.of<LocaleProvider>(
                                                      context,
                                                      listen: false);
                                              provider.setLocale(
                                                  const Locale('en'));
                                            } else if (value == 1) {
                                              final provider =
                                                  Provider.of<LocaleProvider>(
                                                      context,
                                                      listen: false);
                                              provider.setLocale(
                                                  const Locale('ne'));
                                            }
                                          },
                                          buttonColor: color.SajiloKhata().blue,
                                          backgroundColor: Colors.white,
                                          textColor: const Color(0xFFFFFFFF),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )));
    });
  }

  locale(int index) {
    if (index == 0) {
      final provider = Provider.of<LocaleProvider>(context, listen: false);
      provider.setLocale(const Locale('en'));
    } else if (index == 1) {
      final provider = Provider.of<LocaleProvider>(context, listen: false);
      provider.setLocale(const Locale('ne'));
    }
  }
}
