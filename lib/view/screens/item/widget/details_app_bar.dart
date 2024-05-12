import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/wishlist_controller.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';

class DetailsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Item item;

  const DetailsAppBar({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  DetailsAppBarState createState() => DetailsAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class DetailsAppBarState extends State<DetailsAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void shake() {
    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 15.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });

    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.bodyLarge!.color),
          onPressed: () => Navigator.pop(context)),
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
      title: Text(
        'item_details'.tr,
        style: robotoMedium.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: Theme.of(context).textTheme.bodyLarge!.color),
      ),
      centerTitle: true,
      actions: [
        AnimatedBuilder(
          animation: offsetAnimation,
          builder: (buildContext, child) {
            return Container(
              padding: EdgeInsets.only(
                left: offsetAnimation.value + 15.0,
              ),
              child: Stack(children: [
                IconButton(
                    icon: Icon(Icons.shopping_cart,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteHelper.getCartRoute());
                    }),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child:
                        GetBuilder<CartController>(builder: (cartController) {
                      return Text(
                        cartController.cartList.length.toString(),
                        style: robotoMedium.copyWith(
                            color: Colors.white, fontSize: 8),
                      );
                    }),
                  ),
                ),
              ]),
            );
          },
        ),
        GetBuilder<WishListController>(builder: (wishController) {
          return InkWell(
            onTap: () {
              if (Get.find<AuthController>().isLoggedIn()) {
                if (wishController.wishItemIdList.contains(widget.item.id)) {
                  wishController.removeFromWishList(widget.item.id, false);
                } else {
                  wishController.addToWishList(widget.item, null, false);
                }
              } else {
                showCustomSnackBar('you_are_not_logged_in'.tr);
              }
            },
            child: Icon(
              wishController.wishItemIdList.contains(widget.item.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
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
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
