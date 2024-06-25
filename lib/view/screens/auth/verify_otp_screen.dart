import 'dart:convert';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/localization_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/custom_text_field.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/screens/auth/widget/condition_check_box.dart';
import 'package:sixam_mart/view/screens/auth/widget/guest_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/splash/splash_screen.dart';

// class VerifyOTPScreen extends StatefulWidget {
//   final bool exitFromApp;
//   final bool backFromThis;
//   final String phoneNumber;
//   const VerifyOTPScreen(
//       {Key? key, required this.exitFromApp, required this.backFromThis, required this.phoneNumber,})
//       : super(key: key);

//   @override
//   VerifyOTPScreenState createState() => VerifyOTPScreenState();
// }

// class VerifyOTPScreenState extends State<VerifyOTPScreen> {
//   final FocusNode _phoneFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//   final TextEditingController _codeController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String? _countryDialCode;

//   @override
//   Widget build(BuildContext context) {
//     return

//      Scaffold(
//       backgroundColor: ResponsiveHelper.isDesktop(context)
//           ? Colors.transparent
//           : Theme.of(context).cardColor,
//       appBar:
//               AppBar(
//                   leading: IconButton(
//                     onPressed: () => Get.back(),
//                     icon: Icon(Icons.arrow_back_ios_rounded,
//                         color: Theme.of(context).textTheme.bodyLarge!.color),
//                   ),
//                   elevation: 0,
//                   backgroundColor: Colors.transparent,
//                   actions: const [SizedBox()],
//                 )
//           ,
//       endDrawer: const MenuDrawer(),
//       endDrawerEnableOpenDragGesture: false,
//       body: SafeArea(
//           child: Scrollbar(
//         child: Center(
//           child: Container(
//             height: ResponsiveHelper.isDesktop(context) ? 690 : null,
//             width: context.width > 700 ? 500 : context.width,
//             padding: context.width > 700
//                 ? const EdgeInsets.symmetric(horizontal: 0)
//                 : const EdgeInsets.all(Dimensions.paddingSizeExtremeLarge),

//             decoration: context.width > 700
//                 ? BoxDecoration(
//                     color: Theme.of(context).cardColor,
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.radiusSmall),
//                     boxShadow: ResponsiveHelper.isDesktop(context)
//                         ? null
//                         : [
//                             BoxShadow(
//                                 color:
//                                     Colors.grey[Get.isDarkMode ? 700 : 300]!,
//                                 blurRadius: 5,
//                                 spreadRadius: 1)
//                           ],
//                   )
//                 : null,
//             child: GetBuilder<AuthController>(builder: (authController) {
//               return Center(
//                 child: SingleChildScrollView(
//                   child: Stack(
//                     children: [
//                       ResponsiveHelper.isDesktop(context)
//                           ? Positioned(
//                               top: 0,
//                               right: 0,
//                               child: Align(
//                                 alignment: Alignment.topRight,
//                                 child: IconButton(
//                                   padding: EdgeInsets.zero,
//                                   onPressed: () => Get.back(),
//                                   icon: const Icon(Icons.clear),
//                                 ),
//                               ),
//                             )
//                           : const SizedBox(),
//                       Padding(
//                         padding: ResponsiveHelper.isDesktop(context)
//                             ? const EdgeInsets.all(40)
//                             : EdgeInsets.zero,
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(Images.logo, width: 125),

//                               const SizedBox(
//                                   height: Dimensions.paddingSizeExtraLarge),

//                               Align(
//                                 alignment:
//                                     Get.find<LocalizationController>().isLtr
//                                         ? Alignment.topLeft
//                                         : Alignment.topRight,
//                                 child: Text('Verify OTP'.tr,
//                                     style: robotoBold.copyWith(
//                                         fontSize:
//                                             Dimensions.fontSizeExtraLarge)),
//                               ),
//                               const SizedBox(
//                                   height: Dimensions.paddingSizeDefault),

//                               CustomTextField(
//                                 titleText: ResponsiveHelper.isDesktop(context)
//                                     ? 'phone'.tr
//                                     : 'Enter otp sent to your phone'.tr,
//                                 hintText: '',
//                                 controller: _codeController,
//                                 focusNode: _phoneFocus,
//                                 nextFocus: _passwordFocus,
//                                 inputType: TextInputType.phone,

