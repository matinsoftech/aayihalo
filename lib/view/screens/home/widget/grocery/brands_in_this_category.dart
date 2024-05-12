import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/view/base/title_widget.dart';

class BrandsInThisCategory extends StatelessWidget {
  const BrandsInThisCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemController>(builder: (itemController) {
      List<Item>? discountedItemList = itemController.discountedItemList;

      return discountedItemList != null
          ? discountedItemList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeDefault),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: Dimensions.paddingSizeExtraSmall,
                          right: Dimensions.paddingSizeDefault),
                      child: TitleWidget(
                        title: 'Brands in this category'.tr,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            8,
                            (index) => Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade300,
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.radiusSmall,
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          Images.mostPopularIcon,
                                          height: 50,
                                          width: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Brand $index',
                                      style: TextStyle(),
                                    )
                                  ],
                                )),
                      ),
                    )
                  ]),
                )
              : const SizedBox()
          : const ItemShimmerView(isPopularItem: false);
    });
  }
}

class ItemShimmerView extends StatelessWidget {
  final bool isPopularItem;
  const ItemShimmerView({Key? key, required this.isPopularItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: Container(
        color: Theme.of(context).disabledColor.withOpacity(0.1),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                top: Dimensions.paddingSizeDefault,
                left: Dimensions.paddingSizeDefault,
                right: Dimensions.paddingSizeDefault),
            child: TitleWidget(
              title:
                  isPopularItem ? 'most_popular_items'.tr : 'special_offer'.tr,
              image: isPopularItem
                  ? Images.mostPopularIcon
                  : Images.discountOfferIcon,
            ),
          ),
          SizedBox(
            height: 285,
            width: Get.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: Dimensions.paddingSizeDefault,
                      right: Dimensions.paddingSizeDefault,
                      top: Dimensions.paddingSizeDefault),
                  child: Shimmer(
                    duration: const Duration(seconds: 2),
                    enabled: true,
                    child: Container(
                      height: 285,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusLarge),
                      ),
                      child: Column(children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusLarge),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(Dimensions.paddingSizeSmall),
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
