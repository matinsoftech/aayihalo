import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/view/screens/home/widget/bad_weather_widget.dart';
import 'package:sixam_mart/view/screens/home/widget/grocery/banner_view.dart';
import 'package:sixam_mart/view/screens/home/widget/grocery/category_view.dart';
import 'package:sixam_mart/view/screens/home/widget/grocery/most_popular_item_view.dart';
import 'package:sixam_mart/view/screens/home/widget/grocery/collection_sections.dart';
import 'package:sixam_mart/view/screens/home/widget/grocery/special_offer_view.dart';

class GroceryHomeScreen extends StatelessWidget {
  const GroceryHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).disabledColor.withOpacity(0.1),
        child: const Column(
          children: [
            BadWeatherWidget(),
            BannerView(isFeatured: false),
            SizedBox(height: 12),
          ],
        ),
      ),
      GetBuilder<ItemController>(
        builder: (controller) => controller.isLoading
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (controller.homeScreenDataModel?.deliveryTime != null) const CategoryViewWidget(),

                  // isLoggedIn ? const VisitAgainView() : const SizedBox(),

                  const SpecialOfferView(isFood: false, isShop: false),

                  const MostPopularItemView(isFood: false, isShop: false),

                  controller.homeScreenDataModel == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            ...List.generate(
                              controller.homeScreenDataModel!.storeCollections!.length,
                              (index) => HomeScreenSections(
                                isFood: false,
                                isShop: false,
                                title: controller.homeScreenDataModel!.storeCollections![index].name!,
                                products: controller.homeScreenDataModel!.storeCollections![index].products!,
                              ),
                            ),
                          ],
                        ),

                  // HomeScreenSections(
                  //   isFood: false,
                  //   isShop: false,
                  //   title: controller.homeScreenDataModel!.storeCollections![0].name!,
                  //   products: controller
                  //       .homeScreenDataModel!.storeCollections![0].products!,
                  // ),
                  // const FlashSaleView(),
                  // const BestStoreNearbyView(),
                  // const MostPopularItemView(isFood: false, isShop: false),
                  const BannerView(isFeatured: false),
                  // const SizedBox(height: 16),
                  // const BestReviewItemView(),
                  // const StoreWiseBannerView(),
                  // const JustForYouView(),
                  // const ItemThatYouLoveView(forShop: false),
                  // isLoggedIn ? const PromoCodeBannerView() : const SizedBox(),
                  // const NewOnMartView(isPharmacy: false, isShop: false),

                  const SizedBox(height: 160)
                ],
              ),
      )
      // const PromotionalBannerView(),
    ]);
  }
}