//                                 showTitle:
//                                     ResponsiveHelper.isDesktop(context),
//                                 // onCountryChanged: (CountryCode countryCode) {
//                                 //   _countryDialCode = countryCode.dialCode;
//                                 // },
//                                 // countryDialCode: _countryDialCode ??
//                                 //     Get.find<LocalizationController>()
//                                 //         .locale
//                                 //         .countryCode,
//                               ),

//                               const SizedBox(
//                                 height: Dimensions.paddingSizeExtraLarge,
//                               ),

//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: ListTile(
//                                       onTap: () =>
//                                           authController.toggleRememberMe(),
//                                       leading: Checkbox(
//                                         visualDensity: const VisualDensity(
//                                             horizontal: -4, vertical: -4),
//                                         activeColor:
//                                             Theme.of(context).primaryColor,
//                                         value:
//                                             authController.isActiveRememberMe,
//                                         onChanged: (bool? isChecked) =>
//                                             authController.toggleRememberMe(),
//                                       ),
//                                       title: Text('remember_me'.tr),
//                                       contentPadding: EdgeInsets.zero,
//                                       visualDensity: const VisualDensity(
//                                           horizontal: 0, vertical: -4),
//                                       dense: true,
//                                       horizontalTitleGap: 0,
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(
//                                   height: Dimensions.paddingSizeLarge),

//                               Align(
//                                   alignment: Alignment.center,
//                                   child: ConditionCheckBox(
//                                       authController: authController,
//                                       fromSignUp: false)),

//                               const SizedBox(
//                                   height: Dimensions.paddingSizeDefault),

//                               CustomButton(
//                                 height: ResponsiveHelper.isDesktop(context)
//                                     ? 45
//                                     : null,
//                                 width: ResponsiveHelper.isDesktop(context)
//                                     ? 180
//                                     : null,
//                                 buttonText:
//                                     ResponsiveHelper.isDesktop(context)
//                                         ? 'login'.tr
//                                         : 'sign_in'.tr,
//                                 onPressed: () =>
//                                     _login(authController, code: _codeController.text.trim(), phone: widget.phoneNumber ),
//                                 isLoading: authController.isLoading,
//                                 radius: ResponsiveHelper.isDesktop(context)
//                                     ? Dimensions.radiusSmall
//                                     : Dimensions.radiusDefault,
//                                 isBold: !ResponsiveHelper.isDesktop(context),
//                                 fontSize: ResponsiveHelper.isDesktop(context)
//                                     ? Dimensions.fontSizeExtraSmall
//                                     : null,
//                               ),
//                               const SizedBox(
//                                   height: Dimensions.paddingSizeExtraLarge),

//                               // ResponsiveHelper.isDesktop(context) ? const SizedBox() : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                               //   Text('do_not_have_account'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

//                               //   InkWell(
//                               //     onTap: () {
//                               //       if(ResponsiveHelper.isDesktop(context)){
//                               //         Get.back();
//                               //         Get.dialog(const SignUpScreen());
//                               //       }else{
//                               //         Get.toNamed(RouteHelper.getSignUpRoute());
//                               //       }
//                               //     },
//                               //     child: Padding(
//                               //       padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                               //       child: Text('sign_up'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
//                               //     ),
//                               //   ),
//                               // ]),
//                               // const SizedBox(height: Dimensions.paddingSizeSmall),

//                               ResponsiveHelper.isDesktop(context)
//                                   ? const SizedBox()
//                                   : const GuestButton(),

//                               // ResponsiveHelper.isDesktop(context) ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                               //   Text('do_not_have_account'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

//                               //   InkWell(
//                               //     onTap: () {
//                               //       if(ResponsiveHelper.isDesktop(context)){
//                               //         Get.back();
//                               //         Get.dialog(const SignUpScreen());
//                               //       }else{
//                               //         Get.toNamed(RouteHelper.getSignUpRoute());
//                               //       }
//                               //     },
//                               //     child: Padding(
//                               //       padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                               //       child: Text('sign_up'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
//                               //     ),
//                               //   ),
//                               // ]) :  const SizedBox(),
//                             ]),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       )),
//     );

//   }

// }

class VerifyOTPScreen extends StatelessWidget {
  final String countryCode;
  VerifyOTPScreen({
    super.key,
    required this.phoneNumber,
    required this.countryCode,
  });

  final String phoneNumber;

  final TextEditingController _codeController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  void _login(AuthController authController, {required String phone, required String code}) async {
    if (phone.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (code.isEmpty) {
      showCustomSnackBar('invalid_phone_number'.tr);
    } else {
      authController.verifyOtp(phone: phone, otp: code).then((status) async {
        if (status.isSuccess) {
          Get.find<CartController>().getCartDataOnline();
          if (authController.isActiveRememberMe) {
            authController.saveUserNumberAndPassword(
              phone,
              "password",
              "+977",
            );
          } else {
            authController.clearUserNumberAndPassword();
          }
          String token = status.message!.substring(1, status.message!.length);
          if (Get.find<SplashController>().configModel!.customerVerification! && int.parse(status.message![0]) == 0) {
            List<int> encoded = utf8.encode("password");
            String data = base64Encode(encoded);
          } else {
            Get.find<LocationController>().navigateToLocationScreen('sign-in', offNamed: true);
          }

          Get.to(const SplashScreen(body: null));
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Theme.of(context).cardColor,
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () => Get.back(),
      //     icon: Icon(Icons.arrow_back_ios_rounded, color: Theme.of(context).textTheme.bodyLarge!.color),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   actions: const [SizedBox()],
      // ),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: SafeArea(child: GetBuilder<AuthController>(
        builder: (authController) {
          return Container(
            width: Get.size.width,
            height: Get.size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                image: AssetImage(
                  Images.backGroundImage,
                ),
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  height: Get.size.height * 0.75,
                  width: Get.size.width * 0.86,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 100,
                        child: Image.asset(
                          'assets/image/otp_tick.png',
                          height: 132,
                          width: 132,
                        ),
                      ),
                      Positioned(
                        top: 186,
                        child: Text(
                          'OTP',
                          style: opensSans.copyWith(
                            fontSize: 42 + (Get.size.width * 0.02),
                            color: Theme.of(Get.context!).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 246,
                        child: Text(
                          'Verification',
                          style: opensSans.copyWith(
                            fontSize: 30 + (Get.size.width * 0.02),
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 300,
                        child: Text(
                          'Otp set to',
                          style: opensSans.copyWith(
                            fontSize: 20 + (Get.size.width * 0.02),
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              countryCode,
                              style: opensSans.copyWith(
                                fontSize: 14 + (Get.size.width * 0.02),
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            Text(
                              phoneNumber,
                              style: opensSans.copyWith(
                                fontSize: 14 + (Get.size.width * 0.02),
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )

          //     Scrollbar(
          //   child: Center(
          //     child: Container(
          //       height: ResponsiveHelper.isDesktop(context) ? 690 : null,
          //       width: context.width > 700 ? 500 : context.width,
          //       padding: context.width > 700 ? const EdgeInsets.symmetric(horizontal: 0) : const EdgeInsets.all(Dimensions.paddingSizeExtremeLarge),
          //       decoration: context.width > 700
          //           ? BoxDecoration(
          //               color: Theme.of(context).cardColor,
          //               borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          //               boxShadow: ResponsiveHelper.isDesktop(context) ? null : [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
          //             )
          //           : null,
          //       child: GetBuilder<AuthController>(builder: (authController) {
          //         return Center(
          //           child: SingleChildScrollView(
          //             child: Stack(
          //               children: [
          //                 ResponsiveHelper.isDesktop(context)
          //                     ? Positioned(
          //                         top: 0,
          //                         right: 0,
          //                         child: Align(
          //                           alignment: Alignment.topRight,
          //                           child: IconButton(
          //                             padding: EdgeInsets.zero,
          //                             onPressed: () => Get.back(),
          //                             icon: const Icon(Icons.clear),
          //                           ),
          //                         ),
          //                       )
          //                     : const SizedBox(),
          //                 Padding(
          //                   padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.all(40) : EdgeInsets.zero,
          //                   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //                     Image.asset(Images.logo, width: 125),

          //                     const SizedBox(height: Dimensions.paddingSizeExtraLarge),

          //                     Align(
          //                       alignment: Get.find<LocalizationController>().isLtr ? Alignment.topLeft : Alignment.topRight,
          //                       child: Text('Verify OTP'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
          //                     ),
          //                     const SizedBox(height: Dimensions.paddingSizeDefault),

          //                     CustomTextField(
          //                       titleText: ResponsiveHelper.isDesktop(context) ? 'phone'.tr : 'Enter otp sent to your phone'.tr,
          //                       hintText: '',
          //                       controller: _codeController,

          //                       inputType: TextInputType.phone,

          //                       showTitle: ResponsiveHelper.isDesktop(context),
          //                       // onCountryChanged: (CountryCode countryCode) {
          //                       //   _countryDialCode = countryCode.dialCode;
          //                       // },
          //                       // countryDialCode: _countryDialCode ??
          //                       //     Get.find<LocalizationController>()
          //                       //         .locale
          //                       //         .countryCode,
          //                     ),

          //                     const SizedBox(
          //                       height: Dimensions.paddingSizeExtraLarge,
          //                     ),

          //                     Row(
          //                       children: [
          //                         Expanded(
          //                           child: ListTile(
          //                             onTap: () => authController.toggleRememberMe(),
          //                             leading: Checkbox(
          //                               visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          //                               activeColor: Theme.of(context).primaryColor,
          //                               value: authController.isActiveRememberMe,
          //                               onChanged: (bool? isChecked) => authController.toggleRememberMe(),
          //                             ),
          //                             title: Text('remember_me'.tr),
          //                             contentPadding: EdgeInsets.zero,
          //                             visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          //                             dense: true,
          //                             horizontalTitleGap: 0,
          //                           ),
          //                         ),
          //                       ],
          //                     ),

          //                     const SizedBox(height: Dimensions.paddingSizeLarge),

          //                     Align(alignment: Alignment.center, child: ConditionCheckBox(authController: authController, fromSignUp: false)),

          //                     const SizedBox(height: Dimensions.paddingSizeDefault),

          //                     CustomButton(
          //                       height: ResponsiveHelper.isDesktop(context) ? 45 : null,
          //                       width: ResponsiveHelper.isDesktop(context) ? 180 : null,
          //                       buttonText: ResponsiveHelper.isDesktop(context) ? 'login'.tr : 'sign_in'.tr,
          //                       onPressed: () => _login(authController, code: _codeController.text.trim(), phone: phoneNumber),
          //                       isLoading: authController.isLoading,
          //                       radius: ResponsiveHelper.isDesktop(context) ? Dimensions.radiusSmall : Dimensions.radiusDefault,
          //                       isBold: !ResponsiveHelper.isDesktop(context),
          //                       fontSize: ResponsiveHelper.isDesktop(context) ? Dimensions.fontSizeExtraSmall : null,
          //                     ),
          //                     const SizedBox(height: Dimensions.paddingSizeExtraLarge),

          //                     // ResponsiveHelper.isDesktop(context) ? const SizedBox() : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //                     //   Text('do_not_have_account'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

          //                     //   InkWell(
          //                     //     onTap: () {
          //                     //       if(ResponsiveHelper.isDesktop(context)){
          //                     //         Get.back();
          //                     //         Get.dialog(const SignUpScreen());
          //                     //       }else{
          //                     //         Get.toNamed(RouteHelper.getSignUpRoute());
          //                     //       }
          //                     //     },
          //                     //     child: Padding(
          //                     //       padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          //                     //       child: Text('sign_up'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
          //                     //     ),
          //                     //   ),
          //                     // ]),
          //                     // const SizedBox(height: Dimensions.paddingSizeSmall),

          //                     ResponsiveHelper.isDesktop(context) ? const SizedBox() : const GuestButton(),

          //                     // ResponsiveHelper.isDesktop(context) ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //                     //   Text('do_not_have_account'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

          //                     //   InkWell(
          //                     //     onTap: () {
          //                     //       if(ResponsiveHelper.isDesktop(context)){
          //                     //         Get.back();
          //                     //         Get.dialog(const SignUpScreen());
          //                     //       }else{
          //                     //         Get.toNamed(RouteHelper.getSignUpRoute());
          //                     //       }
          //                     //     },
          //                     //     child: Padding(
          //                     //       padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          //                     //       child: Text('sign_up'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
          //                     //     ),
          //                     //   ),
          //                     // ]) :  const SizedBox(),
          //                   ]),
          //                 )
          //               ],
          //             ),
          //           ),
          //         );
          //       }),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
