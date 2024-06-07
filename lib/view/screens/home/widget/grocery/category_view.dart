import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sixam_mart/controller/category_controller.dart';
import 'package:sixam_mart/controller/localization_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class CategoryViewWidget extends StatelessWidget {
  const CategoryViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return GetBuilder<SplashController>(builder: (splashController) {
      bool isPharmacy = splashController.module != null &&
          splashController.module!.moduleType.toString() ==
              AppConstants.pharmacy;
      bool isFood = splashController.module != null &&
          splashController.module!.moduleType.toString() == AppConstants.food;

      return GetBuilder<CategoryController>(builder: (categoryController) {
        return (categoryController.categoryList != null &&
                categoryController.categoryList!.isEmpty)
            ? const SizedBox()
            :
            // isPharmacy
            //     ? PharmacyCategoryView(categoryController: categoryController)
            //     :

            // isFood
            //     ?

            Center(child: FoodCategoryView(categoryController: categoryController));

        // :
        //  Column(
        //     children: [
        //       Row(
        //         children: [
        //           Expanded(
        //             child: SizedBox(
        //               height: 155,
        //               child: categoryController.categoryList != null
        //                   ? ListView.builder(
        //                       controller: scrollController,
        //                       itemCount: categoryController
        //                           .categoryList!.length,
        //                       padding: const EdgeInsets.only(
        //                           left: Dimensions.paddingSizeSmall,
        //                           top: Dimensions.paddingSizeDefault),
        //                       physics: const BouncingScrollPhysics(),
        //                       scrollDirection: Axis.horizontal,
        //                       itemBuilder: (context, index) {
        //                         return Padding(
        //                           padding: const EdgeInsets.only(
        //                               bottom:
        //                                   Dimensions.paddingSizeDefault,
        //                               right:
        //                                   Dimensions.paddingSizeSmall,
        //                               top: Dimensions
        //                                   .paddingSizeDefault),
        //                           child: InkWell(
        //                             onTap: () => Get.toNamed(RouteHelper
        //                                 .getCategoryItemRoute(
        //                               categoryController
        //                                   .categoryList![index].id,
        //                               categoryController
        //                                   .categoryList![index].name!,
        //                             )),
        //                             child: SizedBox(
        //                               width: 80,
        //                               child: Column(children: [
        //                                 SizedBox(
        //                                   height: 75,
        //                                   width: 75,
        //                                   child: Stack(children: [
        //                                     ClipRRect(
        //                                       borderRadius:
        //                                           BorderRadius.circular(
        //                                               Dimensions
        //                                                   .radiusSmall),
        //                                       child: CustomImage(
        //                                         image:
        //                                             '${Get.find<SplashController>().configModel!.baseUrls!.categoryImageUrl}/${categoryController.categoryList![index].image}',
        //                                         height: 75,
        //                                         width: 75,
        //                                         fit: BoxFit.cover,
        //                                       ),
        //                                     ),
        //                                   ]),
        //                                 ),
        //                                 const SizedBox(
        //                                     height: Dimensions
        //                                         .paddingSizeExtraSmall),
        //                                 Padding(
        //                                   padding: EdgeInsets.only(
        //                                       right: index == 0
        //                                           ? Dimensions
        //                                               .paddingSizeExtraSmall
        //                                           : 0),
        //                                   child: Text(
        //                                     categoryController
        //                                         .categoryList![index]
        //                                         .name!,
        //                                     style: robotoMedium
        //                                         .copyWith(fontSize: 11),
        //                                     maxLines: Get.find<
        //                                                 LocalizationController>()
        //                                             .isLtr
        //                                         ? 2
        //                                         : 1,
        //                                     overflow:
        //                                         TextOverflow.ellipsis,
        //                                     textAlign: TextAlign.center,
        //                                   ),
        //                                 ),
        //                               ]),
        //                             ),
        //                           ),
        //                         );
        //                       },
        //                     )
        //                   : CategoryShimmer(
        //                       categoryController: categoryController),
        //             ),
        //           ),
        //           ResponsiveHelper.isMobile(context)
        //               ? const SizedBox()
        //               : categoryController.categoryList != null
        //                   ? Column(
        //                       children: [
        //                         InkWell(
        //                           onTap: () {
        //                             showDialog(
        //                                 context: context,
        //                                 builder: (con) => Dialog(
        //                                     child: SizedBox(
        //                                         height: 550,
        //                                         width: 600,
        //                                         child: CategoryPopUp(
        //                                           categoryController:
        //                                               categoryController,
        //                                         ))));
        //                           },
        //                           child: Padding(
        //                             padding: const EdgeInsets.only(
        //                                 right: Dimensions
        //                                     .paddingSizeSmall),
        //                             child: CircleAvatar(
        //                               radius: 35,
        //                               backgroundColor: Theme.of(context)
        //                                   .primaryColor,
        //                               child: Text('view_all'.tr,
        //                                   style: TextStyle(
        //                                       fontSize: Dimensions
        //                                           .paddingSizeDefault,
        //                                       color: Theme.of(context)
        //                                           .cardColor)),
        //                             ),
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           height: 10,
        //                         )
        //                       ],
        //                     )
        //                   : CategoryShimmer(
        //                       categoryController: categoryController),
        //         ],
        //       ),
        //     ],
        //   );
      });
    });
  }
}

