import 'package:carousel_slider/carousel_slider.dart';
import 'package:sixam_mart/controller/banner_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/basic_campaign_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerView extends StatelessWidget {
  final bool isFeatured;
  const BannerView({Key? key, required this.isFeatured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(builder: (bannerController) {
      List<String?>? bannerList = isFeatured
          ? bannerController.featuredBannerList
          : bannerController.bannerImageList;
      List<dynamic>? bannerDataList = isFeatured
          ? bannerController.featuredBannerDataList
          : bannerController.bannerDataList;

      return (bannerList != null && bannerList.isEmpty)
          ? const SizedBox()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: GetPlatform.isDesktop ? 500 : 220,
              padding:
                  const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              child: bannerList != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: false,
                              viewportFraction: 0.92,
                              autoPlayInterval: const Duration(seconds: 7),
                              onPageChanged: (index, reason) {
                                bannerController.setCurrentIndex(index, true);
                              },
                            ),
                            itemCount:
                                bannerList.isEmpty ? 1 : bannerList.length,
                            itemBuilder: (context, index, _) {
                              String? baseUrl =
                                  bannerDataList![index] is BasicCampaignModel
                                      ? Get.find<SplashController>()
                                          .configModel!
                                          .baseUrls!
                                          .campaignImageUrl
                                      : Get.find<SplashController>()
                                          .configModel!
                                          .baseUrls!
                                          .bannerImageUrl; 
                              return InkWell(
                                onTap: () async { 
                                

                                  // bannerDataList[index] is Item ? Get.find<ItemController>().navigateToItemPage(bannerDataList[index], context) : bannerDataList[index] is Store ? Get.toNamed(RouteHelper.getStoreRoute(id: bannerDataList[index].id, page: isFeatured ? 'module' : 'banner'), arguments: StoreScreen(store: bannerDataList[index], fromModule: isFeatured)) : bannerDataList[index] is BasicCampaignModel ? Get.toNamed(RouteHelper.getBasicCampaignRoute(bannerDataList[index])) : await canLaunchUrlString(bannerDataList[index]) ? await launchUrlString(bannerDataList[index], mode: LaunchMode.externalApplication) : showCustomSnackBar('unable_to_found_url'.tr);
                                  // if (bannerDataList[index] is Item) {
                                  //   Item? item = bannerDataList[index];
                                  //   Get.find<ItemController>()
                                  //       .navigateToItemPage(item, context);
                                  // } else if (bannerDataList[index] is Store) {
                                  //   Store? store = bannerDataList[index];
                                  //   if (isFeatured &&
                                  //       Get.find<SplashController>()
                                  //               .moduleList !=
                                  //           null) {
                                  //     for (ModuleModel module
                                  //         in Get.find<SplashController>()
                                  //             .moduleList!) {
                                  //       if (module.id == store!.moduleId) {
                                  //         Get.find<SplashController>()
                                  //             .setModule(module);
                                  //         break;
                                  //       }
                                  //     }
                                  //   }
                                  //   Get.toNamed(
                                  //     RouteHelper.getStoreRoute(
                                  //         id: store!.id,
                                  //         page:
                                  //             isFeatured ? 'module' : 'banner'),
                                  //     arguments: StoreScreen(
                                  //         store: store, fromModule: isFeatured),
                                  //   );
                                  // } else if (bannerDataList[index]
                                  //     is BasicCampaignModel) {
                                  //   BasicCampaignModel campaign =
                                  //       bannerDataList[index];
                                  //   Get.toNamed(
                                  //       RouteHelper.getBasicCampaignRoute(
                                  //           campaign));
                                  // } else {
                                  //   String url = bannerDataList[index];
                                  //   if (await canLaunchUrlString(url)) {
                                  //     await launchUrlString(url,
                                  //         mode: LaunchMode.externalApplication);
                                  //   } else {
                                  //     showCustomSnackBar(
                                  //         'unable_to_found_url'.tr);
                                  //   }
                                  // }
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusLarge),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[
                                              Get.isDarkMode ? 800 : 200]!,
                                          spreadRadius: 1,
                                          blurRadius: 5)
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusLarge),
                                    child: GetBuilder<SplashController>(
                                        builder: (splashController) {
                                      return InkWell( 
                                        onTap: () {  
                                          
                                          print('bannerDataList[index] $bannerDataList[index]');
                                        },
                                        child: CustomImage(
                                          image: '$baseUrl/${bannerList[index]}',
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // const SizedBox(height: Dimensions.paddingSizeDefault),

                        /// show the indications for each banner
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: List.generate(
                        //     bannerController.bannerImageList!.length,
                        //     (index) => Container(
                        //       margin: const EdgeInsets.symmetric(horizontal: 2),
                        //       height: 5,
                        //       width: 14,
                        //       decoration: BoxDecoration(
                        //         color: index == bannerController.currentIndex
                        //             ? Colors.green
                        //             : Colors.grey,
                        //         borderRadius: BorderRadius.circular(
                        //             Dimensions.radiusDefault),
                        //       ),
                        //     ),
                        //   ),
                        // )

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: bannerController.bannerImageList!.map((bnr) {
                        //     int index = bannerController.bannerImageList!.indexOf(bnr);
                        //     int totalBanner = bannerController.bannerImageList!.length;
                        //     return
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(horizontal: 3),
                        //       child: index == bannerController.currentIndex ? Container(
                        //         decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                        //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        //         child: Text('${(index) + 1}/$totalBanner', style: robotoRegular.copyWith(color: Theme.of(context).cardColor, fontSize: 12)),
                        //       ) : Container(
                        //         height: 5, width: 6,
                        //         decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.5), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
                      ],
                    )
                  : Shimmer(
                      duration: const Duration(seconds: 2),
                      enabled: bannerList == null,
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusLarge),
                            color: Colors.grey[300],
                          )),
                    ),
            );
    });
  }
}
