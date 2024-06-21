// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/wishlist_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';

class NewItemTitleView extends StatelessWidget {
  // final Item? item;
  final bool inStorePage;
  final bool isCampaign;
  final bool fromItemDetail;
  final bool inStock;
  final List variations;
  final double productPrice;
  final String productName;
  final String unitType;
  final int veg;
  final String availableTimeStarts;
  final int productId;
  final double discount;
  final String discountType;
  const NewItemTitleView({
    Key? key,
    // required this.item,
    this.inStorePage = false,
    this.isCampaign = false,
    this.fromItemDetail = false,
    required this.inStock,
    required this.variations,
    required this.productPrice,
    required this.productName,
    required this.unitType,
    required this.veg,
    required this.availableTimeStarts,
    required this.productId,
    required this.discount,
    required this.discountType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? startingPrice;
    double? endingPrice;
    if (variations.isNotEmpty) {
      List<double?> priceList = [];
      for (var variation in variations) {
        priceList.add(variation.price);
      }
      priceList.sort((a, b) => a!.compareTo(b!));
      startingPrice = priceList[0];
      if (priceList[0]! < priceList[priceList.length - 1]!) {
        endingPrice = priceList[priceList.length - 1];
      }
    } else {
      startingPrice = productPrice;
    }
    return ResponsiveHelper.isDesktop(context)
        ? GetBuilder<ItemController>(builder: (itemController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              productName,
                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                          ((Get.find<SplashController>().configModel!.moduleConfig!.module!.unit!) || (Get.find<SplashController>().configModel!.moduleConfig!.module!.vegNonVeg! && Get.find<SplashController>().configModel!.toggleVegNonVeg!))
                              ? Text(
                                  Get.find<SplashController>().configModel!.moduleConfig!.module!.unit!
                                      ? '($unitType)'
                                      : veg == 0
                                          ? '(${'non_veg'.tr})'
                                          : '(${'veg'.tr})',
                                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    availableTimeStarts != null
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            ),
                            child: GetBuilder<WishListController>(builder: (wishController) {
                              return InkWell(
                                onTap: () {
                                  if (Get.find<AuthController>().isLoggedIn()) {
                                    if (wishController.wishItemIdList.contains(itemController.item!.id)) {
                                      wishController.removeFromWishList(itemController.item!.id, false);
                                    } else {
                                      wishController.addToWishList(itemController.item, null, false);
                                    }
                                  } else {
                                    showCustomSnackBar('you_are_not_logged_in'.tr);
                                  }
                                },
                                child: Icon(
                                  wishController.wishItemIdList.contains(itemController.item!.id) ? Icons.favorite : Icons.favorite_border,
                                  size: 25,
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            }),
                          ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        color: inStock ? Colors.red.shade50 : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      ),
                      child: Text(inStock ? 'out_of_stock'.tr : 'in_stock'.tr,
                          style: robotoRegular.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeExtraSmall,
                          )),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    // OrganicTag(item: item!, fromDetails: true),
                  ],
                ),
                // const SizedBox(height: Dimensions.paddingSizeSmall),
                // InkWell(
                //   onTap: () {
                //     if (inStorePage) {
                //       Get.back();
                //     } else {
                //       Get.offNamed(RouteHelper.getStoreRoute(id: item!.storeId, page: 'item'));
                //     }
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                //     child: Text(
                //       item!.storeName!,
                //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: Dimensions.paddingSizeSmall),
                // // RatingBar(
                // //     rating: item!.avgRating,
                // //     ratingCount: item!.ratingCount,
                // //     size: 18),
                // const SizedBox(height: Dimensions.paddingSizeSmall),
                // Row(children: [
                //   discount! > 0
                //       ? Flexible(
                //           child: Text(
                //             '${PriceConverter.convertPrice(startingPrice)}'
                //             '${endingPrice != null ? ' - ${PriceConverter.convertPrice(endingPrice)}' : ''}',
                //             textDirection: TextDirection.ltr,
                //             style: robotoRegular.copyWith(
                //               color: Theme.of(context).disabledColor,
                //               decoration: TextDecoration.lineThrough,
                //               fontSize: Dimensions.fontSizeExtraSmall,
                //             ),
                //           ),
                //         )
                //       : const SizedBox(),
                //   const SizedBox(width: 10),
                //   Text(
                //     '${PriceConverter.convertPrice(startingPrice, discount: discount, discountType: discountType)}'
                //     '${endingPrice != null ? ' - ${PriceConverter.convertPrice(endingPrice, discount: discount, discountType: discountType)}' : ''}',
                //     style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                //     textDirection: TextDirection.ltr,
                //   ),
                // ]),
              ],
            );
          })
        : Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: GetBuilder<ItemController>(
              builder: (itemController) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            productName,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // ignore: unnecessary_null_comparison
                        availableTimeStarts != null
                            ? const SizedBox()
                            : GetBuilder<WishListController>(builder: (wishController) {
                                return const Row(
                                  children: [
                                    // Text(
                                    //   wishController.localWishes.contains(item.id) ? (item.wishlistCount+1).toString() : wishController.localRemovedWishes
                                    //       .contains(item.id) ? (item.wishlistCount-1).toString() : item.wishlistCount.toString(),
                                    //   style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                                    // ),
                                    // SizedBox(width: 5),
                                  ],
                                );
                              }),
                        variations.isEmpty
                            ? GetBuilder<CartController>(
                                builder: (cartController) {
                                  int cartQty = cartController.newGetItemQuantity(itemId: productId);
                                  // print('card quantity  here is : ${cartQty != 0}');
                                  bool fromItemDetail = false;

                                  return cartQty != 0
                                      ? Center(
                                          child: Container(
                                            width: fromItemDetail ? 100 : null,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                                            ),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              InkWell(
                                                onTap: cartController.isLoading
                                                    ? null
                                                    : () {
                                                        int cartIndex = cartController.cartList.indexWhere((element) => element.item!.id == productId);
                                                        // print('cart index $cartIndex');

                                                        if (cartController.cartList[cartIndex].quantity! > 1) {
                                                          cartController.currentItemId = productId;

                                                          cartController.addToCart(quantity: cartController.cartList[cartIndex].quantity! - 1, productId: cartController.cartList[cartIndex].item!.id!, variantType: null);
                                                          // cartController.setQuantity(
                                                          //   false,
                                                          //   cartIndex,
                                                          //   cartController.cartList[cartIndex].stock,
                                                          //   cartController.cartList[cartIndex].item!
                                                          //       .quantityLimit,
                                                          // );
                                                        } else {
                                                          cartController.removeCartItemOnline(cartIndex);
                                                        }
                                                      },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).cardColor,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Theme.of(context).primaryColor),
                                                  ),
                                                  padding: const EdgeInsets.all(
                                                    Dimensions.paddingSizeExtraSmall,
                                                  ),
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: fromItemDetail ? null : 16,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                              ),
                                              cartController.isLoading && cartController.currentItemId == productId
                                                  ? SizedBox(height: 10, width: 10, child: CircularProgressIndicator(color: Theme.of(context).cardColor))
                                                  : Padding(
                                                      padding: EdgeInsets.all(fromItemDetail ? 0 : 2.0),
                                                      child: Text(
                                                        cartQty.toString(),
                                                        style: robotoMedium.copyWith(fontSize: fromItemDetail ? Dimensions.fontSizeLarge : Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                                                      ),
                                                    ),
                                              InkWell(
                                                onTap: cartController.isLoading
                                                    ? null
                                                    : () {
                                                        cartController.currentItemId = productId;

                                                        int cartIndex = cartController.cartList.indexWhere((element) => element.item!.id == productId);
                                                        cartController.addToCart(quantity: cartController.cartList[cartIndex].quantity! + 1, productId: cartController.cartList[cartIndex].item!.id!, variantType: null);
                                                      },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).cardColor,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Theme.of(context).primaryColor),
                                                  ),
                                                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: fromItemDetail ? null : 16,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        )
                                      : cartController.addingToCart && cartController.currentItemId == productId
                                          ? Text(
                                              "Adding..",
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () async {
                                                // print('going to next page...');
                                                cartController.currentItemId = productId;

                                                // product.variations != null && product.variations!.isNotEmpty
                                                // ? Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //       builder: (_) => ItemDetailsScreen(
                                                //         item: item,
                                                //         inStorePage: false,
                                                //       ),
                                                //     ),
                                                //   )
                                                // :
                                                Get.find<ItemController>().addToCart(productId: productId, quantity: 1);
                                              },
                                              child: Container(
                                                height: fromItemDetail ? 40 : 25,
                                                width: fromItemDetail ? 40 : 25,
                                                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
                                                child: Icon(Icons.add, size: fromItemDetail ? 24 : 20, color: Theme.of(context).primaryColor),
                                              ),
                                            );
                                },
                              )
                            : const SizedBox(),
                      ],
                    ),

                    // const SizedBox(height: 5),

                    // InkWell(
                    //   onTap: () {
                    //     if(inStorePage) {
                    //       Get.back();
                    //     }else {
                    //       Get.offNamed(RouteHelper.getStoreRoute(id: item!.storeId, page: 'item'));
                    //     }
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                    //     child: Text(
                    //       item!.storeName!,
                    //       style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    //     ),
                    //   ),
                    // ),
                    variations.isNotEmpty ? const SizedBox() : const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        variations.isNotEmpty
                            ? const SizedBox()
                            : Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${PriceConverter.convertPrice(startingPrice, discount: discount, discountType: discountType)}'
                                      '${endingPrice != null ? ' - ${PriceConverter.convertPrice(endingPrice, discount: discount, discountType: discountType)}' : ''}',
                                      style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),
                                      textDirection: TextDirection.ltr,
                                    ),
                                    const SizedBox(height: 5),
                                    discount > 0
                                        ? Text(
                                            '${PriceConverter.convertPrice(startingPrice)}'
                                            '${endingPrice != null ? ' - ${PriceConverter.convertPrice(endingPrice)}' : ''}',
                                            textDirection: TextDirection.ltr,
                                            style: robotoRegular.copyWith(color: Theme.of(context).hintColor, decoration: TextDecoration.lineThrough),
                                          )
                                        : const SizedBox(),
                                    SizedBox(height: discount > 0 ? 5 : 0),
                                    // !isCampaign
                                    //     ? Row(
                                    //         children: [
                                    // Text(
                                    //     item!.avgRating!
                                    //         .toStringAsFixed(1),
                                    //     style: robotoRegular.copyWith(
                                    //       color:
                                    //           Theme.of(context).hintColor,
                                    //       fontSize:
                                    //           Dimensions.fontSizeLarge,
                                    //     )),
                                    // const SizedBox(width: 5),
                                    // RatingBar(
                                    //     rating: item!.avgRating,
                                    //     ratingCount: item!.ratingCount),
                                    //     ],
                                    //   )
                                    // : const SizedBox(),
                                  ],
                                ),
                              ),
                        Column(
                          children: [
                            ((Get.find<SplashController>().configModel!.moduleConfig!.module!.unit!) || (Get.find<SplashController>().configModel!.moduleConfig!.module!.vegNonVeg! && Get.find<SplashController>().configModel!.toggleVegNonVeg!))
                                ? Container(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      Get.find<SplashController>().configModel!.moduleConfig!.module!.unit!
                                          ? unitType
                                          : veg == 0
                                              ? 'non_veg'.tr
                                              : 'veg'.tr,
                                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),
                                    ),
                                  )
                                : const SizedBox(),
                            variations.isNotEmpty ? const SizedBox() : const SizedBox(height: Dimensions.paddingSizeDefault),
                            // OrganicTag(item: item!, fromDetails: true),
                            // Container(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: Dimensions.paddingSizeSmall,
                            //       vertical: Dimensions.paddingSizeExtraSmall),
                            //   decoration: BoxDecoration(
                            //     color: inStock ? Colors.red : Colors.green,
                            //     borderRadius: BorderRadius.circular(
                            //         Dimensions.radiusSmall),
                            //   ),
                            //   child: Text(
                            //       inStock ? 'out_of_stock'.tr : 'in_stock'.tr,
                            //       style: robotoRegular.copyWith(
                            //         color: Colors.white,
                            //         fontSize: Dimensions.fontSizeSmall,
                            //       )),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
  }
}
