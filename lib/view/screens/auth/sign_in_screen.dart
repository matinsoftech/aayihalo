import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/localization_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/custom_validator.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/custom_text_field.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/screens/auth/sign_up_screen.dart';
import 'package:sixam_mart/view/screens/auth/verify_otp_screen.dart';
import 'package:sixam_mart/view/screens/auth/widget/condition_check_box.dart';
import 'package:sixam_mart/view/screens/auth/widget/guest_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/auth/widget/social_login_widget.dart';

class SignInScree extends StatefulWidget {
  final bool exitFromApp;
  final bool backFromThis;
  const SignInScree(
      {Key? key, required this.exitFromApp, required this.backFromThis})
      : super(key: key);

  @override
  SignInScreeState createState() => SignInScreeState();
}

class SignInScreeState extends State<SignInScree> {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _countryDialCode;
  bool _canExit = GetPlatform.isWeb ? true : false;

  // @override
  // void initState() {
  //   super.initState();

  //   _countryDialCode =
  //       Get.find<AuthController>().getUserCountryCode().isNotEmpty
  //           ? Get.find<AuthController>().getUserCountryCode()
  //           : CountryCode.fromCountryCode(
  //                   Get.find<SplashController>().configModel!.country!)
  //               .dialCode;
  //   _phoneController.text = Get.find<AuthController>().getUserNumber();
  //   _passwordController.text = Get.find<AuthController>().getUserPassword();
  //   if (Get.find<AuthController>().showPassView) {
  //     Get.find<AuthController>().showHidePass(isUpdate: false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveHelper.isDesktop(context)
          ? Colors.transparent
          : Theme.of(context).cardColor,
      appBar: (ResponsiveHelper.isDesktop(context)
          ? null
          : !widget.exitFromApp
              ? AppBar(
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_rounded,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: const [SizedBox()],
                )
              : null),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body:
      