class PharmacyCategoryView extends StatelessWidget {
  final CategoryController categoryController;
  const PharmacyCategoryView({Key? key, required this.categoryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 160,
        child: categoryController.categoryList != null
            ? ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                    left: Dimensions.paddingSizeDefault,
                    top: Dimensions.paddingSizeDefault),
                itemCount: categoryController.categoryList!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.paddingSizeDefault,
                        right: Dimensions.paddingSizeSmall,
                        top: Dimensions.paddingSizeDefault),
                    child: InkWell(
                      onTap: () => Get.toNamed(RouteHelper.getCategoryItemRoute(
                        categoryController.categoryList![index].id,
                        categoryController.categoryList![index].name!,
                      )),
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                      child: Container(
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(100)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).primaryColor.withOpacity(0.3),
                              Theme.of(context).cardColor.withOpacity(0.3),
                            ],
                          ),
                        ),
                        child: Column(children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100)),
                            child: CustomImage(
                              image:
                                  '${Get.find<SplashController>().configModel!.baseUrls!.categoryImageUrl}/${categoryController.categoryList![index].image}',
                              height: 60,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Expanded(
                              child: Text(
                            categoryController.categoryList![index].name!,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          )),
                        ]),
                      ),
                    ),
                  );
                },
              )
            : PharmacyCategoryShimmer(categoryController: categoryController),
      ),
    ]);
  }
}

