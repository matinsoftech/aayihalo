import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/add_favourite_view.dart';
import 'package:sixam_mart/view/base/cart_count_view.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/discount_tag.dart';
import 'package:sixam_mart/view/base/hover/on_hover.dart';
import 'package:sixam_mart/view/base/not_available_widget.dart';
import 'package:sixam_mart/view/base/organic_tag.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final bool isPopularItem;
  final bool isFood;
  final bool isShop;
  final bool isPopularItemCart;
  const ItemCard(
      {Key? key,
      required this.item,
      this.isPopularItem = false,
      required this.isFood,
      required this.isShop,
      this.isPopularItemCart = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? discount =
        item.storeDiscount == 0 ? item.discount : item.storeDiscount;
    String? discountType =
        item.storeDiscount == 0 ? item.discountType : 'percent';

    return OnHover(
      isItem: true,
      child: Stack(children: [
        InkWell(
          hoverColor: Colors.transparent,
          onTap: () =>
              Get.find<ItemController>().navigateToItemPage(item, context),
          child: Container(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
              color: Theme.of(context).cardColor,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 9,
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: isPopularItem
                            ? Dimensions.paddingSizeExtraSmall
                            : 0,
                        left: isPopularItem
                            ? Dimensions.paddingSizeExtraSmall
                            : 0,
                        right: isPopularItem
                            ? Dimensions.paddingSizeExtraSmall
                            : 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(Dimensions.radiusLarge),
                        topRight: const Radius.circular(Dimensions.radiusLarge),
                        bottomLeft: Radius.circular(
                            isPopularItem ? Dimensions.radiusLarge : 0),
                        bottomRight: Radius.circular(
                            isPopularItem ? Dimensions.radiusLarge : 0),
                      ),
                      child: CustomImage(
                        placeholder: Images.placeholder,
                        image:
                            '${Get.find<SplashController>().configModel!.baseUrls!.itemImageUrl}'
                            '/${item.image}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  AddFavouriteView(
                    item: item,
                  ),
                  DiscountTag(
                    discount: discount,
                    discountType: discountType,
                    freeDelivery: false,
                  ),
                  OrganicTag(item: item, placeInImage: false),
                  (item.stock != null && item.stock! < 0)
                      ? Positioned(
                          bottom: 10,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall,
                                vertical: Dimensions.paddingSizeExtraSmall),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                topRight:
                                    Radius.circular(Dimensions.radiusLarge),
                                bottomRight:
                                    Radius.circular(Dimensions.radiusLarge),
                              ),
                            ),
                            child: Text('out_of_stock'.tr,
                                style: robotoRegular.copyWith(
                                  color: Theme.of(context).cardColor,
                                  fontSize: Dimensions.fontSizeSmall,
                                )),
                          ),
                        )
                      : const SizedBox(),
                  Get.find<ItemController>().isAvailable(item)
                      ? const SizedBox()
                      : NotAvailableWidget(
                          radius: Dimensions.radiusLarge,
                          isAllSideRound: isPopularItem),
                ]),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.paddingSizeSmall,
                      right: isShop ? 0 : Dimensions.paddingSizeSmall,
                      top: Dimensions.paddingSizeSmall,
                      bottom: isShop ? 0 : Dimensions.paddingSizeSmall),
                  child: Stack(clipBehavior: Clip.none, children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (isFood || isShop)
                              ? Text(item.storeName ?? '',
                                  style: robotoRegular.copyWith(
                                      color: Theme.of(context).disabledColor))
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                          item.name!.length > 8
                                              ? '${item.name!.substring(0, 8)}..'
                                              : item.name ?? '',
                                          style: robotoBold,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    CartCountView(
                                      item: item,
                                    ),
                                  ],
                                ),

                          (isFood || isShop)
                              ? Flexible(
                                  child: Text(
                                    item.name!.length > 10
                                        ? '${item.name!.substring(0, 10)}..'
                                        : item.name ?? '',
                                    style: robotoBold,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: isPopularItem
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                                  children: [
                                      // Icon(Icons.star,
                                      //     size: 14,
                                      //     color:
                                      //         Theme.of(context).primaryColor),

                                      // const SizedBox(
                                      //     width:
                                      //         Dimensions.paddingSizeExtraSmall),
                                      // Text(
                                      //     (item.description ?? ' ').substring(
                                      //         0,
                                      //         (item.description ?? '').length <
                                      //                 20
                                      //             ? (item.description ?? '')
                                      //                 .length
                                      //             : 20),
                                      //     style: robotoRegular.copyWith(
                                      //         fontSize:
                                      //             Dimensions.fontSizeSmall)),
                                      // const SizedBox(
                                      //     width:
                                      //         Dimensions.paddingSizeExtraSmall),
                                      // Text("(${item.ratingCount})",
                                      //     style: robotoRegular.copyWith(
                                      //         fontSize:
                                      //             Dimensions.fontSizeSmall,
                                      //         color: Theme.of(context)
                                      //             .disabledColor)),
                                    ]),

                          (isFood || isShop)
                              ? Row(
                                  mainAxisAlignment: isPopularItem
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                                  children: [
                                      Icon(Icons.star,
                                          size: 14,
                                          color:
                                              Theme.of(context).primaryColor),
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      Text(item.avgRating!.toStringAsFixed(1),
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall)),
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      Text("(${item.ratingCount})",
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              color: Theme.of(context)
                                                  .disabledColor)),
                                    ])
                              : (Get.find<SplashController>()
                                          .configModel!
                                          .moduleConfig!
                                          .module!
                                          .unit! &&
                                      item.unitType != null)
                                  ? Text(
                                      '(${item.unitType ?? ''})',
                                      style: robotoRegular.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeExtraSmall,
                                          color: Theme.of(context).hintColor),
                                    )
                                  : const SizedBox(),

                          item.discount != null && item.discount! > 0
                              ? Text(
                                  PriceConverter.convertPrice(
                                      Get.find<ItemController>()
                                          .getStartingPrice(item)),
                                  style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeExtraSmall,
                                    color: Theme.of(context).disabledColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  textDirection: TextDirection.ltr,
                                )
                              : const SizedBox(),
                          // SizedBox(height: item.discount != null && item.discount! > 0 ? Dimensions.paddingSizeExtraSmall : 0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                PriceConverter.convertPrice(
                                  Get.find<ItemController>()
                                      .getStartingPrice(item),
                                  discount: item.discount,
                                  discountType: item.discountType,
                                ),
                                textDirection: TextDirection.ltr,
                                style: robotoMedium,
                              ),
                              // delivery in
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer,
                                      size: 14,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 2),
                                  const Text(
                                    "10m",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                        ]),
                    // isShop
                    //     ? Positioned(
                    //         bottom: 0,
                    //         right: 0,
                    //         child:

                    //          CartCountView(
                    //           item: item,
                    //           child: Container(
                    //             height: 35,
                    //             width: 38,
                    //             decoration: BoxDecoration(
                    //               color: Theme.of(context).primaryColor,
                    //               borderRadius: const BorderRadius.only(
                    //                 topLeft:
                    //                     Radius.circular(Dimensions.radiusLarge),
                    //                 bottomRight:
                    //                     Radius.circular(Dimensions.radiusLarge),
                    //               ),
                    //             ),
                    //             child: Icon(
                    //                 isPopularItemCart
                    //                     ? Icons.add_shopping_cart
                    //                     : Icons.add,
                    //                 color: Theme.of(context).cardColor,
                    //                 size: 20),
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox(),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
