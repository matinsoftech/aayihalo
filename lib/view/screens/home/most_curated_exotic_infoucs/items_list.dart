import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/web_page_title_widget.dart';
import 'package:sixam_mart/view/screens/home/most_curated_exotic_infoucs/new_item_views.dart';

class ItemsListScreen extends StatefulWidget {
  final bool isPopular;
  final bool isSpecial;
  final bool isMostCurated;
  final bool isExotic;
  final bool isInFocus;
  final bool isJustForYou;
  final bool isTest;
  final String title;
  const ItemsListScreen({
    Key? key,
    required this.isPopular,
    required this.isSpecial,
    required this.isMostCurated,
    required this.isExotic,
    required this.isInFocus,
    required this.isJustForYou,
    required this.isTest,
    required this.title,
  }) : super(key: key);

  @override
  State<ItemsListScreen> createState() => _PopularItemScreenState();
}

class _PopularItemScreenState extends State<ItemsListScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    if (widget.isPopular) {
      Get.find<ItemController>().getPopularItemList(true, Get.find<ItemController>().popularType, false);
    } else if (widget.isSpecial) {
      Get.find<ItemController>().getDiscountedItemList(true, false);
    } else {
      Get.find<ItemController>().getReviewedItemList(true, Get.find<ItemController>().reviewType, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isShop = Get.find<SplashController>().module != null && Get.find<SplashController>().module!.moduleType.toString() == AppConstants.ecommerce;

    return GetBuilder<ItemController>(
      builder: (itemController) {
        if (widget.isJustForYou) {
          print(itemController.homeScreenDataModel!.justforyouItems[1].name);
        }
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: CustomAppBar(
            key: scaffoldKey,
            title: widget.title,
            showCart: true,
            // type: widget.isMostCurated ? itemController.homeScreenDataModel!.storeCollections[1].name : itemController.reviewType,
            // onVegFilterTap: (String type) {
            //   if (widget.isMostCurated) {
            //     itemController.getPopularItemList(true, type, true);
            //   } else {
            //     itemController.getReviewedItemList(true, type, true);
            //   }
            // },
          ),
          endDrawer: const MenuDrawer(),
          endDrawerEnableOpenDragGesture: false,
          body: Scrollbar(
            child: SingleChildScrollView(
              child: FooterView(
                child: Column(
                  children: [
                    // WebScreenTitleWidget(
                    //   title: widget.isPopular
                    //       ? isShop
                    //           ? 'most_popular_products'.tr
                    //           : 'most_popular_items'.tr
                    //       : widget.isSpecial
                    //           ? 'special_offer'.tr
                    //           : 'best_reviewed_item'.tr,
                    // ),
                    SizedBox(
                      width: Dimensions.webMaxWidth,
                      child: NewItemsView(
                        isStore: false,
                        stores: null,
                        items: widget.isMostCurated
                            ? itemController.homeScreenDataModel!.storeCollections[0].products
                            : widget.isExotic
                                ? itemController.homeScreenDataModel!.storeCollections[1].products
                                : widget.isInFocus
                                    ? itemController.homeScreenDataModel!.storeCollections[2].products
                                    : widget.isTest
                                        ? itemController.homeScreenDataModel!.storeCollections[3].products
                                        : itemController.homeScreenDataModel!.justforyouItems,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
