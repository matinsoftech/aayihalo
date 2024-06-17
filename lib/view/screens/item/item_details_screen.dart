import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/body/place_order_body.dart';
import 'package:sixam_mart/data/model/response/cart_data_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/cart_count_view.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/screens/dashboard/widget/cart_detail_floating_button.dart';
import 'package:sixam_mart/view/screens/home/widget/grocery/brands_in_this_category.dart';
import 'package:sixam_mart/view/screens/home/widget/grocery/products_in_this_category.dart';
import 'package:sixam_mart/view/screens/item/widget/details_app_bar.dart';
import 'package:sixam_mart/view/screens/item/widget/item_image_view.dart';
import 'package:sixam_mart/view/screens/item/widget/item_title_view.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Item? item;
  final bool inStorePage;
  const ItemDetailsScreen({
    key,
    required this.item,
    required this.inStorePage,
  }) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final Size size = Get.size;
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  final GlobalKey<DetailsAppBarState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    Get.find<ItemController>().getProductDetails(widget.item!);
  }

  @override
  Widget build(BuildContext context) {
    // print('category product length : ${widget.item?.categoryProducts?.length}');
    return GetBuilder<CartController>(
      builder: (cartController) {
        return GetBuilder<ItemController>(
          builder: (itemController) {
            int? stock = 0;
            // CartDataModel? cartModel;
            // OnlineCart? cart;
            // double priceWithAddons = 0;
            // int? cartId = cartController.getCartId(itemController.cartIndex);
            // if (itemController.item != null &&
            //     itemController.variationIndex != null) {
            //   List<String> variationList = [];
            //   for (int index = 0;
            //       index < itemController.item!.choiceOptions!.length;
            //       index++) {
            //     variationList.add(itemController.item!.choiceOptions![index]
            //         .options![itemController.variationIndex![index]]
            //         .replaceAll(' ', ''));
            //   }
            //   String variationType = '';
            //   bool isFirst = true;
            //   for (var variation in variationList) {
            //     if (isFirst) {
            //       variationType = '$variationType$variation';
            //       isFirst = false;
            //     } else {
            //       variationType = '$variationType-$variation';
            //     }
            //   }

            //   double? price = itemController.item!.price;
            //   Variation? variation;
            //   stock = itemController.item!.stock ?? 0;
            //   for (Variation v in itemController.item!.variations!) {
            //     if (v.type == variationType) {
            //       price = v.price;
            //       variation = v;
            //       stock = v.stock;
            //       break;
            //     }
            //   }

            //   double? discount =
            //       (itemController.item!.availableDateStarts != null ||
            //               itemController.item!.storeDiscount == 0)
            //           ? itemController.item!.discount
            //           : itemController.item!.storeDiscount;
            //   String? discountType =
            //       (itemController.item!.availableDateStarts != null ||
            //               itemController.item!.storeDiscount == 0)
            //           ? itemController.item!.discountType
            //           : 'percent';
            //   double priceWithDiscount = PriceConverter.convertWithDiscount(
            //       price, discount, discountType)!;
            //   double priceWithQuantity =
            //       priceWithDiscount * itemController.quantity!;
            //   double addonsCost = 0;
            //   List<AddOn> addOnIdList = [];
            //   List<AddOns> addOnsList = [];
            //   for (int index = 0;
            //       index < itemController.item!.addOns!.length;
            //       index++) {
            //     if (itemController.addOnActiveList[index]) {
            //       addonsCost = addonsCost +
            //           (itemController.item!.addOns![index].price! *
            //               itemController.addOnQtyList[index]!);
            //       addOnIdList.add(AddOn(
            //           id: itemController.item!.addOns![index].id,
            //           quantity: itemController.addOnQtyList[index]));
            //       addOnsList.add(itemController.item!.addOns![index]);
            //     }
            //   }

            //   cartModel = CartModel(
            //     null,
            //     price,
            //     priceWithDiscount,
            //     variation != null ? [variation] : [],
            //     [],
            //     (price! -
            //         PriceConverter.convertWithDiscount(
            //             price, discount, discountType)!),
            //     itemController.quantity,
            //     addOnIdList,
            //     addOnsList,
            //     itemController.item!.availableDateStarts != null,
            //     stock,
            //     itemController.item,
            //     itemController.item!.quantityLimit,
            //   );

            //   List<int?> listOfAddOnId =
            //       CartHelper.getSelectedAddonIds(addOnIdList: addOnIdList);
            //   List<int?> listOfAddOnQty =
            //       CartHelper.getSelectedAddonQtnList(addOnIdList: addOnIdList);

            //   cart = OnlineCart(
            //       cartId,
            //       widget.item!.id,
            //       null,
            //       priceWithDiscount.toString(),
            //       '',
            //       variation != null ? [variation] : [],
            //       null,
            //       itemController.cartIndex != -1
            //           ? cartController.cartList[itemController.cartIndex].quantity
            //           : itemController.quantity,
            //       listOfAddOnId,
            //       addOnsList,
            //       listOfAddOnQty,
            //       'Item');
            //   priceWithAddons = priceWithQuantity +
            //       (Get.find<SplashController>()
            //               .configModel!
            //               .moduleConfig!
            //               .module!
            //               .addOn!
            //           ? addonsCost
            //           : 0);
            // }

            return Scaffold(
              key: _globalKey,
              backgroundColor: Theme.of(context).cardColor,
              endDrawer: const MenuDrawer(),
              endDrawerEnableOpenDragGesture: false,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomSheet: cartController.cartList.isEmpty ? const SizedBox() : const CartDetailFloatingButton(),
              appBar: ResponsiveHelper.isDesktop(context)
                  ? const CustomAppBar(title: '')
                  : DetailsAppBar(
                      key: _key,
                      item: itemController.item!,
                    ),
              body: SafeArea(
                  child:

                      //  (itemController.item != null)
                      //     ? ResponsiveHelper.isDesktop(context)
                      //         ? DetailsWebView(
                      //             cartModel: cartModel,
                      //             stock: stock,
                      //             priceWithAddOns: priceWithAddons,
                      //             cart: cart,
                      //           )
                      //         :

                      Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        physics: const BouncingScrollPhysics(),
                        child: Center(
                          child: SizedBox(
                              width: Dimensions.webMaxWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ItemImageView(item: itemController.item),
                                  const SizedBox(height: 20),

                                  Builder(
                                    builder: (context) {
                                      return ItemTitleView(
                                        item: widget.item,
                                        inStorePage: widget.inStorePage,
                                        isCampaign: itemController.item!.availableDateStarts != null,
                                        inStock: (Get.find<SplashController>().configModel!.moduleConfig!.module!.stock! && stock <= 0),
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  /// Brand
                                  // Container(
                                  //   height: 56,
                                  //   width: double.infinity,
                                  //   decoration: BoxDecoration(
                                  //     border: Border.symmetric(
                                  //       horizontal: BorderSide(
                                  //         color:
                                  //             Colors.grey.shade300,
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   child: Row(
                                  //     children: [
                                  //       Container(
                                  //         height: 40,
                                  //         width: 40,
                                  //         decoration: BoxDecoration(
                                  //           color:
                                  //               Colors.green[100],
                                  //           borderRadius:
                                  //               BorderRadius
                                  //                   .circular(8),
                                  //         ),

                                  //         // child:

                                  //         //  CachedNetworkImage(
                                  //         //   imageUrl: Get.find<SplashController>()
                                  //         //       .configModel!
                                  //         //       .baseUrls +
                                  //         //       itemController.item!.store!.image!,
                                  //         //   height: 40,
                                  //         //   width: 40,
                                  //         //   fit: BoxFit.cover,
                                  //         // ),
                                  //       ),
                                  //       const SizedBox(
                                  //         width: 8,
                                  //       ),
                                  //       Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment
                                  //                 .start,
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment
                                  //                 .center,
                                  //         children: [
                                  //           Text(
                                  //             itemController
                                  //                 .item!.storeName!,
                                  //             style: robotoMedium
                                  //                 .copyWith(
                                  //                     fontSize:
                                  //                         Dimensions
                                  //                             .fontSizeLarge),
                                  //           ),
                                  //           const SizedBox(
                                  //               height: 4),
                                  //           Text(
                                  //             "View All Products",
                                  //             style: robotoRegular.copyWith(
                                  //                 color: const Color(
                                  //                     0xFF01684b),
                                  //                 fontSize: Dimensions
                                  //                     .fontSizeSmall),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       const Spacer(),
                                  //       IconButton(
                                  //           onPressed: () {},
                                  //           icon: const Icon(
                                  //             Icons
                                  //                 .arrow_forward_rounded,
                                  //           ))
                                  //     ],
                                  //   ),
                                  // ),

                                  // Variation

                                  widget.item?.variations == null || widget.item!.variations!.isEmpty
                                      ? Text(
                                          "Nrs. ${widget.item!.price!}",
                                          style: robotoMedium.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                        )
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Variations',
                                              style: robotoBold.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 8),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                  children: List.generate(
                                                widget.item!.variations!.length,
                                                (index) => Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Container(
                                                    height: 90,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.shade100,
                                                      borderRadius: BorderRadius.circular(
                                                        16,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            widget.item!.variations![index].type!.trim(),
                                                            style: robotoRegular.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            'NRs. ${widget.item!.variations![index].price!}',
                                                            style: robotoRegular.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                                          ),
                                                          const SizedBox(height: 8),
                                                          VariationAddWidget(
                                                            widget: widget,
                                                            cartController: cartController,
                                                            index: index,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                            ),
                                          ],
                                        ),
                                  // widget.item!
                                  //         .choiceOptions!.isNotEmpty
                                  //     ? const SizedBox(
                                  //         height: Dimensions
                                  //             .paddingSizeLarge)
                                  //     : const SizedBox(),

                                  // Quantity

                                  // Row(children: [

                                  //   Text('${'total_amount'.tr}:',
                                  //       style: robotoMedium.copyWith(
                                  //           fontSize: Dimensions
                                  //               .fontSizeLarge)),
                                  //   const SizedBox(
                                  //       width: Dimensions
                                  //           .paddingSizeExtraSmall),
                                  //   Text(
                                  //     PriceConverter.convertPrice(
                                  //         itemController
                                  //                     .cartIndex !=
                                  //                 -1
                                  //             ? CartHelper.getItemDetailsDiscountPrice(
                                  //                 cart: Get.find<
                                  //                             CartController>()
                                  //                         .cartList[
                                  //                     itemController
                                  //                         .cartIndex])
                                  //             : priceWithAddons),
                                  //     textDirection:
                                  //         TextDirection.ltr,
                                  //     style: robotoBold.copyWith(
                                  //         color: Theme.of(context)
                                  //             .primaryColor,
                                  //         fontSize: Dimensions
                                  //             .fontSizeLarge),
                                  //   ),
                                  // ]),
                                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                                  (widget.item!.description != null && widget.item!.description!.isNotEmpty)
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('description'.tr, style: robotoMedium),
                                            const SizedBox(
                                              height: Dimensions.paddingSizeExtraSmall,
                                            ),

                                            ReadMoreText(
                                              itemController.item!.description!,
                                              trimMode: TrimMode.Length,
                                              trimLength: 130,
                                              colorClickableText: Colors.green,
                                              trimCollapsedText: '\nView more Detials',
                                              trimExpandedText: '\nView Less Detials',
                                              moreStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.green,
                                              ),
                                            ),

                                            const SizedBox(
                                              height: Dimensions.paddingSizeExtraSmall,
                                            ),

                                            ///
                                            ///
                                            // const SimilarProducts(
                                            //   isFood: false,
                                            //   isShop: false,
                                            // ),
                                            widget.item?.categoryProducts != null && widget.item!.categoryProducts!.isNotEmpty
                                                ? ProductsInThisCategory(
                                                    isFood: false,
                                                    isShop: false,
                                                    categoryDetails: widget.item?.categoryProducts ?? [],
                                                  )
                                                : const SizedBox(),

                                            // const BrandsInThisCategory()
                                          ],
                                        )
                                      : const SizedBox(),

                                  const SizedBox(
                                    height: 120,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                  // GetBuilder<CartController>(
                  //     builder: (cartController) {
                  //   return Container(
                  //     width: 1170,
                  //     padding: const EdgeInsets.all(
                  //         Dimensions.paddingSizeSmall),
                  //     child: CustomButton(
                  //       isLoading: cartController.isLoading,
                  //       buttonText: (Get.find<SplashController>()
                  //                   .configModel!
                  //                   .moduleConfig!
                  //                   .module!
                  //                   .stock! &&
                  //               stock! <= 0)
                  //           ? 'out_of_stock'.tr
                  //           : itemController
                  //                       .item!.availableDateStarts !=
                  //                   null
                  //               ? 'order_now'.tr
                  //               : itemController.cartIndex != -1
                  //                   ? 'update_in_cart'.tr
                  //                   : 'add_to_cart'.tr,
                  //       onPressed: (!Get.find<SplashController>()
                  //                   .configModel!
                  //                   .moduleConfig!
                  //                   .module!
                  //                   .stock! ||
                  //               stock! > 0)
                  //           ? () async {
                  //               if (!Get.find<SplashController>()
                  //                       .configModel!
                  //                       .moduleConfig!
                  //                       .module!
                  //                       .stock! ||
                  //                   stock! > 0) {
                  //                 if (itemController.item!
                  //                         .availableDateStarts !=
                  //                     null) {
                  //                   Get.toNamed(
                  //                       RouteHelper.getCheckoutRoute(
                  //                           'campaign'),
                  //                       arguments: CheckoutScreen(
                  //                         storeId: null,
                  //                         fromCart: false,
                  //                         cartList: [cartModel],
                  //                       ));
                  //                 } else {
                  //                   if (cartController.existAnotherStoreItem(
                  //                       cartModel!.item!.storeId,
                  //                       Get.find<SplashController>()
                  //                                   .module ==
                  //                               null
                  //                           ? Get.find<
                  //                                   SplashController>()
                  //                               .cacheModule!
                  //                               .id
                  //                           : Get.find<
                  //                                   SplashController>()
                  //                               .module!
                  //                               .id)) {
                  //                     Get.dialog(
                  //                         ConfirmationDialog(
                  //                           icon: Images.warning,
                  //                           title:
                  //                               'are_you_sure_to_reset'
                  //                                   .tr,
                  //                           description: Get.find<
                  //                                       SplashController>()
                  //                                   .configModel!
                  //                                   .moduleConfig!
                  //                                   .module!
                  //                                   .showRestaurantText!
                  //                               ? 'if_you_continue'.tr
                  //                               : 'if_you_continue_without_another_store'
                  //                                   .tr,
                  //                           onYesPressed: () {
                  //                             Get.back();
                  //                             cartController
                  //                                 .clearCartOnline()
                  //                                 .then(
                  //                                     (success) async {
                  //                               if (success) {
                  //                                 await cartController
                  //                                     .addToCartOnline(
                  //                                         cart!);
                  //                                 itemController
                  //                                     .setExistInCart(
                  //                                         widget
                  //                                             .item);
                  //                                 showCartSnackBar();
                  //                               }
                  //                             });
                  //                           },
                  //                         ),
                  //                         barrierDismissible: false);
                  //                   } else {
                  //                     if (itemController.cartIndex ==
                  //                         -1) {
                  //                       await cartController
                  //                           .addToCartOnline(cart!)
                  //                           .then((success) {
                  //                         if (success) {
                  //                           itemController
                  //                               .setExistInCart(
                  //                                   widget.item);
                  //                           showCartSnackBar();
                  //                           _key.currentState!
                  //                               .shake();
                  //                         }
                  //                       });
                  //                     } else {
                  //                       await cartController
                  //                           .updateCartOnline(cart!)
                  //                           .then((success) {
                  //                         if (success) {
                  //                           showCartSnackBar();
                  //                           _key.currentState!
                  //                               .shake();
                  //                         }
                  //                       });
                  //                     }
                  //                   }
                  //                 }
                  //               }
                  //             }
                  //           : null,
                  //     ),
                  //   );
                  // }),
                ],
              )
                  // : const Center(child: CircularProgressIndicator()
                  // )

                  ),
            );
          },
        );
      },
    );
  }
}