class FoodCategoryView extends StatelessWidget {
  final CategoryController categoryController;
  const FoodCategoryView({Key? key, required this.categoryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Stack(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: categoryController.categoryList != null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeSmall,
                          horizontal: 16,
                        ),
                        // child: Text('campaigns'.tr, style: robotoMedium.copyWith(fontSize: 24)),
                        child: TitleWidget(
                          title: 'Categories'.tr,
                          // onTap: () {
                          //   Get.to(CategoryViewAllScreen(
                          //     categories: categoryController.categoryList!,
                          //   ));
                          // },
                        ),
                      ),
          
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          for (int i = 0;
                              i < categoryController.categoryList!.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.all( 
                               8,
                                  ),
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed(RouteHelper.getCategoryItemRoute(
                                  categoryController.categoryList![i].id,
                                  categoryController.categoryList![i].name!,
                                )),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radiusSmall),
                                child: SizedBox(
                                  width: 80,
                                  child: Column(children: [
                                    Container(
                                      height: 75,
                                      width: 75,
                                      margin: EdgeInsets.only(
                                        left: i == 0
                                            ? 0
                                            : Dimensions.paddingSizeExtraSmall,
                                        right: Dimensions.paddingSizeExtraSmall,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.radiusLarge,
                                        ),
                                        border: Border.all(
                                          color: Theme.of(context).dividerColor,
                                          width: 1,
                                        ),
                                        // image: DecorationImage(
                                        //   image: CachedNetworkImageProvider(
                                        //     '${Get.find<SplashController>().configModel!.baseUrls!.categoryImageUrl}/${categoryController.categoryList![i].image}',
                                        //   ),
                                        // ),
                                        color: const Color(0xFFFAFCEF),
                                      ),
                      
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CachedNetworkImage(imageUrl: '${Get.find<SplashController>().configModel!.baseUrls!.categoryImageUrl}/${categoryController.categoryList![i].image}',),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: Dimensions.paddingSizeExtraSmall),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: i == 0
                                            ? Dimensions.paddingSizeExtraSmall
                                            : 0,
                                      ),
                                      child: Text(
                                        categoryController.categoryList![i].name!,
                                        style:
                                            robotoMedium.copyWith(fontSize: 11),
                                        maxLines:
                                            Get.find<LocalizationController>()
                                                    .isLtr
                                                ? 2
                                                : 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                        ],
                      )
                      // Expanded(
                      //   child: GridView.builder(
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 4,
                      //       childAspectRatio: 0.65,
                      //     ),
                      //     controller: scrollController,
                      //     physics: const BouncingScrollPhysics(),
                      //     shrinkWrap: true,
                      //     padding: const EdgeInsets.only(
                      //         left: Dimensions.paddingSizeDefault,
                      //         top: Dimensions.paddingSizeDefault),
                      //     itemCount: categoryController.categoryList!.length > 8
                      //         ? 8
                      //         : categoryController.categoryList!.length,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(
                      //             bottom: Dimensions.paddingSizeDefault,
                      //             right: Dimensions.paddingSizeDefault,
                      //             top: Dimensions.paddingSizeDefault),
                      //         child: InkWell(
                      //           onTap: () =>
                      //               Get.toNamed(RouteHelper.getCategoryItemRoute(
                      //             categoryController.categoryList![index].id,
                      //             categoryController.categoryList![index].name!,
                      //           )),
                      //           borderRadius:
                      //               BorderRadius.circular(Dimensions.radiusSmall),
                      //           child: SizedBox(
                      //             width: 60,
                      //             child: Column(children: [
                      //               Container(
                      //                 height: 80,
                      //                 width: 120,
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(16),
                      //                   color: const Color(0xFFFAFCEF),
                      //                 ),
                      //                 child: Center(
                      //                   child: CustomImage(
                      //                     image:
                      // '${Get.find<SplashController>().configModel!.baseUrls!.categoryImageUrl}/${categoryController.categoryList![index].image}',
                      //                     height: 60,
                      //                     width: 110,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                 ),
                      //               ),
                      //               // ClipRRect(
                      //               //   borderRadius: const BorderRadius.all(
                      //               //       Radius.circular(100)),
                      //               //   child: CustomImage(
                      //               //     image:
                      //               //         '${Get.find<SplashController>().configModel!.baseUrls!.categoryImageUrl}/${categoryController.categoryList![index].image}',
                      //               //     height: 60,
                      //               //     width: double.infinity,
                      //               //     fit: BoxFit.cover,
                      //               //   ),
                      //               // ),
                      //               const SizedBox(
                      //                   height: Dimensions.paddingSizeSmall),
                      //               Expanded(
                      //                   child: Text(
                      //                 categoryController
                      //                     .categoryList![index].name!,
                      //                 style: robotoMedium.copyWith(
                      //                     fontSize: Dimensions.fontSizeSmall,
                      //                     color: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyMedium!
                      //                         .color),
                      //                 maxLines: 2,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 textAlign: TextAlign.center,
                      //               )),
                      //             ]),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  )
                : FoodCategoryShimmer(categoryController: categoryController),
          ),
        ),
      ]),
    ]);
  }
}

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  const CategoryShimmer({Key? key, required this.categoryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      padding: const EdgeInsets.only(
          left: Dimensions.paddingSizeSmall,
          top: Dimensions.paddingSizeDefault),
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 1, vertical: Dimensions.paddingSizeDefault),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            enabled: true,
            child: SizedBox(
              width: 80,
              child: Column(children: [
                Container(
                    height: 75,
                    width: 75,
                    margin: EdgeInsets.only(
                      left: index == 0 ? 0 : Dimensions.paddingSizeExtraSmall,
                      right: Dimensions.paddingSizeExtraSmall,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                      color: Colors.grey[300],
                    )),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Padding(
                  padding: EdgeInsets.only(
                      right: index == 0 ? Dimensions.paddingSizeExtraSmall : 0),
                  child: Container(
                    height: 10,
                    width: 50,
                    color: Colors.grey[300],
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}

class FoodCategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  const FoodCategoryShimmer({Key? key, required this.categoryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 160,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                bottom: Dimensions.paddingSizeDefault,
                left: Dimensions.paddingSizeDefault,
                top: Dimensions.paddingSizeDefault),
            child: Shimmer(
              duration: const Duration(seconds: 2),
              enabled: true,
              child: SizedBox(
                width: 60,
                child: Column(children: [
                  Container(
                      height: 60,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey[300],
                      )),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Expanded(
                    child: Container(
                      height: 10,
                      width: 50,
                      color: Colors.grey[300],
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PharmacyCategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  const PharmacyCategoryShimmer({Key? key, required this.categoryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              bottom: Dimensions.paddingSizeDefault,
              left: Dimensions.paddingSizeDefault,
              top: Dimensions.paddingSizeDefault),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            enabled: true,
            child: Container(
              width: 70,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100)),
              ),
              child: Column(children: [
                Container(
                    height: 60,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        bottom: Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100)),
                      color: Colors.grey[300],
                    )),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Expanded(
                  child: Container(
                    height: 10,
                    width: 50,
                    color: Colors.grey[300],
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
