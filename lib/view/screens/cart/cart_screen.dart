import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/coupon_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/store_controller.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/cart_data_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/helper/checkout_helper.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/cart_count_view.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_dropdown.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/item_widget.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/web_constrained_box.dart';
import 'package:sixam_mart/view/base/web_page_title_widget.dart';
import 'package:sixam_mart/view/screens/cart/widget/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/cart/widget/delivery_option_button.dart';
import 'package:sixam_mart/view/screens/cart/widget/web_cart_items_widget.dart';
import 'package:sixam_mart/view/screens/cart/widget/web_suggested_item_view.dart';
import 'package:sixam_mart/view/screens/checkout/checkout_screen.dart';
import 'package:sixam_mart/view/screens/checkout/widget/delivery_section.dart';
import 'package:sixam_mart/view/screens/dashboard/widget/address_bottom_sheet.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';

import 'widget/not_available_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  final bool fromNav;
  const CartScreen({key, required this.fromNav}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController guestContactPersonNameController =
      TextEditingController();
  final TextEditingController guestContactPersonNumberController =
      TextEditingController();
  final TextEditingController guestEmailController = TextEditingController();
  final FocusNode guestNumberNode = FocusNode();
  final FocusNode guestEmailNode = FocusNode();
  final _coupounCodeController = TextEditingController();
  @override
  void initState() {
    super.initState();

    initCall();
  }

  Future<void> initCall() async {
    if (Get.find<CartController>().cartList.isEmpty) {
      await Get.find<CartController>().getCartDataOnline();
    }
    if (Get.find<CartController>().cartList.isNotEmpty) {
      if (kDebugMode) {
        print(
            '----cart item : ${Get.find<CartController>().cartList[0].toJson()}');
      }
      if (Get.find<CartController>().addCutlery) {
        Get.find<CartController>().updateCutlery(isUpdate: false);
      }
      Get.find<CartController>().setAvailableIndex(-1, isUpdate: false);
      Get.find<StoreController>().getCartStoreSuggestedItemList(
          Get.find<CartController>().cartList[0].item!.storeId);
      Get.find<StoreController>().getStoreDetails(
          Store(
              id: Get.find<CartController>().cartList[0].item!.storeId,
              name: null),
          false,
          fromCart: true);
      // Get.find<CartController>().calculationCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'my_cart'.tr,
          backButton: (ResponsiveHelper.isDesktop(context) || !widget.fromNav)),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: GetBuilder<CartController>(
        builder: (cartController) {
          return cartController.cartList.isNotEmpty
              ? Column(
                  children: [
                    WebScreenTitleWidget(title: 'cart_list'.tr),
                    Expanded(
                      child: Scrollbar(
                        controller: scrollController,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: ResponsiveHelper.isDesktop(context)
                              ? const EdgeInsets.only(
                                  top: Dimensions.paddingSizeSmall,
                                )
                              : EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          child: FooterView(
                            child: SizedBox(
                              width: Dimensions.webMaxWidth,
                              child: Column(children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ResponsiveHelper.isDesktop(context)
                                        ? WebCardItemsWidget(cartList: [])
                                        : Expanded(
                                            flex: 7,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Product
                                                  WebConstrainedBox(
                                                    dataLength: cartController
                                                        .cartList.length,
                                                    minLength: 5,
                                                    minHeight: 0.6,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ...List.generate(
                                                              cartController
                                                                  .cartList
                                                                  .length,
                                                              (index) {
                                                            final data =
                                                                cartController
                                                                        .cartList[
                                                                    index];
                                                            final item =
                                                                data.item!;
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          8.0),
                                                              child: ListTile(
                                                                leading:
                                                                    Container(
                                                                  height: 56,
                                                                  width: 56,
                                                                  decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(
                                                                              '${AppConstants.baseUrl}/storage/app/public/product/${item.image}'),
                                                                          fit: BoxFit
                                                                              .cover),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                ),
                                                                title: Text(
                                                                    "${item.name.toString()}${cartController.cartList[index].variation != null ? ' (${cartController.cartList[index].variation})' : ''}"),
                                                                subtitle: Row(
                                                                  children: [
                                                                    const Spacer(),
                                                                    IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        cartController
                                                                            .removeCartItemOnline(index);
                                                                      },
                                                                    ),
                                                                    CartScreenItemCountView(
                                                                        cartIndex:
                                                                            index,
                                                                        item:
                                                                            item),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),

                                                          // apply coupon
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Card(
                                                              elevation: 5,
                                                              child: SizedBox(
                                                                child: Container(
                                                                    height: 250,
                                                                    width: double.infinity,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                      child: Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(height: 10),
                                                                            Text(
                                                                              'Coupoun Code',
                                                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(height: 16),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: TextFormField(
                                                                                controller: _coupounCodeController,
                                                                                decoration: InputDecoration(
                                                                                  hintText: 'Enter Coupoun Code',
                                                                                  hintStyle: TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            GetBuilder<CouponController>(
                                                                              builder: (controller) => Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: CustomButton(
                                                                                        buttonText: controller.isLoading ? 'Please wait..' : 'Apply Coupoun',
                                                                                        onPressed: controller.isLoading
                                                                                            ? () {}
                                                                                            : () {
                                                                                                final discount = controller.applyCoupon(_coupounCodeController.text, cartController.subTotal, 0.0, cartController.cartList[0].item!.storeId);
                                                                                                if (discount == 0.0) {
                                                                                                  showCustomSnackBar('Invalid Coupoun Code');
                                                                                                } else {
                                                                                                  showCustomSnackBar('Coupoun Applied', isError: false);
                                                                                                  cartController.setAppliedCoupon(_coupounCodeController.text);
                                                                                                }
                                                                                              }),
                                                                                  ),
                                                                                  Text(
                                                                                    'Discount applied : ${controller.discount}',
                                                                                    style: TextStyle(
                                                                                      fontSize: 11,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),

                                                          // billing info
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Card(
                                                              elevation: 5,
                                                              child: SizedBox(
                                                                child: Container(
                                                                    height: 180,
                                                                    width: double.infinity,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                      child: Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(height: 10),
                                                                            Text(
                                                                              'Billing Details',
                                                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(height: 32),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    'Subtotal',
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Re. ${cartController.subTotal}',
                                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    'Discount',
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Re. ${cartController.itemDiscountPrice}',
                                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),

                                                          // cancellation policy

                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Card(
                                                              elevation: 5,
                                                              child: SizedBox(
                                                                child: Container(
                                                                    height: 180,
                                                                    width: double.infinity,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                      child: Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const SizedBox(height: 10),
                                                                            const Text(
                                                                              'Cancellation Policy',
                                                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            const SizedBox(height: 32),
                                                                            Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  'You cannot cancel your order once it is packed and dispatched by our partners”. However you can always request for a refund if applicable.',
                                                                                  style: TextStyle(color: Colors.grey),
                                                                                )),
                                                                          ]),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),

                                                          // Padding(
                                                          //   padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                                                          //   child: TextButton.icon(
                                                          //     onPressed: (){
                                                          //       cartController.forcefullySetModule(cartController.cartList[0].item!.moduleId!);
                                                          //       //print('----current_route___ ${Get.routeTree.routes}');
                                                          //       Get.toNamed(
                                                          //         RouteHelper.getStoreRoute(id: cartController.cartList[0].item!.storeId, page: 'item'),
                                                          //         arguments: StoreScreen(store: Store(id: cartController.cartList[0].item!.storeId), fromModule: false),
                                                          //       );
                                                          //     },
                                                          //     icon: Icon(Icons.add_circle_outline_sharp, color: Theme.of(context).primaryColor),
                                                          //     label: Text('add_more_items'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeDefault)),
                                                          //   ),
                                                          // ),
                                                          // !ResponsiveHelper.isDesktop(context) ? suggestedItemView(cartController.cartList) : const SizedBox(),
                                                        ]),
                                                  ),
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeSmall),

                                                  // !ResponsiveHelper.isDesktop(context) ? pricingView(cartController, cartController.cartList[0].item!) : const SizedBox(),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.05),
                                                            blurRadius: 10)
                                                      ],
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: Dimensions
                                                            .paddingSizeLarge,
                                                        vertical: Dimensions
                                                            .paddingSizeSmall),
                                                    width: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Delivering to",
                                                            style:
                                                                robotoMedium),
                                                        const SizedBox(
                                                            height: Dimensions
                                                                .paddingSizeSmall),

                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 300,
                                                              child: Text(
                                                                Get.find<
                                                                        LocationController>()
                                                                    .getUserAddress()!
                                                                    .address!,
                                                              ),
                                                            ), 
InkWell( 
  onTap: (){ 

showDialog(context: context, builder: (_)=>Container(
  height: 400,
  child: AddressBottomSheet(
        fromDialog: true, 
        isCheckOut: true, 
        onTap: (AddressModel  address){ 
          
        },
      ),
));

  },
  child: const  Icon(Icons.edit, color: Colors.green, size: 20,)), 
                                                           
                                                          ],
                                                        ),

                                                        //  DeliveryOptionButton(
                                                        //   value: 'delivery', title: 'home_delivery'.tr, charge: charge,
                                                        //   isFree: storeController.store!.freeDelivery, fromWeb: true, total: total,
                                                        // ) :

                                                        // SingleChildScrollView(
                                                        //   scrollDirection:
                                                        //       Axis.horizontal,
                                                        //   child: Row(children: [
                                                        //     Get.find<SplashController>()
                                                        //                 .configModel!
                                                        //                 .homeDeliveryStatus ==
                                                        //             1
                                                        //         ? DeliveryOptionButton(
                                                        //             value:
                                                        //                 'delivery',
                                                        //             title:
                                                        //                 'home_delivery'
                                                        //                     .tr,
                                                        //             charge: 0.0,
                                                        //             isFree:
                                                        //                 false,
                                                        //             fromWeb:
                                                        //                 true,
                                                        //             total: 120,
                                                        //           )
                                                        //         : const SizedBox(),
                                                        //     const SizedBox(
                                                        //         width: Dimensions
                                                        //             .paddingSizeDefault),
                                                        //     Get.find<SplashController>()
                                                        //                 .configModel!
                                                        //                 .takeawayStatus ==
                                                        //             1
                                                        //         ? DeliveryOptionButton(
                                                        //             value:
                                                        //                 'take_away',
                                                        //             title:
                                                        //                 'take_away'
                                                        //                     .tr,
                                                        //             charge: 0.0,
                                                        //             isFree:
                                                        //                 true,
                                                        //             fromWeb:
                                                        //                 true,
                                                        //             total: 120,
                                                        //           )
                                                        //         : const SizedBox(),
                                                        //   ]),
                                                        // ),

                                                        const SizedBox(
                                                            height: Dimensions
                                                                .paddingSizeDefault),

                                                        ///Delivery_fee
                                                        Center(
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                              Text(
                                                                  '${'delivery_charge'.tr}: '),
                                                              Text(
                                                                  // storeController.store!.freeDelivery! ?
                                                                  'free'.tr
                                                                  // : orderController.distance != -1 ? PriceConverter.convertPrice(charge) : 'calculating'.tr,

                                                                  ),
                                                            ])),
                                                        // SizedBox(height: !takeAway && !isGuestLoggedIn ? Dimensions.paddingSizeLarge : 0),

                                                        // // /delivery section
                                                        // DeliverySection(
                                                        //   orderController: Get.find<
                                                        //       OrderController>(),
                                                        //   storeController: Get.find<
                                                        //       StoreController>(),
                                                        //   address: Get.find<
                                                        //           LocationController>()
                                                        //       .addressList!,
                                                        //   addressList: CheckoutHelper
                                                        //       .getDropdownAddressList(
                                                        //           context:
                                                        //               context,
                                                        //           addressList: Get
                                                        //                   .find<
                                                        //                       LocationController>()
                                                        //               .addressList!,
                                                        //           store: null),
                                                        //   guestNameTextEditingController:
                                                        //       guestContactPersonNameController,
                                                        //   guestNumberTextEditingController:
                                                        //       guestContactPersonNumberController,
                                                        //   guestNumberNode:
                                                        //       guestNumberNode,
                                                        //   guestEmailController:
                                                        //       guestEmailController,
                                                        //   guestEmailNode:
                                                        //       guestEmailNode,
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                    ResponsiveHelper.isDesktop(context)
                                        ? const SizedBox(
                                            width: Dimensions.paddingSizeSmall)
                                        : const SizedBox(),

                                    // ResponsiveHelper.isDesktop(context) ? Expanded(flex: 4, child: pricingView(cartController, cartController.cartList[0].item!)) : const SizedBox(),
                                  ],
                                ),

                                // ResponsiveHelper.isDesktop(context) ? WebSuggestedItemView(cartList: cartController.cartList) : const SizedBox(),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ResponsiveHelper.isDesktop(context)
                        ? const SizedBox.shrink()
                        : CheckoutButton(
                            cartController: cartController,
                            couponCode: _coupounCodeController.text,
                            availableList: cartController.availableList),
                  ],
                )
              : const NoDataScreen(isCart: true, text: '', showFooter: true);
        },
      ),
    );
  }

  Widget pricingView(CartController cartController, Item item) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(ResponsiveHelper.isDesktop(context)
            ? Dimensions.radiusDefault
            : Dimensions.radiusSmall),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
        ],
      ),
      child: GetBuilder<StoreController>(builder: (storeController) {
        return Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeSmall),
              child: Text('order_summary'.tr,
                  style:
                      robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
            ),
          ),

          !ResponsiveHelper.isDesktop(context) &&
                  Get.find<SplashController>()
                      .getModuleConfig('grocery')
                      .newVariation! &&
                  (storeController.store != null &&
                      storeController.store!.cutlery!)
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                      vertical: Dimensions.paddingSizeSmall),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(Images.cutlery, height: 18, width: 18),
                        const SizedBox(width: Dimensions.paddingSizeDefault),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('add_cutlery'.tr,
                                    style: robotoMedium.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall),
                                Text('do_not_have_cutlery'.tr,
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor,
                                        fontSize: Dimensions.fontSizeSmall)),
                              ]),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: cartController.addCutlery,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (bool? value) {
                              cartController.updateCutlery();
                            },
                            trackColor:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        )
                      ]),
                )
              : const SizedBox(),

          ResponsiveHelper.isDesktop(context)
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 0.5),
                  ),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  margin: ResponsiveHelper.isDesktop(context)
                      ? const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                          vertical: Dimensions.paddingSizeSmall)
                      : EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          if (ResponsiveHelper.isDesktop(context)) {
                            Get.dialog(
                                const Dialog(child: NotAvailableBottomSheet()));
                          } else {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (con) => const NotAvailableBottomSheet(),
                            );
                          }
                        },
                        child: Row(children: [
                          Expanded(
                              child: Text('if_any_product_is_not_available'.tr,
                                  style: robotoMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis)),
                          const Icon(Icons.arrow_forward_ios_sharp, size: 18),
                        ]),
                      ),
                      cartController.notAvailableIndex != -1
                          ? Row(children: [
                              Text(
                                  cartController
                                      .notAvailableList[
                                          cartController.notAvailableIndex]
                                      .tr,
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).primaryColor)),
                              IconButton(
                                onPressed: () =>
                                    cartController.setAvailableIndex(-1),
                                icon: const Icon(Icons.clear, size: 18),
                              )
                            ])
                          : const SizedBox(),
                    ],
                  ),
                ),
          ResponsiveHelper.isDesktop(context)
              ? const SizedBox()
              : const SizedBox(height: Dimensions.paddingSizeSmall),

          // Total
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeSmall),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('item_price'.tr, style: robotoRegular),
                PriceConverter.convertAnimationPrice(cartController.itemPrice,
                    textStyle: robotoRegular),
                // Text(PriceConverter.convertPrice(cartController.itemPrice), style: robotoRegular, textDirection: TextDirection.ltr),
              ]),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('discount'.tr, style: robotoRegular),
                storeController.store != null
                    ? Row(children: [
                        Text('(-)', style: robotoRegular),
                        PriceConverter.convertAnimationPrice(
                            cartController.itemDiscountPrice,
                            textStyle: robotoRegular),
                      ])
                    : Text('calculating'.tr, style: robotoRegular),
                // Text('(-) ${PriceConverter.convertPrice(cartController.itemDiscountPrice)}', style: robotoRegular, textDirection: TextDirection.ltr),
              ]),
              SizedBox(
                  height: cartController.variationPrice > 0
                      ? Dimensions.paddingSizeSmall
                      : 0),

              Get.find<SplashController>()
                          .getModuleConfig("grocery")
                          .newVariation! &&
                      cartController.variationPrice > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('variations'.tr, style: robotoRegular),
                        Text(
                            '(+) ${PriceConverter.convertPrice(cartController.variationPrice)}',
                            style: robotoRegular,
                            textDirection: TextDirection.ltr),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                  height: Get.find<SplashController>()
                          .configModel!
                          .moduleConfig!
                          .module!
                          .addOn!
                      ? 10
                      : 0),

              Get.find<SplashController>()
                      .configModel!
                      .moduleConfig!
                      .module!
                      .addOn!
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('addons'.tr, style: robotoRegular),
                        Text(
                            '(+) ${PriceConverter.convertPrice(cartController.addOns)}',
                            style: robotoRegular,
                            textDirection: TextDirection.ltr),
                      ],
                    )
                  : const SizedBox(),

              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              //   child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5)),
              // ),
            ]),
          ),

          ResponsiveHelper.isDesktop(context)
              ? CheckoutButton(
                  couponCode: _coupounCodeController.text,
                  cartController: cartController,
                  availableList: cartController.availableList,
                )
              : const SizedBox.shrink(),
        ]);
      }),
    );
  }

  // Widget suggestedItemView(List<CartModel> cartList){
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).cardColor,
  //       // boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), blurRadius: 10)]
  //     ),
  //     width: double.infinity,
  //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

  //       GetBuilder<StoreController>(builder: (storeController) {
  //         List<Item>? suggestedItems;
  //         if(storeController.cartSuggestItemModel != null){
  //           suggestedItems = [];
  //           List<int> cartIds = [];
  //           for (CartModel cartItem in cartList) {
  //             cartIds.add(cartItem.item!.id!);
  //           }
  //           for (Item item in storeController.cartSuggestItemModel!.items!) {
  //             if(!cartIds.contains(item.id)){
  //               suggestedItems.add(item);
  //             }
  //           }
  //         }
  //         return storeController.cartSuggestItemModel != null && suggestedItems!.isNotEmpty ? Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const SizedBox(height: Dimensions.paddingSizeSmall),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
  //               child: Text('you_may_also_like'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
  //             ),

  //              // delivery option

  //       const SizedBox(height: Dimensions.paddingSizeDefault),

  //     Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //         Text('${'delivery_charge'.tr}: '),
  //         // Text(
  //         //   storeController.store!.freeDelivery! ? 'free'.tr
  //         //       : orderController.distance != -1 ? PriceConverter.convertPrice(charge) : 'calculating'.tr,
  //         //   textDirection: TextDirection.ltr,
  //         // ),
  //       ])),
  //       // SizedBox(height: !takeAway && !isGuestLoggedIn ? Dimensions.paddingSizeLarge : 0),

  //             SizedBox(
  //               height: ResponsiveHelper.isDesktop(context) ? 160 : 125,
  //               child: ListView.builder(
  //                 scrollDirection: Axis.horizontal,
  //                 itemCount: suggestedItems.length,
  //                 physics: const BouncingScrollPhysics(),
  //                 padding: EdgeInsets.only(left: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault),
  //                 itemBuilder: (context, index) {
  //                   return Padding(
  //                     padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.symmetric(vertical: 20) : const EdgeInsets.symmetric(vertical: 10) ,
  //                     child: Container(
  //                       width: ResponsiveHelper.isDesktop(context) ? 500 : 300,
  //                       padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, left: Dimensions.paddingSizeExtraSmall),
  //                       margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
  //                       child: ItemWidget(
  //                         isStore: false, item: suggestedItems![index], fromCartSuggestion: true,
  //                         store: null, index: index, length: null, isCampaign: false, inStore: true,
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //         ) : const SizedBox();
  //       }),
  //     ]),
  //   );
  // }
}

