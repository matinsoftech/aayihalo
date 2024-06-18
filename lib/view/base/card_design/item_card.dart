import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/home_screen_model.dart';
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
import 'package:sixam_mart/view/screens/item/item_details_screen.dart';

class ItemCardCollection extends StatelessWidget {
  final Product item;
  final bool isPopularItem;
  final bool isFood;
  final bool isShop;
  final bool isPopularItemCart;
  const ItemCardCollection({
    super.key,
    required this.item,
    this.isPopularItem = false,
    required this.isFood,
    required this.isShop,
    this.isPopularItemCart = false,
  });

  @override
  Widget build(BuildContext context) {
    double? discount = double.parse(item.discount.toString());
    String? discountType = item.discountType.toString();

    return OnHover(
      isItem: true,
      child: Stack(
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            onTap: () => Get.find<ItemController>().navigateToItemPage(
                Item(
                  id: item.id,
                  name: item.name,
                  image: item.image,
                  description: item.description,
                  avgRating: double.parse(item.avgRating.toString()),
                  ratingCount: item.ratingCount,
                  discount: double.parse((item.discount ?? '0.0').toString()),
                  discountType: item.discountType.toString(),
                  unitType: item.unitType.toString(),
                  storeName: '',
                  stock: item.stock,
                  price: item.price!.toDouble(),
                ),
                context),
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
                    // flex: 6,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            child: CustomImage(
                              placeholder: Images.placeholder,
                              image: '${Get.find<SplashController>().configModel!.baseUrls!.itemImageUrl}'
                                  '/${item.image}',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        AddFavouriteView(
                          item: Item(
                            id: item.id,
                            name: item.name,
                            image: item.image,
                            avgRating: double.parse(item.avgRating.toString()),
                            ratingCount: item.ratingCount,
                            discount: double.parse((item.discount ?? '0.0').toString()),
                            discountType: item.discountType.toString(),
                            unitType: item.unitType.toString(),
                            storeName: '',
                            stock: item.stock,
                            price: item.price!.toDouble(),
                          ),
                        ),
                        DiscountTag(
                          discount: discount,
                          discountType: discountType,
                          freeDelivery: false,
                        ),
                        OrganicTag(
                            item: Item(
                              id: item.id,
                              name: item.name,
                              image: item.image,
                              avgRating: double.parse(item.avgRating.toString()),
                              ratingCount: item.ratingCount,
                              discount: double.parse((item.discount ?? '0.0').toString()),
                              discountType: item.discountType.toString(),
                              unitType: item.unitType.toString(),
                              storeName: '',
                              stock: item.stock,
                              price: item.price!.toDouble(),
                            ),
                            placeInImage: false),
                        (item.stock != null && item.stock! < 0)
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
                        Get.find<ItemController>().isAvailable(
                          Item(
                            id: item.id,
                            name: item.name,
                            image: item.image,
                            avgRating: double.parse(item.avgRating.toString()),
                            ratingCount: item.ratingCount,
                            discount: double.parse((item.discount ?? '0.0').toString()),
                            discountType: item.discountType.toString(),
                            unitType: item.unitType.toString(),
                            storeName: '',
                            stock: item.stock,
                            price: item.price!.toDouble(),
                          ),
                        )
                            ? const SizedBox()
                            : NotAvailableWidget(radius: Dimensions.radiusLarge, isAllSideRound: isPopularItem),
                      ],
                    ),
                  ),
                  Expanded(
                    // flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: isShop ? 0 : Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall, bottom: isShop ? 0 : Dimensions.paddingSizeSmall),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            // (isFood || isShop)
                            //     ? Text(item.storeName ?? '',
                            //         style: robotoRegular.copyWith(
                            //             color: Theme.of(context).disabledColor))
                            //     :
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    item.name!,
                                    style: robotoBold.copyWith(fontSize: 12),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),

