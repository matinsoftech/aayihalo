import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/title_widget.dart';
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
    // bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (controller.homeScreenDataModel?.deliveryTime != null) const CategoryViewWidget(),

                    // isLoggedIn ? const VisitAgainView() : const SizedBox(),

                    const SpecialOfferView(isFood: false, isShop: false),

                    const MostPopularItemView(isFood: false, isShop: false),

                    // controller.homeScreenDataModel == null
                    //     ? const SizedBox()
                    //     : Column(
                    //         children: [
                    //           ...List.generate(
                    //             controller.homeScreenDataModel!.storeCollections!.length,
                    //             (index) => HomeScreenSections(
                    //               isFood: false,
                    //               isShop: false,
                    //               title: controller.homeScreenDataModel!.storeCollections![index].name!,
                    //               products: controller.homeScreenDataModel!.storeCollections![index].products!,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    // ? most curated for you
                    HomeScreenSections(
                      isFood: false,
                      isShop: false,
                      title: controller.homeScreenDataModel!.storeCollections[0].name!,
                      products: controller.homeScreenDataModel!.storeCollections[0].products,
                      isPopular: false,
                      isSpecial: false,
                      isMostCurated: true,
                      isExotic: false,
                      isInFocus: false,
                      isTest: false,
                    ),
                    // const FlashSaleView(),
                    // const BestStoreNearbyView(),
                    // const MostPopularItemView(isFood: false, isShop: false),
                    //? MID BANNER
                    const BannerView(
                      isFeatured: false,
                      isMidBanner: true,
                    ),

                    const SizedBox(height: 16),
                    //? exotic fruits
                    HomeScreenSections(
                      isFood: false,
                      isShop: false,
                      title: controller.homeScreenDataModel!.storeCollections[1].name!,
                      products: controller.homeScreenDataModel!.storeCollections[1].products,
                      isPopular: false,
                      isSpecial: false,
                      isMostCurated: false,
                      isExotic: true,
                      isInFocus: false,
                      isTest: false,
                    ),
                    const SizedBox(height: 16),
                    //? in focus today
                    HomeScreenSections(
                      isFood: false,
                      isShop: false,
                      title: controller.homeScreenDataModel!.storeCollections[2].name!,
                      products: controller.homeScreenDataModel!.storeCollections[2].products,
                      isPopular: false,
                      isSpecial: false,
                      isMostCurated: false,
                      isExotic: false,
                      isInFocus: true,
                      isTest: false,
                    ),
                    const SizedBox(height: 16),
                    //?test
                    HomeScreenSections(
                      isFood: false,
                      isShop: false,
                      title: controller.homeScreenDataModel!.storeCollections[3].name!,
                      products: controller.homeScreenDataModel!.storeCollections[3].products,
                      isPopular: false,
                      isSpecial: false,
                      isMostCurated: false,
                      isExotic: false,
                      isInFocus: false,
                      isTest: true,
                    ),
                    //?just for you
                    HomeScreenSections(
                      isFood: false,
                      isShop: false,
                      title: 'Just For You',
                      products: controller.homeScreenDataModel!.justforyouItems,
                      isJustForYou: true,
                      isPopular: false,
                      isSpecial: false,
                      isMostCurated: false,
                      isExotic: false,
                      isInFocus: false,
                      isTest: false,
                    ),
                    //special adds
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.only(top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
                      child: TitleWidget(
                        title: "Today's Special Deals",
                        // image: Images.discountOfferIcon,
                        // onTap: () => Get.toNamed(RouteHelper.getPopularItemRoute(false, true)),
                      ),
                    ),
                    GetBuilder<ItemController>(
                      builder: (bannerController) {
                        String? baseUrl = 'https://nepnews.shahbazali.website/public';
                        if (bannerController.isLoading) {
                          return Shimmer(
                            duration: const Duration(seconds: 2),
                            // ignore: unnecessary_null_comparison
                            enabled: true,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                                color: Colors.grey[300],
                              ),
                            ),
                          );
                        } else if (bannerController.homeScreenDataModel!.specialAds.isEmpty) {
                          return const Center(child: Text('No Ads available'));
                        } else {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: GetPlatform.isDesktop ? 500 : 220,
                            padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: false,
                                viewportFraction: 0.35,
                                aspectRatio: 9 / 16,
                                autoPlayInterval: const Duration(seconds: 7),
                                onPageChanged: (index, reason) {
                                  bannerController.setCurrentIndex(index, true);
                                },
                              ),
                              items: bannerController.homeScreenDataModel!.specialAds.map(
                                (image) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 4),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                                          boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, spreadRadius: 1, blurRadius: 5)],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                                          child: CustomImage(
                                            image: '$baseUrl/${image.image}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        }
                      },
                    ),

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
      ],
    );
  }
}
