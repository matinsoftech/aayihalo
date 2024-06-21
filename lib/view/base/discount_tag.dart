import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscountTag extends StatelessWidget {
  final double? discount;
  final String? discountType;
  final double fromTop;
  final double? fontSize;
  final bool inLeft;
  final bool? freeDelivery;
  final bool? isFloating;
  const DiscountTag({
    Key? key,
    required this.discount,
    required this.discountType,
    this.fromTop = 5,
    this.fontSize,
    this.freeDelivery = false,
    this.inLeft = true,
    this.isFloating = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
    String currencySymbol = Get.find<SplashController>().configModel!.currencySymbol!;
    // print('discount $discount');
    // print("isRightSide $isRightSide");
    // print("discount Type $discountType");
    return (discount! > 0 || freeDelivery!)
        ? Positioned(
            top: fromTop,
            left: inLeft
                ? isFloating!
                    ? 12
                    : 0
                : null,
            right: inLeft ? null : 0,
            child: Container(
              width: 30,
              height: 40,
              // height: 78,
              // padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: const BoxDecoration(
                  // color: Theme.of(context).colorScheme.primary,
                  // borderRadius: BorderRadius.horizontal(
                  //   right: Radius.circular(isFloating!
                  //       ? Dimensions.radiusLarge
                  //       : inLeft
                  //           ? Dimensions.radiusSmall
                  //           : 0),
                  //   left: Radius.circular(isFloating!
                  //       ? Dimensions.radiusLarge
                  //       : inLeft
                  //           ? 0
                  //           : Dimensions.radiusSmall),
                  // ),
                  ),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/image/grs.png',
                    fit: BoxFit.cover,
                  ),
                  discount! > 0
                      ? Positioned(
                          top: discountType == 'percent' ? 6 : 10,
                          left: discountType == 'percent' ? 6 : 2,
                          child: discountType == 'percent'
                              ? Text(
                                  // discount! > 0
                                  '${discount!.toInt()} % \nOFF',
                                  //     ? '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}$discount${discountType == 'percent' ? '%' : isRightSide ? currencySymbol : ''} ${'off'.tr}'
                                  //     : 'free_delivery'.tr,
                                  style: robotoMedium.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    // fontSize: fontSize ?? (ResponsiveHelper.isMobile(context) ? 8 : 12),
                                    fontSize: discountType == 'percent' ? 10 : 8,
                                    fontWeight: discountType == 'percent' ? FontWeight.w400 : FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  '$currencySymbol${discount!.toInt()}',
                                  // discount! > 0
                                  //     ? '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}${discount!.toInt()}${discountType == 'percent' ? '%' : isRightSide ? currencySymbol : ''} ${'off'.tr}'
                                  //     : 'free_delivery'.tr,
                                  style: robotoMedium.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: fontSize ?? (ResponsiveHelper.isMobile(context) ? 8 : 12),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        )
                      : Positioned(
                          top: 10,
                          child: Text(
                            'free_delivery'.tr,
                            style: robotoMedium.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: fontSize ?? (ResponsiveHelper.isMobile(context) ? 8 : 12),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
