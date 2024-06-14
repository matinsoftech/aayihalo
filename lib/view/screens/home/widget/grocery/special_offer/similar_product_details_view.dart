import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/wishlist_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/screens/dashboard/widget/cart_detail_floating_button.dart';
import 'package:sixam_mart/view/screens/home/widget/grocery/special_offer/similar_product_item_tile.dart';
import 'package:sixam_mart/view/screens/item/widget/details_app_bar.dart';

class SimilarProductDetailsScreen extends StatefulWidget {
  // final Item? item;
  final int productId;
  final bool inStorePage;
  final List images;
  final List variations;
  final double productPrice;
  final String productName;
  final String unitType;
  final int veg;
  final String availableTimeStarts;
  final double discount;
  final String discountType;
  final String description;
  const SimilarProductDetailsScreen({
    key,
    // required this.item,
    required this.productId,
    required this.inStorePage,
    required this.images,
    required this.variations,
    required this.productPrice,
    required this.productName,
    required this.unitType,
    required this.veg,
    required this.availableTimeStarts,
    required this.discount,
    required this.discountType,
    required this.description,
  }) : super(key: key);

  @override
  State<SimilarProductDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<SimilarProductDetailsScreen> {
  final Size size = Get.size;
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  final GlobalKey<DetailsAppBarState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Get.find<ItemController>().getProductDetails(widget.item!);
  }

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    // print('category product length : ${widget.item?.categoryProducts?.length}');
    return GetBuilder<CartController>(
      builder: (cartController) {
        return GetBuilder<ItemController>(
          builder: (itemController) {
            int? stock = 0;
            String? baseUrl = Get.find<SplashController>().configModel!.baseUrls!.itemImageUrl;

            return Scaffold(
              key: _globalKey,
              backgroundColor: Theme.of(context).cardColor,
              endDrawer: const MenuDrawer(),
              endDrawerEnableOpenDragGesture: false,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomSheet: cartController.cartList.isEmpty ? const SizedBox() : const CartDetailFloatingButton(),
              appBar: ResponsiveHelper.isDesktop(context)
                  ? const CustomAppBar(title: '')
                  : AppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyLarge!.color),
                        onPressed: () => Get.back(),
                      ),
                      backgroundColor: Theme.of(context).cardColor,
                      elevation: 0,
                      title: Text(
                        'item_details'.tr,
                        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color),
                      ),
                      centerTitle: true,
                      actions: [
                        GetBuilder<WishListController>(builder: (wishController) {
                          return InkWell(
                            onTap: () {
                              if (Get.find<AuthController>().isLoggedIn()) {
                                if (wishController.wishItemIdList.contains(widget.productId)) {
                                  wishController.removeFromWishList(widget.productId, false);
                                } else {
                                  wishController.newAddToWishList(widget.productId);
                                }
                              } else {
                                showCustomSnackBar('you_are_not_logged_in'.tr);
                              }
                            },
                            child: Icon(
                              wishController.wishItemIdList.contains(widget.productId) ? Icons.favorite : Icons.favorite_border,
                              size: 25,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        }),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () => Share.share('Share this product https://example.com'),
                          child: Icon(
                            Icons.share,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
              body: SafeArea(
                child: Column(
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
                                  // ItemImageView(item: itemController.item),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        // onTap: () => Navigator.of(context).pushNamed(
                                        // RouteHelper.getItemImagesRoute(item!),
                                        // arguments: ItemImageView(item: item),
                                        // ),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: ResponsiveHelper.isDesktop(context) ? 350 : MediaQuery.of(context).size.width * 0.7,
                                              child: PageView.builder(
                                                controller: _controller,
                                                itemCount: widget.images.length,
                                                itemBuilder: (context, index) {
                                                  return ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: CustomImage(
                                                      image: '$baseUrl/${widget.images[index]}',
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                      width: MediaQuery.of(context).size.width,
                                                    ),
                                                  );
                                                },
                                                onPageChanged: (index) {
                                                  itemController.setImageSliderIndex(index);
                                                },
                                              ),
                                            ),

                                            // Positioned(
                                            //   left: 0,
                                            //   right: 0,
                                            //   bottom: 0,
                                            //   child: Padding(
                                            //     padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                            //     child: Row(
                                            //       mainAxisAlignment: MainAxisAlignment.center,
                                            //       children: _indicators(context, itemController, item?.images ?? []),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  Builder(
                                    builder: (context) {
                                      return NewItemTitleView(
                                        inStorePage: widget.inStorePage,
                                        isCampaign: itemController.item!.availableDateStarts != null,
                                        fromItemDetail: false,
                                        inStock: (Get.find<SplashController>().configModel!.moduleConfig!.module!.stock! && stock <= 0),
                                        variations: widget.variations,
                                        productPrice: widget.productPrice,
                                        availableTimeStarts: widget.availableTimeStarts,
                                        productName: widget.productName,
                                        unitType: widget.unitType,
                                        veg: widget.veg,
                                        productId: widget.productId,
                                        discount: widget.discount,
                                        discountType: widget.discountType,
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  // Variation

                                  widget.variations.isEmpty
                                      ? Text(
                                          "Nrs. ${widget.productPrice}",
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
                                                widget.variations.length,
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
                                                            widget.variations[index].type!.trim(),
                                                            style: robotoRegular.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            'NRs. ${widget.variations[index].price!}',
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

                                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                                  (widget.description.isNotEmpty)
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

                                            // widget.item?.categoryProducts != null && widget.item!.categoryProducts!.isNotEmpty
                                            //     ? ProductsInThisCategory(
                                            //         isFood: false,
                                            //         isShop: false,
                                            //         categoryDetails: widget.item?.categoryProducts ?? [],
                                            //       )
                                            //     : const SizedBox(),

                                            // const BrandsInThisCategory()
                                          ],
                                        )
                                      : const SizedBox(),

                                  const SizedBox(
                                    height: 120,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

  final SimilarProductDetailsScreen widget;
  final int index;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    final itemIsInCart = cartController.isExistInCart(widget.productId, widget.variations[index].type!, false, index);

    // print("item4 $itemIsInCart");
    return itemIsInCart != -1
        ? SizedBox(
            width: 80,
            child: GetBuilder<CartController>(
              builder: (cartController) {
                int cartQty = cartController.newGetItemQuantity(itemId: widget.productId);
                // print('card quantity  here is : ${cartQty != 0}');

                return cartQty != 0
                    ? Center(
                        child: Container(
                          width: null,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            InkWell(
                              onTap: cartController.isLoading
                                  ? null
                                  : () {
                                      int cartIndex = cartController.cartList.indexWhere((element) => element.item!.id == widget.productId);
                                      // print('cart index $cartIndex');

                                      if (cartController.cartList[cartIndex].quantity! > 1) {
                                        cartController.currentItemId = widget.productId;

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
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            cartController.isLoading && cartController.currentItemId == widget.productId
                                ? SizedBox(height: 10, width: 10, child: CircularProgressIndicator(color: Theme.of(context).cardColor))
                                : Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      cartQty.toString(),
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                                    ),
                                  ),
                            InkWell(
                              onTap: cartController.isLoading
                                  ? null
                                  : () {
                                      cartController.currentItemId = widget.productId;

                                      int cartIndex = cartController.cartList.indexWhere((element) => element.item!.id == widget.productId);
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
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      )
                    : cartController.addingToCart && cartController.currentItemId == widget.productId
                        ? Text(
                            "Adding..",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              // print('going to next page...');
                              cartController.currentItemId = widget.productId;

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
                              Get.find<ItemController>().addToCart(productId: widget.productId, quantity: 1);
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
                              child: Icon(Icons.add, size: 20, color: Theme.of(context).primaryColor),
                            ),
                          );
              },
            ),
          )
        : InkWell(
            onTap: cartController.isLoading && cartController.variationType == widget.variations[index].type
                ? () {}
                : () {
                    cartController.variationType = widget.variations[index].type ?? '';

                    cartController.addToCart(quantity: 1, productId: widget.productId, variantType: widget.variations[index].type);
                  },
            child: cartController.isLoading && cartController.variationType == widget.variations[index].type
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