class VariationAddWidget extends StatelessWidget {
  const VariationAddWidget({
    super.key,
    required this.widget,
    required this.cartController,
    required this.index,
  });

  final ItemDetailsScreen widget;
  final int index;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    final itemIsInCart = cartController.isExistInCart(widget.item!.id!, widget.item!.variations![index].type!, false, index);

    // print("item4 $itemIsInCart");
    return itemIsInCart != -1
        ? SizedBox(width: 80, child: CartCountView(item: widget.item!))
        : InkWell(
            onTap: cartController.isLoading && cartController.variationType == widget.item!.variations![index].type
                ? () {}
                : () {
                    cartController.variationType = widget.item!.variations![index].type ?? '';

                    cartController.addToCart(quantity: 1, productId: widget.item!.id!, variantType: widget.item!.variations![index].type);
                  },
            child: cartController.isLoading && cartController.variationType == widget.item!.variations![index].type
                ? const Text(
                    "LOADING...",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text(
                    "ADD",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          );
  }
}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int? quantity;
  final bool isCartWidget;
  final int? stock;
  final bool isExistInCart;
  final int cartIndex;
  final int? quantityLimit;
  final CartController cartController;
  const QuantityButton({
    key,
    required this.isIncrement,
    required this.quantity,
    required this.stock,
    required this.isExistInCart,
    required this.cartIndex,
    this.isCartWidget = false,
    this.quantityLimit,
    required this.cartController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cartController.isLoading
          ? null
          : () {
              if (isExistInCart) {
                if (!isIncrement && quantity! > 1) {
                  // Get.find<CartController>()
                  //     .setQuantity(false, cartIndex, stock, quantityLimit);
                } else if (isIncrement && quantity! > 0) {
                  if (quantity! < stock! || !Get.find<SplashController>().configModel!.moduleConfig!.module!.stock!) {
                    // Get.find<CartController>()
                    //     .setQuantity(true, cartIndex, stock, quantityLimit);
                  } else {
                    showCustomSnackBar('out_of_stock'.tr);
                  }
                }
              } else {
                if (!isIncrement && quantity! > 1) {
                  Get.find<ItemController>().setQuantity(false, stock, quantityLimit);
                } else if (isIncrement && quantity! > 0) {
                  if (quantity! < stock! || !Get.find<SplashController>().configModel!.moduleConfig!.module!.stock!) {
                    Get.find<ItemController>().setQuantity(true, stock, quantityLimit);
                  } else {
                    showCustomSnackBar('out_of_stock'.tr);
                  }
                }
              }
            },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (quantity! == 1 && !isIncrement) || cartController.isLoading ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Icon(
            isIncrement ? Icons.add : Icons.remove,
            color: isIncrement
                ? Colors.white
                : quantity! == 1
                    ? Colors.black
                    : Colors.white,
            size: isCartWidget ? 26 : 20,
          ),
        ),
      ),
    );
  }
}
