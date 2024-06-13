import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/wishlist_controller.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/add_favourite_view.dart';
import 'package:sixam_mart/view/base/card_design/item_card.dart';
import 'package:sixam_mart/view/base/cart_count_view.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/discount_tag.dart';
import 'package:sixam_mart/view/base/title_widget.dart';

class ProductsInThisCategory extends StatelessWidget {
  final bool isFood;
  final bool isShop;
  final bool isPopularItem;
  final List categoryDetails;
  const ProductsInThisCategory({
    Key? key,
    required this.isFood,
    required this.isShop,
    this.isPopularItem = false,
    required this.categoryDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemController>(builder: (itemController) {
      // List<Item>? discountedItemList = itemController.discountedItemList;

      return categoryDetails.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall, right: Dimensions.paddingSizeDefault),
                    child: TitleWidget(
                      title: 'Similar Product',
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    width: Get.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                      itemCount: categoryDetails.length,
                      itemBuilder: (context, index) {
                        var product = categoryDetails[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () {
                              // Item itemD = Item(
                              //   id: item.id,
                              //   name: item.name,
                              //   image: item.image,
                              //   avgRating: double.parse(item.avgRating.toString()),
                              //   ratingCount: item.ratingCount,
                              //   discount: double.parse((item.discount ?? '0.0').toString()),
                              //   discountType: item.discountType.toString(),
                              //   unitType: item.unitType.toString(),
                              //   storeName: '',
                              //   stock: item.stock,
                              //   price: item.price,
                              //   categoryProducts: item.categoryProducts,
                              // );

                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (_) => ItemDetailsScreen(
                              //       item: item,
                              //       inStorePage: false,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                    width: 0.5,
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Stack(
                                      children: [
                                        //image section
                                        Padding(
                                          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                            child: CustomImage(
                                              placeholder: Images.placeholder,
                                              image: '${Get.find<SplashController>().configModel!.baseUrls!.itemImageUrl}'
                                                  '/${product.image}',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          ),
                                        ),
                                        //add to favorites view
                                        Positioned(
                                          top: 15,
                                          right: 15,
                                          child: GetBuilder<WishListController>(builder: (wishController) {
                                            bool isWished = wishController.wishItemIdList.contains(product.id);
                                            return InkWell(
                                              onTap: () {
                                                if (Get.find<AuthController>().isLoggedIn()) {
                                                  isWished ? wishController.removeFromWishList(product.id, false) : wishController.newAddToWishList(product.id);
                                                } else {
                                                  showCustomSnackBar('you_are_not_logged_in'.tr);
                                                }
                                              },
                                              child: Icon(isWished ? Icons.favorite : Icons.favorite_border, color: Theme.of(context).primaryColor, size: 20),
                                            );
                                          }),
                                        ),
                                        // tag for discount here
                                        DiscountTag(
                                          discount: double.parse(product.discount.toString()),
                                          discountType: product.discountType.toString(),
                                          freeDelivery: false,
                                        ),
                                        //tag for organic products
                                        // OrganicTag(
                                        //     item: Item(
                                        //       id: item.id,
                                        //       name: item.name,
                                        //       image: item.image,
                                        //       avgRating: double.parse(item.avgRating.toString()),
                                        //       ratingCount: item.ratingCount,
                                        //       discount: double.parse((item.discount ?? '0.0').toString()),
                                        //       discountType: item.discountType.toString(),
                                        //       unitType: item.unitType.toString(),
                                        //       storeName: '',
                                        //       stock: item.stock,
                                        //       price: item.price,
                                        //     ),
                                        //     placeInImage: false,),
                                        // tag of out of stock items
                                        (product.stock != null && product.stock! < 0)
                                            ? Positioned(
                                                bottom: 10,
                                                left: 0,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                                                    borderRadius: const BorderRadius.only(
                                                      topRight: Radius.circular(Dimensions.radiusLarge),
                                                      bottomRight: Radius.circular(Dimensions.radiusLarge),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'out_of_stock'.tr,
                                                    style: robotoRegular.copyWith(
                                                      color: Theme.of(context).cardColor,
                                                      fontSize: Dimensions.fontSizeSmall,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),

                                        // Get.find<ItemController>().isAvailable(Item(
                                        //   id: item.id,
                                        //   name: item.name,
                                        //   image: item.image,
                                        //   avgRating: double.parse(item.avgRating.toString()),
                                        //   ratingCount: item.ratingCount,
                                        //   discount: double.parse((item.discount ?? '0.0').toString()),
                                        //   discountType: item.discountType.toString(),
                                        //   unitType: item.unitType.toString(),
                                        //   storeName: '',
                                        //   stock: item.stock,
                                        //   price: item.price,
                                        // ))
                                        //     ? const SizedBox()
                                        //     : NotAvailableWidget(radius: Dimensions.radiusLarge, isAllSideRound: isPopularItem),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: isShop ? 0 : Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall, bottom: isShop ? 0 : Dimensions.paddingSizeSmall),
                                      child: Stack(clipBehavior: Clip.none, children: [
                                        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          // (isFood || isShop)
                                          //     ? Text(
                                          //         product.storeName ?? '',
                                          //         style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
                                          //       )
                                          //     :
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  product.name!,
                                                  style: robotoBold.copyWith(fontSize: 12),
                                                  overflow: TextOverflow.visible,
                                                ),
                                              ),
                                            ],
                                          ),

                                          (isFood || isShop)
                                              ? Flexible(
                                                  child: Text(
                                                    product.name!.length > 10 ? '${product.name!.substring(0, 10)}..' : product.name ?? '',
                                                    style: robotoBold,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisAlignment: isPopularItem ? MainAxisAlignment.center : MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.star, size: 14, color: Theme.of(context).primaryColor),
                                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                                    // Text(
                                                    //   (product.description ?? ' ').substring(
                                                    //     0,
                                                    //     (product.description ?? '').length < 20 ? (product.description ?? '').length : 20,
                                                    //   ),
                                                    //   style: robotoRegular.copyWith(
                                                    //     fontSize: Dimensions.fontSizeSmall,
                                                    //   ),
                                                    // ),
                                                    // const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                                    Text(
                                                      "(${product.ratingCount})",
                                                      style: robotoRegular.copyWith(
                                                        fontSize: Dimensions.fontSizeSmall,
                                                        color: Theme.of(context).disabledColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                          (isFood || isShop)
                                              ? Row(
                                                  mainAxisAlignment: isPopularItem ? MainAxisAlignment.center : MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.star, size: 14, color: Theme.of(context).primaryColor),
                                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                                    Text(
                                                      product.avgRating!.toStringAsFixed(1),
                                                      style: robotoRegular.copyWith(
                                                        fontSize: Dimensions.fontSizeSmall,
                                                      ),
                                                    ),
                                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                                    Text(
                                                      "(${product.ratingCount})",
                                                      style: robotoRegular.copyWith(
                                                        fontSize: Dimensions.fontSizeSmall,
                                                        color: Theme.of(context).disabledColor,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : (Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && product.unitType != null)
                                                  ? Text(
                                                      '(${product.unitType ?? ''})',
                                                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor),
                                                    )
                                                  : const SizedBox(),

                                          product.discount != null && product.discount! > 0
                                              ? Text(
                                                  PriceConverter.convertPrice(
                                                    Get.find<ItemController>().getStartingPrice(
                                                      Item(
                                                        id: product.id,
                                                        name: product.name,
                                                        image: product.image,
                                                        avgRating: double.parse(product.avgRating.toString()),
                                                        ratingCount: product.ratingCount,
                                                        discount: double.parse((product.discount ?? '0.0').toString()),
                                                        discountType: product.discountType.toString(),
                                                        unitType: product.unitType.toString(),
                                                        storeName: '',
                                                        stock: product.stock,
                                                        price: product.price,
                                                      ),
                                                    ),
                                                  ),
                                                  style: robotoMedium.copyWith(
                                                    fontSize: Dimensions.fontSizeExtraSmall,
                                                    color: Theme.of(context).disabledColor,
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                  textDirection: TextDirection.ltr,
                                                )
                                              : const SizedBox(),

                                          // SizedBox(height: item.discount != null && item.discount! > 0 ? Dimensions.paddingSizeExtraSmall : 0),
                                          //?
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                PriceConverter.convertPrice(
                                                  Get.find<ItemController>().getStartingPrice(Item(
                                                    id: product.id,
                                                    name: product.name,
                                                    image: product.image,
                                                    avgRating: double.parse(product.avgRating.toString()),
                                                    ratingCount: product.ratingCount,
                                                    discount: double.parse((product.discount ?? '0.0').toString()),
                                                    discountType: product.discountType.toString(),
                                                    unitType: product.unitType.toString(),
                                                    storeName: '',
                                                    stock: product.stock,
                                                    price: product.price,
                                                  )),
                                                  discount: double.parse((product.discount ?? '0.0').toString()),
                                                  discountType: product.discountType.toString(),
                                                ),
                                                textDirection: TextDirection.ltr,
                                                style: robotoMedium,
                                              ),
                                              //?
                                              // delivery in

                                              // CartCountView(
                                              //   item: Item(
                                              //     id: item.id,
                                              //     name: item.name,
                                              //     image: item.image,
                                              //     variations: item.variations,
                                              //     images: item.images,
                                              //     avgRating: double.parse(item.avgRating.toString()),
                                              //     ratingCount: item.ratingCount,
                                              //     discount: double.parse((item.discount ?? '0.0').toString()),
                                              //     discountType: item.discountType.toString(),
                                              //     unitType: item.unitType.toString(),
                                              //     storeName: '',
                                              //     stock: item.stock,
                                              //     price: item.price,
                                              //   ),
                                              // )
                                            ],
                                          ),

                                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
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
                                ],
                              ),
                            ),
                          ),

                          //  ItemCard(
                          //   item: categoryDetails[index],
                          //   isPopularItem: false,
                          //   isFood: isFood,
                          //   isShop: isShop,
                          // ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox();
      // : const ItemShimmerView(isPopularItem: false);
    });
  }
}

class ItemShimmerView extends StatelessWidget {
  final bool isPopularItem;
  const ItemShimmerView({Key? key, required this.isPopularItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: Container(
        color: Theme.of(context).disabledColor.withOpacity(0.1),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
            child: TitleWidget(
              title: isPopularItem ? 'most_popular_items'.tr : 'special_offer'.tr,
              image: isPopularItem ? Images.mostPopularIcon : Images.discountOfferIcon,
            ),
          ),
          SizedBox(
            height: 285,
            width: Get.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                  child: Shimmer(
                    duration: const Duration(seconds: 2),
                    enabled: true,
                    child: Container(
                      height: 285,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                      ),
                      child: Column(children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: Column(children: [
                            Container(
                              height: 20,
                              width: 100,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                              height: 20,
                              width: 200,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                              height: 20,
                              width: 100,
                              color: Colors.grey[300],
                            ),
                          ]),
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
