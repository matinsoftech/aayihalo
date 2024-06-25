import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/custom_validator.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/custom_text_field.dart';
import 'package:sixam_mart/view/screens/auth/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();

  String _countryDialCode = '';
  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _countryDialCode = Get.find<AuthController>().getUserCountryCode().isNotEmpty ? Get.find<AuthController>().getUserCountryCode() : CountryCode.fromCountryCode(Get.find<SplashController>().configModel!.country!).dialCode!;
    _phoneController.text = Get.find<AuthController>().getUserNumber();
    _passwordController.text = Get.find<AuthController>().getUserPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AuthController>(
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
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.size.height * 0.1,
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Container(
                              height: Get.size.height * 0.75,
                              width: Get.size.width * 0.89,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                clipBehavior: Clip.none,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Positioned(
                                    top: 148,
                                    child: Text(
                                      'GROCERIES',
                                      style: opensSans.copyWith(
                                        fontSize: 40 + (Get.size.width * 0.02),
                                        color: Theme.of(Get.context!).primaryColor,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 190,
                                    child: Text(
                                      'DELIVERED',
                                      style: opensSans.copyWith(
                                        fontSize: 50 + (Get.size.width * 0.02),
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 252,
                                    child: Text(
                                      'IN 30 MINIS',
                                      style: opensSans.copyWith(
                                        fontSize: 30 + (Get.size.width * 0.02),
                                        color: Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 424,
                                    child: SizedBox(
                                      width: 300,
                                      child: CustomTextField(
                                        titleText: 'Enter Phone Number'.tr,
                                        hintText: '',
                                        controller: _phoneController,
                                        inputType: TextInputType.phone,
                                        focusNode: _phoneFocus,
                                        // isPhone: true,
                                        // showTitle: ResponsiveHelper.isDesktop(context),
                                        // onCountryChanged: (CountryCode countryCode) {
                                        //   _countryDialCode = countryCode.dialCode!;
                                        // },
                                        countryDialCode: _countryDialCode,
                                        isFillColor: true,
                                        showCountryCode: true,
                                        // countryDialCode: _countryDialCode ?? Get.find<LocalizationController>().locale.countryCode ,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 500,
                                    child: CustomButton(
                                      height: 64,
                                      width: 300,
                                      buttonText: 'Continue'.tr,
                                      onPressed: () async {
                                        String phone = _phoneController.text.trim();
                                        // String password = _passwordController.text.trim();
                                        String numberWithCountryCode = '+977$phone';
                                        PhoneValid phoneValid = await CustomValidator.isPhoneValid(numberWithCountryCode);
                                        numberWithCountryCode = phoneValid.phone;

                                        if (phone.isEmpty) {
                                          showCustomSnackBar('enter_phone_number'.tr);
                                        } else if (!phoneValid.isValid) {
                                          showCustomSnackBar('invalid_phone_number'.tr);
                                        } else {
                                          final res = await authController.loginWithPhoneNumber(phone);

                                          // print(res);

                                          if (res.isSuccess) {
                                            Get.to(
                                              VerifyOTPScreen(
                                                phoneNumber: phone,
                                                countryCode: _countryDialCode,
                                              ),
                                            );
                                          } else {
                                            showCustomSnackBar('Something went wrong');
                                          }
                                        }
                                      },
                                      isLoading: authController.isLoading,
                                      radius: ResponsiveHelper.isDesktop(context) ? Dimensions.radiusSmall : Dimensions.radiusDefault,
                                      isBold: !ResponsiveHelper.isDesktop(context),
                                      fontSize: ResponsiveHelper.isDesktop(context) ? Dimensions.fontSizeExtraSmall : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -90,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'By continuing you agree to our',
                                  style: robotoRegular,
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Terms of service',
                                      style: robotoMedium.copyWith(fontSize: 15),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '&',
                                      style: robotoMedium.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Privacy Policy',
                                      style: robotoMedium.copyWith(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        //      Center(
        //   child: Container(
        //     height: ResponsiveHelper.isDesktop(context) ? 690 : null,
        //     width: context.width > 700 ? 500 : context.width,
        //     padding: context.width > 700 ? const EdgeInsets.symmetric(horizontal: 0) : const EdgeInsets.all(Dimensions.paddingSizeExtremeLarge),
        //     //margin: context.width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : EdgeInsets.zero,
        //     decoration: context.width > 700
        //         ? BoxDecoration(
        //             color: Theme.of(context).cardColor,
        //             borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        //             boxShadow: ResponsiveHelper.isDesktop(context) ? null : [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
        //           )
        //         : null,
        //     child: GetBuilder<AuthController>(builder: (authController) {
        //       return Center(
        //         child: SingleChildScrollView(
        //           child: Stack(
        //             children: [
        //               Padding(
        //                 padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.all(40) : EdgeInsets.zero,
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     Image.asset(Images.logo, width: 125),
        //                     // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        //                     // Center(child: Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
        //                     const SizedBox(height: Dimensions.paddingSizeExtraLarge),

        //                     Align(
        //                       alignment: Get.find<LocalizationController>().isLtr ? Alignment.topLeft : Alignment.topRight,
        //                       child: Text('sign_in'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
        //                     ),
        //                     const SizedBox(height: Dimensions.paddingSizeDefault),

        // CustomTextField(
        //   titleText: ResponsiveHelper.isDesktop(context) ? 'phone'.tr : 'enter_phone_number'.tr,
        //   hintText: '',
        //   controller: _phoneController,
        //   inputType: TextInputType.phone,
        //   // isPhone: true,
        //   showTitle: ResponsiveHelper.isDesktop(context),
        //   // onCountryChanged: (CountryCode countryCode) {
        //   //   _countryDialCode = countryCode.dialCode!;
        //   // },
        //   // countryDialCode: _countryDialCode ?? Get.find<LocalizationController>().locale.countryCode,
        // ),

        //                     const SizedBox(
        //                       height: Dimensions.paddingSizeExtraLarge,
        //                     ),

        //                     // CustomTextField(
        //                     //   titleText: ResponsiveHelper.isDesktop(context) ? 'password'.tr : 'enter_your_password'.tr,
        //                     //   hintText: 'enter_your_password'.tr,
        //                     //   controller: _passwordController,
        //                     //   focusNode: _passwordFocus,
        //                     //   inputAction: TextInputAction.done,
        //                     //   inputType: TextInputType.visiblePassword,
        //                     //   prefixIcon: Icons.lock,
        //                     //   isPassword: true,
        //                     //   showTitle: ResponsiveHelper.isDesktop(context),
        //                     //   onSubmit: (text) => (GetPlatform.isWeb) ? _login(authController, _countryDialCode!) : null,
        //                     //   onChanged: (value){
        //                     //     if(value != null && value.isNotEmpty){
        //                     //       if(!authController.showPassView){
        //                     //         authController.showHidePass();
        //                     //       }
        //                     //       authController.validPassCheck(value);
        //                     //     }else{
        //                     //       if(authController.showPassView){
        //                     //         authController.showHidePass();
        //                     //       }
        //                     //     }
        //                     //   },
        //                     // ),
        //                     // const SizedBox(height: Dimensions.paddingSizeSmall),

        //                     // Row(
        //                     //   children: [
        //                     //     Expanded(
        //                     //       child: ListTile(
        //                     //         onTap: () =>
        //                     //             authController.toggleRememberMe(),
        //                     //         leading: Checkbox(
        //                     //           visualDensity: const VisualDensity(
        //                     //               horizontal: -4, vertical: -4),
        //                     //           activeColor:
        //                     //               Theme.of(context).primaryColor,
        //                     //           value:
        //                     //               authController.isActiveRememberMe,
        //                     //           onChanged: (bool? isChecked) =>
        //                     //               authController.toggleRememberMe(),
        //                     //         ),
        //                     //         title: Text('remember_me'.tr),
        //                     //         contentPadding: EdgeInsets.zero,
        //                     //         visualDensity: const VisualDensity(
        //                     //             horizontal: 0, vertical: -4),
        //                     //         dense: true,
        //                     //         horizontalTitleGap: 0,
        //                     //       ),
        //                     //     ),
        //                     //   ],
        //                     // ),

        //                     // const SizedBox(
        //                     //     height: Dimensions.paddingSizeLarge),

        //                     Align(alignment: Alignment.center, child: ConditionCheckBox(authController: authController, fromSignUp: false)),

        //                     const SizedBox(height: Dimensions.paddingSizeDefault),

        // CustomButton(
        //   height: ResponsiveHelper.isDesktop(context) ? 45 : null,
        //   width: ResponsiveHelper.isDesktop(context) ? 180 : null,
        //   buttonText: ResponsiveHelper.isDesktop(context) ? 'login'.tr : 'sign_in'.tr,
        //   onPressed: () async {
        //     String phone = _phoneController.text.trim();
        //     String password = _passwordController.text.trim();
        //     String numberWithCountryCode = '+977$phone';
        //     PhoneValid phoneValid = await CustomValidator.isPhoneValid(numberWithCountryCode);
        //     numberWithCountryCode = phoneValid.phone;

        //     if (phone.isEmpty) {
        //       showCustomSnackBar('enter_phone_number'.tr);
        //     } else if (!phoneValid.isValid) {
        //       showCustomSnackBar('invalid_phone_number'.tr);
        //     } else {
        //       final res = await authController.loginWithPhoneNumber(phone);

        //       print(res);

        //       if (res.isSuccess) {
        //         Get.to(VerifyOTPScreen(phoneNumber: phone));
        //       } else {
        //         showCustomSnackBar('Something went wrong');
        //       }
        //     }
        //   },
        //   isLoading: authController.isLoading,
        //   radius: ResponsiveHelper.isDesktop(context) ? Dimensions.radiusSmall : Dimensions.radiusDefault,
        //   isBold: !ResponsiveHelper.isDesktop(context),
        //   fontSize: ResponsiveHelper.isDesktop(context) ? Dimensions.fontSizeExtraSmall : null,
        // ),
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
        //                   ],
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       );
        //     }),
        //   ),
        // )
      ),
    );
  }
}