class CheckoutButton extends StatelessWidget {
  final CartController cartController;
  final String? couponCode;
  final List<bool> availableList;
  const CheckoutButton(
      {key,
      required this.cartController,
      required this.availableList,
      this.couponCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = 0;

    return Container(
      width: Dimensions.webMaxWidth,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
              ResponsiveHelper.isDesktop(context)
                  ? Dimensions.radiusDefault
                  : 0),
          boxShadow: ResponsiveHelper.isDesktop(context)
              ? null
              : [
                  BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      blurRadius: 10)
                ]),
      child: GetBuilder<StoreController>(builder: (storeController) {
        if (Get.find<StoreController>().store != null &&
            !Get.find<StoreController>().store!.freeDelivery! &&
            Get.find<SplashController>().configModel!.freeDeliveryOver !=
                null) {
          percentage = cartController.subTotal /
              Get.find<SplashController>().configModel!.freeDeliveryOver!;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (storeController.store != null &&
                    !storeController.store!.freeDelivery! &&
                    Get.find<SplashController>()
                            .configModel!
                            .freeDeliveryOver !=
                        null &&
                    percentage < 1)
                ? Column(children: [
                    Row(children: [
                      Image.asset(Images.percentTag, height: 20, width: 20),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Text(
                        PriceConverter.convertPrice(Get.find<SplashController>()
                                .configModel!
                                .freeDeliveryOver! -
                            cartController.subTotal),
                        style: robotoMedium.copyWith(
                            color: Theme.of(context).primaryColor),
                        textDirection: TextDirection.ltr,
                      ),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Text('more_for_free_delivery'.tr,
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).disabledColor)),
                    ]),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    LinearProgressIndicator(
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                      value: percentage,
                    ),
                  ])
                : const SizedBox(),
            ResponsiveHelper.isDesktop(context)
                ? const Divider(height: 1)
                : const SizedBox(),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('subtotal'.tr,
                      style: robotoMedium.copyWith(
                          color: ResponsiveHelper.isDesktop(context)
                              ? Theme.of(context).textTheme.bodyLarge!.color
                              : Theme.of(context).primaryColor)),
                  PriceConverter.convertAnimationPrice(cartController.subTotal,
                      textStyle: robotoRegular.copyWith(
                          color: Theme.of(context).primaryColor)),
                  // Text(
                  //   PriceConverter.convertPrice(cartController.subTotal),
                  //   style: robotoMedium.copyWith(color: ResponsiveHelper.isDesktop(context) ? Theme.of(context).textTheme.bodyLarge!.color : Theme.of(context).primaryColor), textDirection: TextDirection.ltr,
                  // ),
                ],
              ),
            ),
            ResponsiveHelper.isDesktop(context) &&
                    Get.find<SplashController>()
                        .getModuleConfig('grocery')
                        .newVariation! &&
                    (storeController.store != null &&
                        storeController.store!.cutlery!)
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Images.cutlery, height: 18, width: 18),
                          const SizedBox(width: Dimensions.paddingSizeDefault),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('add_cutlery'.tr,
                                      style: robotoMedium.copyWith(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  Text('do_not_have_cutlery'.tr,
                                      style: robotoRegular.copyWith(
                                          color:
                                              Theme.of(context).disabledColor,
                                          fontSize: Dimensions.fontSizeSmall)),
                                ]),
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: cartController.addCutlery,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (bool? value) {
                                cartController.updateCutlery();
                              },
                              trackColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                          )
                        ]),
                  )
                : const SizedBox(),
            ResponsiveHelper.isDesktop(context)
                ? const SizedBox(height: Dimensions.paddingSizeSmall)
                : const SizedBox(),
            !ResponsiveHelper.isDesktop(context)
                ? const SizedBox()
                : Container(
                    width: Dimensions.webMaxWidth,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 0.5)),
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    //margin: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall) : EdgeInsets.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            if (ResponsiveHelper.isDesktop(context)) {
                              Get.dialog(const Dialog(
                                  child: NotAvailableBottomSheet()));
                            } else {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (con) =>
                                    const NotAvailableBottomSheet(),
                              );
                            }
                          },
                          child: Row(children: [
                            Expanded(
                                child: Text(
                                    'if_any_product_is_not_available'.tr,
                                    style: robotoMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis)),
                            const Icon(Icons.keyboard_arrow_down, size: 18),
                          ]),
                        ),
                        cartController.notAvailableIndex != -1
                            ? Row(children: [
                                Text(
                                    cartController
                                        .notAvailableList[
                                            cartController.notAvailableIndex]
                                        .tr,
                                    style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).primaryColor)),
                                IconButton(
                                  onPressed: () =>
                                      cartController.setAvailableIndex(-1),
                                  icon: const Icon(Icons.clear, size: 18),
                                )
                              ])
                            : const SizedBox(),
                      ],
                    ),
                  ),
            ResponsiveHelper.isDesktop(context)
                ? const SizedBox(height: Dimensions.paddingSizeSmall)
                : const SizedBox(),
            SafeArea(
              child: GetBuilder<LocationController>(
                builder: (locationController) => CustomButton(
                    buttonText: "Proceed to Pay".tr,
                    fontSize: ResponsiveHelper.isDesktop(context)
                        ? Dimensions.fontSizeSmall
                        : Dimensions.fontSizeLarge,
                    isBold: ResponsiveHelper.isDesktop(context) ? false : true,
                    radius: ResponsiveHelper.isDesktop(context)
                        ? Dimensions.radiusSmall
                        : Dimensions.radiusDefault,
                    onPressed: () {
                      final deliveryAddress = locationController.addressList!;

                      int id = -1;
                      if (deliveryAddress.isEmpty) {
                        showCustomSnackBar("Please add delivery address",
                            isError: false);
                      } else {
                        id = deliveryAddress[0].id!;
                      }
                      print(couponCode);

                      cartController.placeOrder(
                          deliveryAddressId: id, couponCode: couponCode);

                      // if(!cartController.cartList.first.item!.scheduleOrder! && availableList.contains(false)) {
                      //   showCustomSnackBar('one_or_more_product_unavailable'.tr);
                      // }

                      /*else if(Get.find<AuthController>().isGuestLoggedIn() && !Get.find<SplashController>().configModel!.guestCheckoutStatus!) {
                      showCustomSnackBar('currently_your_zone_have_no_permission_to_place_any_order'.tr);
                    }*/
                      //  else {
                      //   if(Get.find<SplashController>().module == null) {
                      //     int i = 0;
                      //     for(i = 0; i < Get.find<SplashController>().moduleList!.length; i++){
                      //       if(cartController.cartList[0].item!.moduleId == Get.find<SplashController>().moduleList![i].id){
                      //         break;
                      //       }
                      //     }
                      //     Get.find<SplashController>().setModule(Get.find<SplashController>().moduleList![i]);
                      //     HomeScreen.loadData(true);
                      //   }
                      //   Get.find<CouponController>().removeCouponData(false);

                      //   Get.toNamed(RouteHelper.getCheckoutRoute('cart'));
                      // }
                    }),
              ),
            ),
          ],
        );
      }),
    );
  }
}
