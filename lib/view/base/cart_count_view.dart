import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/data/model/response/cart_data_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/screens/item/item_details_screen.dart';

class CartCountView extends StatelessWidget {
  final Item item;
  final bool fromItemDetail;

  final Widget? child;
  const CartCountView(
      {key, required this.item, this.child, this.fromItemDetail = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      int cartQty = cartController.getItemQuantity(item: item);

      return cartQty != 0
          ? Center(
              child: Container(
                width: fromItemDetail ? 100 : null,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      BorderRadius.circular(Dimensions.radiusExtraLarge),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: cartController.isLoading
                            ? null
                            : () {
                                int cartIndex = cartController.cartList
                                    .indexWhere((element) =>
                                        element.item!.id == item.id);
                                print(cartIndex);

                                if (cartController
                                        .cartList[cartIndex].quantity! >
                                    1) {
                                  cartController.currentItemId = item.id ?? -1;

                                  cartController.addToCart(
                                      quantity: cartController
                                              .cartList[cartIndex].quantity! -
                                          1,
                                      productId: cartController
                                          .cartList[cartIndex].item!.id!,
                                      variantType: null);
                                  // cartController.setQuantity(
                                  //   false,
                                  //   cartIndex,
                                  //   cartController.cartList[cartIndex].stock,
                                  //   cartController.cartList[cartIndex].item!
                                  //       .quantityLimit,
                                  // );
                                } else {
                                  cartController
                                      .removeCartItemOnline(cartIndex);
                                }
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
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
                      cartController.isLoading &&
                              cartController.currentItemId == item.id
                          ? SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).cardColor))
                          : Padding(
                              padding: EdgeInsets.all(fromItemDetail ? 0 : 2.0),
                              child: Text(
                                cartQty.toString(),
                                style: robotoMedium.copyWith(
                                    fontSize: fromItemDetail
                                        ? Dimensions.fontSizeLarge
                                        : Dimensions.fontSizeSmall,
                                    color: Theme.of(context).cardColor),
                              ),
                            ),
                      InkWell(
                        onTap: cartController.isLoading
                            ? null
                            : () {
                                cartController.currentItemId = item.id ?? -1;

                                int cartIndex = cartController.cartList
                                    .indexWhere((element) =>
                                        element.item!.id == item.id);
                                cartController.addToCart(
                                    quantity: cartController
                                            .cartList[cartIndex].quantity! +
                                        1,
                                    productId: cartController
                                        .cartList[cartIndex].item!.id!,
                                    variantType: null);
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall),
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
          : cartController.addingToCart &&
                  cartController.currentItemId == item.id
              ? Text(
                  "Adding..",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : InkWell(
                  onTap: () async {
                    cartController.currentItemId = item.id ?? -1;

                    item.variations != null && item.variations!.isNotEmpty
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ItemDetailsScreen(
                                    item: item, inStorePage: false)))
                        : Get.find<ItemController>()
                            .addToCart(productId: item.id!, quantity: 1);
                  },
                  child: child ??
                      Container(
                        height: fromItemDetail ? 40 : 25,
                        width: fromItemDetail ? 40 : 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10)
                            ]),
                        child: Icon(Icons.add,
                            size: fromItemDetail ? 24 : 20,
                            color: Theme.of(context).primaryColor),
                      ),
                );
    });
  }
}

class CartScreenItemCountView extends StatelessWidget {
  final CartItem item;
  final int cartIndex;
  final bool fromItemDetail;
  final Widget? child;
  const CartScreenItemCountView({
    key,
    required this.item,
    required this.cartIndex,
    this.child,
    this.fromItemDetail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      int cartQty = cartController.getItemQuantity(item: item);

      return cartQty != 0
          ? Center(
              child: Container(
                width: fromItemDetail ? 100 : null,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      BorderRadius.circular(Dimensions.radiusExtraLarge),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: cartController.isLoading
                            ? null
                            : () {
                                if (cartController
                                        .cartList[cartIndex].quantity! >
                                    1) {
                                  cartController.addToCart(
                                      quantity: cartController
                                              .cartList[cartIndex].quantity! -
                                          1,
                                      productId: cartController
                                          .cartList[cartIndex].item!.id!,
                                      variantType: null,
                                      index: cartIndex);
                                } else {
                                  cartController
                                      .removeCartItemOnline(cartIndex);
                                }
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
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
                      Padding(
                        padding: EdgeInsets.all(fromItemDetail ? 0 : 2.0),
                        child: Text(
                          cartQty.toString(),
                          style: robotoMedium.copyWith(
                              fontSize: fromItemDetail
                                  ? Dimensions.fontSizeLarge
                                  : Dimensions.fontSizeSmall,
                              color: Theme.of(context).cardColor),
                        ),
                      ),
                      InkWell(
                        onTap: cartController.isLoading
                            ? null
                            : () {
                                cartController.addToCart(
                                    quantity: cartController
                                            .cartList[cartIndex].quantity! +
                                        1,
                                    productId: cartController
                                        .cartList[cartIndex].item!.id!,
                                    variantType: null,
                                    index: cartIndex);
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall),
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
          : InkWell(
              onTap: () async {
                Get.find<ItemController>()
                    .addToCart(productId: item.id!, quantity: 1);
              },
              child: child ??
                  Container(
                    height: fromItemDetail ? 40 : 25,
                    width: fromItemDetail ? 40 : 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10)
                        ]),
                    child: Icon(Icons.add,
                        size: fromItemDetail ? 24 : 20,
                        color: Theme.of(context).primaryColor),
                  ),
            );
    });
  }
}
