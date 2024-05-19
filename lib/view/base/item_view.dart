import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/card_design/item_card.dart';
import 'package:sixam_mart/view/base/card_design/store_card_with_distance.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/item_shimmer.dart';
import 'package:sixam_mart/view/base/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/home/web/widgets/store_card_widget.dart';

class ItemsView extends StatefulWidget {
  final List<Item?>? items;
  final List<Store?>? stores;
  final bool isStore;
  final EdgeInsetsGeometry padding;
  final bool isScrollable;
  final int shimmerLength;
  final String? noDataText;
  final bool isCampaign;
  final bool inStorePage;
  final bool isFeatured;
  final bool? isFoodOrGrocery;
  const ItemsView(
      {Key? key,
      required this.stores,
      required this.items,
      required this.isStore,
      this.isScrollable = false,
      this.shimmerLength = 20,
      this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall),
      this.noDataText,
      this.isCampaign = false,
      this.inStorePage = false,
      this.isFeatured = false,
      this.isFoodOrGrocery = true})
      : super(key: key);

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    int length = 0;
    if (widget.isStore) {
      isNull = widget.stores == null;
      if (!isNull) {
        length = widget.stores!.length;
      }
    } else {
      isNull = widget.items == null;
      if (!isNull) {
        length = widget.items!.length;
      }
    }

    return Padding( 
      padding: widget.padding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        !isNull
            ? length > 0
                ? GridView.builder(
                  key: UniqueKey(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.70,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                  ),
                  physics: widget.isScrollable
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  shrinkWrap: widget.isScrollable ? false : true,
                  itemCount: length,
                  padding: widget.padding,
                  itemBuilder: (context, index) {
                    return
                        // widget.stores != null && widget.isStore
                        //     ?
                
                        //     widget.isFoodOrGrocery! && widget.isStore
                        //         ? StoreCardWidget(store: widget.stores![index])
                        //         : StoreCardWithDistance(
                        //             store: widget.stores![index]!,
                        //             fromAllStore: true)
                        //     :
                
                        Center(
                          child: ItemCard(
                                                // isStore: widget.isStore,
                                                item: widget.items![index]!,
                                                isShop: false,
                                                isFood: false,
                                                // isFeatured: widget.isFeatured,
                                                // store:
                                                // widget.isStore ? widget.stores![index] : null,
                                                // index: index,
                                                // length: length,
                                                // isCampaign: widget.isCampaign,
                                                // inStore: widget.inStorePage,
                                              ),
                        );
                  },
                )
                : NoDataScreen(
                    text: widget.noDataText ??
                        (widget.isStore
                            ? Get.find<SplashController>()
                                    .configModel!
                                    .moduleConfig!
                                    .module!
                                    .showRestaurantText!
                                ? 'no_restaurant_available'.tr
                                : 'no_store_available'.tr
                            : 'no_item_available'.tr),
                  )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: GridView.builder(
                  key: UniqueKey(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.70,
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: widget.isScrollable ? false : true,
                  itemCount: 9,
                  padding: widget.padding,
                  itemBuilder: (context, index) {
                    return
                        //  widget.isStore
                        //     ? widget.isFoodOrGrocery!
                        //         ? const StoreCardShimmer()
                        //         : const NewOnShimmerView()
                        //     :
      
                        Center(
                          child: ItemShimmer(
                              isEnabled: isNull,
                              isStore: widget.isStore,
                              hasDivider: index != widget.shimmerLength - 1),
                        );
                  },
                ),
              ),
      ]),
    );
  }
}

class NewOnShimmerView extends StatelessWidget {
  const NewOnShimmerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Stack(children: [
        Container(
          // width: fromAllStore ?  MediaQuery.of(context).size.width : 260,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
          child: Column(children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radiusDefault),
                    topRight: Radius.circular(Dimensions.radiusDefault)),
                child: Stack(clipBehavior: Clip.none, children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor.withOpacity(0.8),
                      ),
                      child: Icon(Icons.favorite_border,
                          color: Theme.of(context).primaryColor, size: 20),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 95),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 5,
                              width: 100,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(children: [
                            const Icon(Icons.location_on_outlined,
                                color: Colors.blue, size: 15),
                            const SizedBox(
                                width: Dimensions.paddingSizeExtraSmall),
                            Expanded(
                              child: Container(
                                height: 10,
                                width: 100,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                          ]),
                        ]),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 10,
                            width: 70,
                            padding: const EdgeInsets.symmetric(
                                vertical: 3,
                                horizontal: Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radiusLarge),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 65,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radiusSmall),
                            ),
                          ),
                        ]),
                  ),
                ),
              ]),
            ),
          ]),
        ),
        Positioned(
          top: 60,
          left: 15,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 65,
                width: 65,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
