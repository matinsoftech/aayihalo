import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/controller/wishlist_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/confirmation_dialog.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/screens/auth/sign_in_screen.dart';
import 'package:sixam_mart/view/screens/menu/widget/portion_widget.dart';

class MenuScreenNew extends StatefulWidget {
  const MenuScreenNew({Key? key}) : super(key: key);

  @override
  State<MenuScreenNew> createState() => _MenuScreenNewState();
}

class _MenuScreenNewState extends State<MenuScreenNew> {
  @override
  Widget build(BuildContext context) {
    // print(Get.find<UserController>().userInfoModel!.image);
    return Scaffold(
      // backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<UserController>(
        builder: (userController) {
          final bool isLoggedIn = Get.find<AuthController>().isLoggedIn();

          return Column(
            children: [
              AppBar(
                elevation: 0.3,
                title: Text(
                  'My Account',
                  style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Ink(
                    // color: Theme.of(context).primaryColor.withOpacity(0.1),
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          //?
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  // color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                // padding: const EdgeInsets.symmetric(vertical: 8),
                                child: ClipOval(
                                  child: CustomImage(
                                    placeholder: Images.guestIconLight,
                                    image: (userController.userInfoModel != null && isLoggedIn && userController.userInfoModel!.image != null && userController.userInfoModel!.image!.isNotEmpty) ? '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${userController.userInfoModel!.image}' : '',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isLoggedIn ? '${userController.userInfoModel?.phone}' : 'guest_user'.tr,
                                      //  isLoggedIn ? '${userController.userInfoModel?.fName} ${userController.userInfoModel?.lName}' : 'guest_user'.tr,
                                      style: robotoBold.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        // color: Theme.of(context).cardColor,
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                    isLoggedIn
                                        ? const SizedBox()

                                        //  Text(
                                        //     userController.userInfoModel != null ? DateConverter.containTAndZToUTCFormat(userController.userInfoModel!.createdAt!) : '',
                                        //     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                                        //   )

                                        : InkWell(
                                            onTap: () async {
                                              if (!ResponsiveHelper.isDesktop(context)) {
                                                await Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                                              } else {
                                                Get.dialog(const SignInScreen());
                                              }
                                            },
                                            child: Text(
                                              'login_to_view_all_feature'.tr,
                                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          //? your information

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Information',
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600,
                                  // color: Theme.of(context).primaryColor.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 12),
                              //? my profile
                              PortionWidget(
                                icon: Images.profileIcon,
                                title: 'My Profile',
                                route: RouteHelper.getProfileRoute(),
                              ),
                              //? my address
                              PortionWidget(
                                icon: Images.addressIcon,
                                title: 'Saved Address',
                                hideDivider: true,
                                route: RouteHelper.getAddressRoute(),
                              ),
                              //? my orders
                              PortionWidget(
                                icon: Images.orderIcon,
                                title: 'My Orders',
                                route: RouteHelper.getProfileRoute(),
                              ),
                              //?my earning
                              const SizedBox(height: 16),

                              Text(
                                'My Earning & Vouchers',
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600,
                                  // color: Theme.of(context).primaryColor.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 12),

                              //? coupon
                              PortionWidget(
                                icon: Images.couponIcon,
                                title: 'coupon'.tr,
                                route: RouteHelper.getCouponRoute(),
                                hideDivider: Get.find<SplashController>().configModel!.loyaltyPointStatus == 1 || Get.find<SplashController>().configModel!.customerWalletStatus == 1 ? false : true,
                              ),
                              //? loyalty points
                              (Get.find<SplashController>().configModel!.loyaltyPointStatus == 1)
                                  ? PortionWidget(
                                      icon: Images.pointIcon,
                                      title: 'loyalty_points'.tr,
                                      route: RouteHelper.getWalletRoute(false),
                                      hideDivider: Get.find<SplashController>().configModel!.customerWalletStatus == 1 ? false : true,
                                      suffix: !isLoggedIn ? null : '${userController.userInfoModel?.loyaltyPoint != null ? userController.userInfoModel!.loyaltyPoint.toString() : '0'} ${'points'.tr}',
                                    )
                                  : const SizedBox(),
                              //? my wallet
                              (Get.find<SplashController>().configModel!.customerWalletStatus == 1)
                                  ? PortionWidget(
                                      icon: Images.walletIcon,
                                      title: 'my_wallet'.tr,
                                      hideDivider: true,
                                      route: RouteHelper.getWalletRoute(true),
                                      suffix: !isLoggedIn ? null : PriceConverter.convertPrice(userController.userInfoModel != null ? userController.userInfoModel!.walletBalance : 0),
                                    )
                                  : const SizedBox(),
                              //? refer & earn
                              (Get.find<SplashController>().configModel!.refEarningStatus == 1)
                                  ? PortionWidget(
                                      icon: Images.referIcon,
                                      title: 'refer_and_earn'.tr,
                                      route: RouteHelper.getReferAndEarnRoute(),
                                      hideDivider: (Get.find<SplashController>().configModel!.toggleDmRegistration! && !ResponsiveHelper.isDesktop(context)) || (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context)) ? false : true,
                                    )
                                  : const SizedBox(),

                              //?career
                              const SizedBox(height: 16),
                              Text(
                                'Career',
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600,
                                  // color: Theme.of(context).primaryColor.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 12),
                              //? join as deliver man
                              (Get.find<SplashController>().configModel!.refEarningStatus == 1) || (Get.find<SplashController>().configModel!.toggleDmRegistration! && !ResponsiveHelper.isDesktop(context)) || (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context))
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            (Get.find<SplashController>().configModel!.toggleDmRegistration! && !ResponsiveHelper.isDesktop(context))
                                                ? PortionWidget(
                                                    icon: Images.dmIcon,
                                                    title: 'join_as_a_delivery_man'.tr,
                                                    route: RouteHelper.getDeliverymanRegistrationRoute(),
                                                    hideDivider: true,
                                                    //  (Get.find<
                                                    //                 SplashController>()
                                                    //             .configModel!
                                                    //             .toggleStoreRegistration! &&
                                                    //         !ResponsiveHelper.isDesktop(
                                                    //             context))
                                                    //     ? false
                                                    //     : true,
                                                  )
                                                : const SizedBox(),

                                            // (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context)) ? PortionWidget(
                                            //     icon: Images.storeIcon, title: 'open_store'.tr, hideDivider: true, route: RouteHelper.getRestaurantRegistrationRoute(),
                                            // ) : const SizedBox(),
                                          ],
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 16),
                              //? other information
                              Text(
                                'Other Information',
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600,
                                  // color: Theme.of(context).primaryColor.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 12),

                              //? about us
                              PortionWidget(
                                icon: Images.aboutIcon,
                                title: 'about_us'.tr,
                                route: RouteHelper.getHtmlRoute('about-us'),
                              ),
                              //? customer support
                              PortionWidget(
                                icon: Images.helpIcon,
                                title: "Customer Support & FAQ's",
                                route: RouteHelper.getSupportRoute(),
                              ),
                              //? terms and conditions
                              PortionWidget(
                                icon: Images.termsIcon,
                                title: 'terms_conditions'.tr,
                                route: RouteHelper.getHtmlRoute('terms-and-condition'),
                              ),
                              //? privacy policy
                              PortionWidget(
                                icon: Images.privacyIcon,
                                title: 'privacy_policy'.tr,
                                route: RouteHelper.getHtmlRoute('privacy-policy'),
                              ),
                              //? live support
                              PortionWidget(
                                icon: Images.chatIcon,
                                title: "Live Support",
                                route: RouteHelper.getConversationRoute(),
                              ),
                              //? refund policy
                              // (Get.find<SplashController>().configModel!.refundPolicyStatus == 1)
                              //     ? PortionWidget(
                              //         icon: Images.refundIcon,
                              //         title: 'refund_policy'.tr,
                              //         route: RouteHelper.getHtmlRoute('refund-policy'),
                              //         hideDivider: (Get.find<SplashController>().configModel!.cancellationPolicyStatus == 1) || (Get.find<SplashController>().configModel!.shippingPolicyStatus == 1) ? false : true,
                              //       )
                              //     : const SizedBox(),
                              //? cancellation policy
                              // (Get.find<SplashController>().configModel!.cancellationPolicyStatus == 1)
                              //     ? PortionWidget(
                              //         icon: Images.cancelationIcon,
                              //         title: 'cancellation_policy'.tr,
                              //         route: RouteHelper.getHtmlRoute('cancellation-policy'),
                              //         hideDivider: (Get.find<SplashController>().configModel!.shippingPolicyStatus == 1) ? false : true,
                              //       )
                              //     : const SizedBox(),
                              (Get.find<SplashController>().configModel!.shippingPolicyStatus == 1)
                                  ? PortionWidget(
                                      icon: Images.shippingIcon,
                                      title: 'shipping_policy'.tr,
                                      hideDivider: true,
                                      route: RouteHelper.getHtmlRoute('shipping-policy'),
                                    )
                                  : const SizedBox(),
                              //? log out
                              InkWell(
                                onTap: () {
                                  if (Get.find<AuthController>().isLoggedIn()) {
                                    Get.dialog(
                                        ConfirmationDialog(
                                          icon: Images.support,
                                          description: 'are_you_sure_to_logout'.tr,
                                          isLogOut: true,
                                          onYesPressed: () {
                                            Get.find<UserController>().clearUserInfo();
                                            Get.find<AuthController>().clearSharedData();
                                            Get.find<AuthController>().socialLogout();
                                            Get.find<WishListController>().removeWishes();
                                            if (ResponsiveHelper.isDesktop(context)) {
                                              Get.offAllNamed(RouteHelper.getInitialRoute());
                                            } else {
                                              Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                                            }
                                          },
                                        ),
                                        useSafeArea: false);
                                  } else {
                                    Get.find<WishListController>().removeWishes();
                                    Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0.4),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset('assets/aihalyo/logout.png', height: 16, width: 16),
                                          const SizedBox(width: Dimensions.paddingSizeSmall),
                                          Expanded(
                                            child: Text(
                                              Get.find<AuthController>().isLoggedIn() ? 'logout'.tr : 'sign_in'.tr,
                                              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                                            ),
                                          ),
                                          // suffix != null
                                          //     ? Container(
                                          //         decoration: BoxDecoration(
                                          //           color: Theme.of(context).colorScheme.error,
                                          //           borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                          //         ),
                                          //         padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
                                          //         child: Text(
                                          //           suffix!,
                                          //           style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),
                                          //           textDirection: TextDirection.ltr,
                                          //         ),
                                          //       )
                                          //     : const SizedBox(),
                                        ],
                                      ),
                                      // hideDivider ? const SizedBox() : const Divider()
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),

                          // InkWell(
                          //   onTap: () {
                          //     if (Get.find<AuthController>().isLoggedIn()) {
                          //       Get.dialog(
                          //           ConfirmationDialog(
                          //             icon: Images.support,
                          //             description: 'are_you_sure_to_logout'.tr,
                          //             isLogOut: true,
                          //             onYesPressed: () {
                          //               Get.find<UserController>().clearUserInfo();
                          //               Get.find<AuthController>().clearSharedData();
                          //               Get.find<AuthController>().socialLogout();
                          //               Get.find<WishListController>().removeWishes();
                          //               if (ResponsiveHelper.isDesktop(context)) {
                          //                 Get.offAllNamed(RouteHelper.getInitialRoute());
                          //               } else {
                          //                 Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                          //               }
                          //             },
                          //           ),
                          //           useSafeArea: false);
                          //     } else {
                          //       Get.find<WishListController>().removeWishes();
                          //       Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                          //     }
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          //       Container(
                          //         padding: const EdgeInsets.all(2),
                          //         decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                          //         child: Icon(Icons.power_settings_new_sharp, size: 18, color: Theme.of(context).cardColor),
                          //       ),
                          //       const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                          //       Text(Get.find<AuthController>().isLoggedIn() ? 'logout'.tr : 'sign_in'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge))
                          //     ]),
                          //   ),
                          // ),

                          SizedBox(height: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : 130),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomProfileButtons extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? route;
  const CustomProfileButtons({
    required this.icon,
    required this.title,
    this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(route.toString()),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 0.4),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
