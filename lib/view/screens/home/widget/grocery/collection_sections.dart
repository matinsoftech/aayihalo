import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/data/model/response/home_screen_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/view/base/title_widget.dart';
import 'package:sixam_mart/view/base/card_design/item_card.dart';

class HomeScreenSections extends StatelessWidget {
  final bool isFood;
  final bool isShop;
  final bool isJustForYou;
  final List<Product> products;
  final String title;
  const HomeScreenSections({
    super.key,
    required this.isFood,
    required this.isShop,
    this.isJustForYou = false,
    required this.products,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemController>(
      builder: (itemController) {
        // List<Item>? discountedItemList = itemController.discountedItemList;

        return products.isNotEmpty
            ? Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
                  child: TitleWidget(
                    title: title.tr,
                    // image: Images.discountOfferIcon,
                    // onTap: () => Get.toNamed(RouteHelper.getPopularItemRoute(false, true)),
                  ),
                ),
                SizedBox(
                  height: isJustForYou ? 500 : 285,
                  width: Get.width,
                  child: isJustForYou
                      ? GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0, // Adjust this value to decrease the space between items
                            mainAxisSpacing: 0.0, // Adjust this value to decrease the space between rows
                            childAspectRatio: 1.1 / 0.74,
                          ),
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                // bottom: Dimensions.paddingSizeDefault,
                                left: Dimensions.paddingSizeDefault,
                                top: Dimensions.paddingSizeDefault,
                              ),
                              child: ItemCardCollection(
                                item: products[index],
                                isPopularItem: false,
                                isFood: isFood,
                                isShop: isShop,
                                isJustForYou: true,
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                              child: ItemCardCollection(
                                item: products[index],
                                isPopularItem: false,
                                isFood: isFood,
                                isShop: isShop,
                              ),
                            );
                          },
                        ),
                ),
              ])
            : const SizedBox();
        // : const ItemShimmerView(isPopularItem: false);
      },
    );
  }
}

class ItemShimmerView extends StatelessWidget {
  final bool isPopularItem;
  const ItemShimmerView({super.key, required this.isPopularItem});

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