       SafeArea(
          child: Scrollbar(
        child: Center(
          child: Container(
            height: ResponsiveHelper.isDesktop(context) ? 690 : null,
            width: context.width > 700 ? 500 : context.width,
            padding: context.width > 700
                ? const EdgeInsets.symmetric(horizontal: 0)
                : const EdgeInsets.all(Dimensions.paddingSizeExtremeLarge),
            //margin: context.width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : EdgeInsets.zero,
            decoration: context.width > 700
                ? BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow: ResponsiveHelper.isDesktop(context)
                        ? null
                        : [
                            BoxShadow(
                                color:
                                    Colors.grey[Get.isDarkMode ? 700 : 300]!,
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                  )
                : null,
            child: GetBuilder<AuthController>(builder: (authController) {
              return Center(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      ResponsiveHelper.isDesktop(context)
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => Get.back(),
                                  icon: const Icon(Icons.clear),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: ResponsiveHelper.isDesktop(context)
                            ? const EdgeInsets.all(40)
                            : EdgeInsets.zero,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Images.logo, width: 125),
                              // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                              // Center(child: Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraLarge),
    
                              Align(
                                alignment:
                                    Get.find<LocalizationController>().isLtr
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                child: Text('sign_in'.tr,
                                    style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraLarge)),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
    
                              CustomTextField(
                                titleText: ResponsiveHelper.isDesktop(context)
                                    ? 'phone'.tr
                                    : 'enter_phone_number'.tr,
                                hintText: '',
                                controller: _phoneController,
                                focusNode: _phoneFocus,
                                nextFocus: _passwordFocus,
                                inputType: TextInputType.phone,
                                isPhone: true,
                                showTitle:
                                    ResponsiveHelper.isDesktop(context),
                                onCountryChanged: (CountryCode countryCode) {
                                  _countryDialCode = countryCode.dialCode;
                                },
                                countryDialCode: _countryDialCode ??
                                    Get.find<LocalizationController>()
                                        .locale
                                        .countryCode,
                              ),
    
                              const SizedBox(
                                height: Dimensions.paddingSizeExtraLarge,
                              ),
    
                              // CustomTextField(
                              //   titleText: ResponsiveHelper.isDesktop(context) ? 'password'.tr : 'enter_your_password'.tr,
                              //   hintText: 'enter_your_password'.tr,
                              //   controller: _passwordController,
                              //   focusNode: _passwordFocus,
                              //   inputAction: TextInputAction.done,
                              //   inputType: TextInputType.visiblePassword,
                              //   prefixIcon: Icons.lock,
                              //   isPassword: true,
                              //   showTitle: ResponsiveHelper.isDesktop(context),
                              //   onSubmit: (text) => (GetPlatform.isWeb) ? _login(authController, _countryDialCode!) : null,
                              //   onChanged: (value){
                              //     if(value != null && value.isNotEmpty){
                              //       if(!authController.showPassView){
                              //         authController.showHidePass();
                              //       }
                              //       authController.validPassCheck(value);
                              //     }else{
                              //       if(authController.showPassView){
                              //         authController.showHidePass();
                              //       }
                              //     }
                              //   },
                              // ),
                              // const SizedBox(height: Dimensions.paddingSizeSmall),
    
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: ListTile(
                              //         onTap: () =>
                              //             authController.toggleRememberMe(),
                              //         leading: Checkbox(
                              //           visualDensity: const VisualDensity(
                              //               horizontal: -4, vertical: -4),
                              //           activeColor:
                              //               Theme.of(context).primaryColor,
                              //           value:
                              //               authController.isActiveRememberMe,
                              //           onChanged: (bool? isChecked) =>
                              //               authController.toggleRememberMe(),
                              //         ),
                              //         title: Text('remember_me'.tr),
                              //         contentPadding: EdgeInsets.zero,
                              //         visualDensity: const VisualDensity(
                              //             horizontal: 0, vertical: -4),
                              //         dense: true,
                              //         horizontalTitleGap: 0,
                              //       ),
                              //     ),
                              //   ],
                              // ),
    
                              // const SizedBox(
                              //     height: Dimensions.paddingSizeLarge),
    
                              Align(
                                  alignment: Alignment.center,
                                  child: ConditionCheckBox(
                                      authController: authController,
                                      fromSignUp: false)),
    
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
    
                              CustomButton(
                                height: ResponsiveHelper.isDesktop(context)
                                    ? 45
                                    : null,
                                width: ResponsiveHelper.isDesktop(context)
                                    ? 180
                                    : null,
                                buttonText:
                                    ResponsiveHelper.isDesktop(context)
                                        ? 'login'.tr
                                        : 'sign_in'.tr,
                                onPressed: ()  async{
    
                                   String phone = _phoneController.text.trim();
        String password = _passwordController.text.trim();
        String numberWithCountryCode = '+977' + phone;
        PhoneValid phoneValid =
      await CustomValidator.isPhoneValid(numberWithCountryCode);
        numberWithCountryCode = phoneValid.phone;
    
        if (phone.isEmpty) {
    showCustomSnackBar('enter_phone_number'.tr);
        } else if (!phoneValid.isValid) {
    showCustomSnackBar('invalid_phone_number'.tr);
        } else {
         final res = await  authController
        .loginWithPhoneNumber(phone); 
    
        print(res);
    
        if(res.isSuccess){
           Get.find<CartController>().getCartDataOnline(); 
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>VerifyOTPScreen(phoneNumber: phone,),),);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>VerifyOTPScreen(phoneNumber: phone,),),);
         
        }
        else{
          showCustomSnackBar('Something went wrong');
        }
       
      
    }
                                }
                                  ,
                                isLoading: authController.isLoading,
                                radius: ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.radiusSmall
                                    : Dimensions.radiusDefault,
                                isBold: !ResponsiveHelper.isDesktop(context),
                                fontSize: ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.fontSizeExtraSmall
                                    : null,
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraLarge),
    
                              // ResponsiveHelper.isDesktop(context) ? const SizedBox() : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              //   Text('do_not_have_account'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
    
                              //   InkWell(
                              //     onTap: () {
                              //       if(ResponsiveHelper.isDesktop(context)){
                              //         Get.back();
                              //         Get.dialog(const SignUpScreen());
                              //       }else{
                              //         Get.toNamed(RouteHelper.getSignUpRoute());
                              //       }
                              //     },
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                              //       child: Text('sign_up'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
                              //     ),
                              //   ),
                              // ]),
                              // const SizedBox(height: Dimensions.paddingSizeSmall),
    
                              ResponsiveHelper.isDesktop(context)
                                  ? const SizedBox()
                                  : const GuestButton(),
    
                              // ResponsiveHelper.isDesktop(context) ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              //   Text('do_not_have_account'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
    
                              //   InkWell(
                              //     onTap: () {
                              //       if(ResponsiveHelper.isDesktop(context)){
                              //         Get.back();
                              //         Get.dialog(const SignUpScreen());
                              //       }else{
                              //         Get.toNamed(RouteHelper.getSignUpRoute());
                              //       }
                              //     },
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                              //       child: Text('sign_up'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
                              //     ),
                              //   ),
                              // ]) :  const SizedBox(),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      )),
    
    
    );
  }

  void _login(AuthController authController, String countryDialCode) async {
   
    }
  }



class SignInScreen extends StatefulWidget {

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
    final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController(); 

  String _countryDialCode = '';

  @override
  void initState() {
    super.initState();

    _countryDialCode =
        Get.find<AuthController>().getUserCountryCode().isNotEmpty
            ? Get.find<AuthController>().getUserCountryCode()
            : CountryCode.fromCountryCode(
                    Get.find<SplashController>().configModel!.country!)
                .dialCode!;
    _phoneController.text = Get.find<AuthController>().getUserNumber();
    _passwordController.text = Get.find<AuthController>().getUserPassword();
   
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold( 

    appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_rounded,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: const [SizedBox()],
                ),


                  body:
      
       SafeArea(
          child: Scrollbar(
        child: Center(
          child: Container(
            height: ResponsiveHelper.isDesktop(context) ? 690 : null,
            width: context.width > 700 ? 500 : context.width,
            padding: context.width > 700
                ? const EdgeInsets.symmetric(horizontal: 0)
                : const EdgeInsets.all(Dimensions.paddingSizeExtremeLarge),
            //margin: context.width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : EdgeInsets.zero,
            decoration: context.width > 700
                ? BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow: ResponsiveHelper.isDesktop(context)
                        ? null
                        : [
                            BoxShadow(
                                color:
                                    Colors.grey[Get.isDarkMode ? 700 : 300]!,
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                  )
                : null,
            child: GetBuilder<AuthController>(builder: (authController) {
              return Center(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      ResponsiveHelper.isDesktop(context)
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => Get.back(),
                                  icon: const Icon(Icons.clear),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: ResponsiveHelper.isDesktop(context)
                            ? const EdgeInsets.all(40)
                            : EdgeInsets.zero,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Images.logo, width: 125),
                              // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                              // Center(child: Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraLarge),
    
                              Align(
                                alignment:
                                    Get.find<LocalizationController>().isLtr
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                child: Text('sign_in'.tr,
                                    style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraLarge)),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
    
                              CustomTextField(
                                titleText: ResponsiveHelper.isDesktop(context)
                                    ? 'phone'.tr
                                    : 'enter_phone_number'.tr,
                                hintText: '',
                                controller: _phoneController,
                               
                                inputType: TextInputType.phone,
                                isPhone: true,
                                showTitle:
                                    ResponsiveHelper.isDesktop(context),
                                onCountryChanged: (CountryCode countryCode) {
                                  _countryDialCode = countryCode.dialCode!;
                                },
                                countryDialCode: _countryDialCode ??
                                    Get.find<LocalizationController>()
                                        .locale
                                        .countryCode,
                              ),
    
                              const SizedBox(
                                height: Dimensions.paddingSizeExtraLarge,
                              ),
    
                              // CustomTextField(
                              //   titleText: ResponsiveHelper.isDesktop(context) ? 'password'.tr : 'enter_your_password'.tr,
                              //   hintText: 'enter_your_password'.tr,
                              //   controller: _passwordController,
                              //   focusNode: _passwordFocus,
                              //   inputAction: TextInputAction.done,
                              //   inputType: TextInputType.visiblePassword,
                              //   prefixIcon: Icons.lock,
                              //   isPassword: true,
                              //   showTitle: ResponsiveHelper.isDesktop(context),
                              //   onSubmit: (text) => (GetPlatform.isWeb) ? _login(authController, _countryDialCode!) : null,
                              //   onChanged: (value){
                              //     if(value != null && value.isNotEmpty){
                              //       if(!authController.showPassView){
                              //         authController.showHidePass();
                              //       }
                              //       authController.validPassCheck(value);
                              //     }else{
                              //       if(authController.showPassView){
                              //         authController.showHidePass();
                              //       }
                              //     }
                              //   },
                              // ),
                              // const SizedBox(height: Dimensions.paddingSizeSmall),
    
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: ListTile(
                              //         onTap: () =>
                              //             authController.toggleRememberMe(),
                              //         leading: Checkbox(
                              //           visualDensity: const VisualDensity(
                              //               horizontal: -4, vertical: -4),
                              //           activeColor:
                              //               Theme.of(context).primaryColor,
                              //           value:
                              //               authController.isActiveRememberMe,
                              //           onChanged: (bool? isChecked) =>
                              //               authController.toggleRememberMe(),
                              //         ),
                              //         title: Text('remember_me'.tr),
                              //         contentPadding: EdgeInsets.zero,
                              //         visualDensity: const VisualDensity(
                              //             horizontal: 0, vertical: -4),
                              //         dense: true,
                              //         horizontalTitleGap: 0,
                              //       ),
                              //     ),
                              //   ],
                              // ),
    
                              // const SizedBox(
                              //     height: Dimensions.paddingSizeLarge),
    
                              Align(
                                  alignment: Alignment.center,
                                  child: ConditionCheckBox(
                                      authController: authController,
                                      fromSignUp: false)),
    
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
    
                              CustomButton(
                                height: ResponsiveHelper.isDesktop(context)
                                    ? 45
                                    : null,
                                width: ResponsiveHelper.isDesktop(context)
                                    ? 180
                                    : null,
                                buttonText:
                                    ResponsiveHelper.isDesktop(context)
                                        ? 'login'.tr
                                        : 'sign_in'.tr,
                                onPressed: ()  async{
    
                                   String phone = _phoneController.text.trim();
        String password = _passwordController.text.trim();
        String numberWithCountryCode = '+977' + phone;
        PhoneValid phoneValid =
      await CustomValidator.isPhoneValid(numberWithCountryCode);
        numberWithCountryCode = phoneValid.phone;
    
        if (phone.isEmpty) {
    showCustomSnackBar('enter_phone_number'.tr);
        } else if (!phoneValid.isValid) {
    showCustomSnackBar('invalid_phone_number'.tr);
        } else {
         final res = await  authController
        .loginWithPhoneNumber(phone); 
    
        print(res);
    
        if(res.isSuccess){
          Get.to(VerifyOTPScreen(phoneNumber: phone));
         
         
        }
        else{
          showCustomSnackBar('Something went wrong');
        }
       
      
    }
                                }
                                  ,
                                isLoading: authController.isLoading,
                                radius: ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.radiusSmall
                                    : Dimensions.radiusDefault,
                                isBold: !ResponsiveHelper.isDesktop(context),
                                fontSize: ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.fontSizeExtraSmall
                                    : null,
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraLarge),
    
                              // ResponsiveHelper.isDesktop(context) ? const SizedBox() : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              //   Text('do_not_have_account'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
    
                              //   InkWell(
                              //     onTap: () {
                              //       if(ResponsiveHelper.isDesktop(context)){
                              //         Get.back();
                              //         Get.dialog(const SignUpScreen());
                              //       }else{
                              //         Get.toNamed(RouteHelper.getSignUpRoute());
                              //       }
                              //     },
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                              //       child: Text('sign_up'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
                              //     ),
                              //   ),
                              // ]),
                              // const SizedBox(height: Dimensions.paddingSizeSmall),
    
                              ResponsiveHelper.isDesktop(context)
                                  ? const SizedBox()
                                  : const GuestButton(),
    
                              // ResponsiveHelper.isDesktop(context) ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              //   Text('do_not_have_account'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
    
                              //   InkWell(
                              //     onTap: () {
                              //       if(ResponsiveHelper.isDesktop(context)){
                              //         Get.back();
                              //         Get.dialog(const SignUpScreen());
                              //       }else{
                              //         Get.toNamed(RouteHelper.getSignUpRoute());
                              //       }
                              //     },
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                              //       child: Text('sign_up'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
                              //     ),
                              //   ),
                              // ]) :  const SizedBox(),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      )),
    
    
   );
  } 
}