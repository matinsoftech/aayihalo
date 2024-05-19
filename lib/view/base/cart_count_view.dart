import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class CartCountView extends StatelessWidget {
  final Item item;
  final bool fromItemDetail;
  final Widget? child;
  const CartCountView(
      {Key? key, required this.item, this.child, this.fromItemDetail = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      int cartQty = cartController.cartQuantity(item.id!);
      int cartIndex = cartController.isExistInCart(
          item.id, cartController.cartVariant(item.id!), false, null);
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
                                  cartController.setQuantity(
                                    false,
                                    cartIndex,
                                    cartController.cartList[cartIndex].stock,
                                    cartController.cartList[cartIndex].item!
                                        .quantityLimit,
                                  );
                                } else {
                                  cartController.removeFromCart(cartIndex);
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
                            size:  fromItemDetail ? null :  16  ,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      !cartController.isLoading
                          ? Padding(
                            padding:  EdgeInsets.all(fromItemDetail ? 0:  2.0),
                            child: Text(
                                cartQty.toString(),
                                style: robotoMedium.copyWith(
                                    fontSize: fromItemDetail
                                        ? Dimensions.fontSizeLarge
                                        : Dimensions.fontSizeSmall,
                                    color: Theme.of(context).cardColor),
                              ),
                          )
                          : SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).cardColor)),
                      InkWell(
                        onTap: cartController.isLoading
                            ? null
                            : () {
                                cartController.setQuantity(
                                    true,
                                    cartIndex,
                                    cartController.cartList[cartIndex].stock,
                                    cartController
                                        .cartList[cartIndex].quantityLimit);
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
                            size:  fromItemDetail ? null :  16  ,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ]),
              ),
            )
          : InkWell(
              onTap: () {
                Get.find<ItemController>().itemDirectlyAddToCart(item, context);
              },
              child: child ??
                  Container(
                    height: fromItemDetail ? 40:  25,
                    width: fromItemDetail ? 40: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10)
                        ]),
                    child: Icon(Icons.add,
                        size:fromItemDetail ? 24: 20, color: Theme.of(context).primaryColor),
                  ),
            );
    });
  }
}