                            (isFood || isShop)
                                ? Flexible(
                                    child: Text(
                                      item.name!.length > 10 ? '${item.name!.substring(0, 10)}..' : item.name ?? '',
                                      style: robotoBold,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : Row(mainAxisAlignment: isPopularItem ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
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
                                ? Row(mainAxisAlignment: isPopularItem ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
                                    Icon(Icons.star, size: 14, color: Theme.of(context).primaryColor),
                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                    Text(item.avgRating!.toStringAsFixed(1), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                    Text("(${item.ratingCount})", style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
                                  ])
                                : (Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && item.unitType != null)
                                    ? Row(
                                        children: [
                                          Text(
                                            '${item.unitValue ?? ''}',
                                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            item.unitType ?? '',
                                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),

                            item.discount != null && item.discount! > 0
                                ? Text(
                                    PriceConverter.convertPrice(
                                      Get.find<ItemController>().getStartingPrice(
                                        Item(
                                          id: item.id,
                                          name: item.name,
                                          image: item.image,
                                          avgRating: double.parse(item.avgRating.toString()),
                                          ratingCount: item.ratingCount,
                                          discount: double.parse((item.discount ?? '0.0').toString()),
                                          discountType: item.discountType.toString(),
                                          unitType: item.unitType.toString(),
                                          storeName: '',
                                          stock: item.stock,
                                          price: item.price!.toDouble(),
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  PriceConverter.convertPrice(
                                    Get.find<ItemController>().getStartingPrice(Item(
                                      id: item.id,
                                      name: item.name,
                                      image: item.image,
                                      avgRating: double.parse(item.avgRating.toString()),
                                      ratingCount: item.ratingCount,
                                      discount: double.parse((item.discount ?? '0.0').toString()),
                                      discountType: item.discountType.toString(),
                                      unitType: item.unitType.toString(),
                                      storeName: '',
                                      stock: item.stock,
                                      price: item.price!.toDouble(),
                                    )),
                                    discount: double.parse((item.discount ?? '0.0').toString()),
                                    discountType: item.discountType.toString(),
                                  ),
                                  textDirection: TextDirection.ltr,
                                  style: robotoMedium,
                                ),
                                // delivery in

                                CartCountView(
                                  fromItemDetail: false,
                                  item: Item(
                                    id: item.id,
                                    name: item.name,
                                    image: item.image,
                                    avgRating: double.parse(item.avgRating.toString()),
                                    ratingCount: item.ratingCount,
                                    discount: double.parse((item.discount ?? '0.0').toString()),
                                    discountType: item.discountType.toString(),
                                    unitType: item.unitType.toString(),
                                    storeName: '',
                                    stock: item.stock,
                                    price: item.price!.toDouble(),
                                  ),
                                )
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Item item;
  final bool isPopularItem;
  final bool isFood;
  final bool isShop;
  final bool isPopularItemCart;
  const ItemCard({
    super.key,
    required this.item,
    this.isPopularItem = false,
    required this.isFood,
    required this.isShop,
    this.isPopularItemCart = false,
  });

  @override
  Widget build(BuildContext context) {
    double? discount = double.parse(item.discount.toString());
    String? discountType = item.discountType.toString();

    return OnHover(
      isItem: true,
      child: Stack(
        children: [
          InkWell(
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
              // price: item.price!.toDouble(),
              //   categoryProducts: item.categoryProducts,
              // );

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ItemDetailsScreen(
                    item: item,
                    inStorePage: false,
                  ),
                ),
              );
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
                    flex: 5,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            child: CustomImage(
                              placeholder: Images.placeholder,
                              image: '${Get.find<SplashController>().configModel!.baseUrls!.itemImageUrl}'
                                  '/${item.image}',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        AddFavouriteView(
                          item: Item(
                            id: item.id,
                            name: item.name,
                            image: item.image,
                            avgRating: double.parse(item.avgRating.toString()),
                            ratingCount: item.ratingCount,
                            discount: double.parse((item.discount ?? '0.0').toString()),
                            discountType: item.discountType.toString(),
                            unitType: item.unitType.toString(),
                            storeName: '',
                            stock: item.stock,
                            price: item.price,
                          ),
                        ),
                        DiscountTag(
                          discount: discount,
                          discountType: discountType,
                          freeDelivery: false,
                        ),
                        OrganicTag(
                          item: Item(
                            id: item.id,
                            name: item.name,
                            image: item.image,
                            avgRating: double.parse(item.avgRating.toString()),
                            ratingCount: item.ratingCount,
                            discount: double.parse((item.discount ?? '0.0').toString()),
                            discountType: item.discountType.toString(),
                            unitType: item.unitType.toString(),
                            storeName: '',
                            stock: item.stock,
                            price: item.price,
                          ),
                          placeInImage: false,
                        ),
                        //tag of stock available
                        (item.stock != null && item.stock! < 0)
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

                        Get.find<ItemController>().isAvailable(
                          Item(
                            id: item.id,
                            name: item.name,
                            image: item.image,
                            avgRating: double.parse(item.avgRating.toString()),
                            ratingCount: item.ratingCount,
                            discount: double.parse((item.discount ?? '0.0').toString()),
                            discountType: item.discountType.toString(),
                            unitType: item.unitType.toString(),
                            storeName: '',
                            stock: item.stock,
                            price: item.price,
                          ),
                        )
                            ? const SizedBox()
                            : NotAvailableWidget(radius: Dimensions.radiusLarge, isAllSideRound: isPopularItem),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: isShop ? 0 : Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall, bottom: isShop ? 0 : Dimensions.paddingSizeSmall),
                      child: Stack(clipBehavior: Clip.none, children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          (isFood || isShop)
                              ? Text(item.storeName ?? '', style: robotoRegular.copyWith(color: Theme.of(context).disabledColor))
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        item.name!,
                                        style: robotoBold.copyWith(fontSize: 12),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),

                          (isFood || isShop)
                              ? Flexible(
                                  child: Text(
                                    item.name!.length > 10 ? '${item.name!.substring(0, 10)}..' : item.name ?? '',
                                    style: robotoBold,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: isPopularItem ? MainAxisAlignment.center : MainAxisAlignment.start,
                                  children: const [
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
                                  ],
                                ),

                          (isFood || isShop)
                              ? Row(
                                  mainAxisAlignment: isPopularItem ? MainAxisAlignment.center : MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.star, size: 14, color: Theme.of(context).primaryColor),
                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                    Text(item.avgRating!.toStringAsFixed(1), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                    Text("(${item.ratingCount})", style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
                                  ],
                                )
                              : (Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && item.unitType != null)
                                  ? Row(
                                      children: [
                                        Text(
                                          '${item.unitValue}',
                                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor),
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          item.unitType ?? '',
                                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),

                          item.discount != null && item.discount! > 0
                              ? Text(
                                  PriceConverter.convertPrice(
                                    Get.find<ItemController>().getStartingPrice(
                                      Item(
                                        id: item.id,
                                        name: item.name,
                                        image: item.image,
                                        avgRating: double.parse(item.avgRating.toString()),
                                        ratingCount: item.ratingCount,
                                        discount: double.parse((item.discount ?? '0.0').toString()),
                                        discountType: item.discountType.toString(),
                                        unitType: item.unitType.toString(),
                                        storeName: '',
                                        stock: item.stock,
                                        price: item.price,
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                PriceConverter.convertPrice(
                                  Get.find<ItemController>().getStartingPrice(
                                    Item(
                                      id: item.id,
                                      name: item.name,
                                      image: item.image,
                                      avgRating: double.parse(item.avgRating.toString()),
                                      ratingCount: item.ratingCount,
                                      discount: double.parse((item.discount ?? '0.0').toString()),
                                      discountType: item.discountType.toString(),
                                      unitType: item.unitType.toString(),
                                      storeName: '',
                                      stock: item.stock,
                                      price: item.price,
                                    ),
                                  ),
                                  discount: double.parse((item.discount ?? '0.0').toString()),
                                  discountType: item.discountType.toString(),
                                ),
                                textDirection: TextDirection.ltr,
                                style: robotoMedium,
                              ),
                              // delivery in
                              CartCountView(
                                item: Item(
                                    id: item.id,
                                    name: item.name,
                                    image: item.image,
                                    variations: item.variations,
                                    images: item.images,
                                    avgRating: double.parse(item.avgRating.toString()),
                                    ratingCount: item.ratingCount,
                                    discount: double.parse((item.discount ?? '0.0').toString()),
                                    discountType: item.discountType.toString(),
                                    unitType: item.unitType.toString(),
                                    description: item.description.toString(),
                                    storeName: '',
                                    stock: item.stock,
                                    price: item.price,
                                    categoryProducts: item.categoryProducts),
                              ),
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
        ],
      ),
    );
  }
}
