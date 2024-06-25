import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/controller/order_tracking_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/body/notification_body.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/conversation_model.dart';
import 'package:sixam_mart/data/model/response/order_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/models/order_track_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/screens/order/widget/track_details_view.dart';
import 'package:sixam_mart/view/screens/order/widget/tracking_stepper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String? orderID;
  final String? contactNumber;
  const OrderTrackingScreen({Key? key, required this.orderID, this.contactNumber}) : super(key: key);

  @override
  OrderTrackingScreenState createState() => OrderTrackingScreenState();
}

class OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // GoogleMapController? _controller;
  // final bool _isLoading = true;
  // Set<Marker> _markers = HashSet<Marker>();
  // List<MarkerData> _customMarkers = [];
  // Timer? _timer;

  void _loadData() async {
    // await Get.find<OrderController>().trackOrder(widget.orderID, null, true, contactNumber: widget.contactNumber);
    await Get.find<OrderTrackingController>().newTrackOrder(widget.orderID, null, true, contactNumber: widget.contactNumber);
    // await Get.find<LocationController>().getCurrentLocation(true,
    //     notify: false,
    //     defaultLatLng: LatLng(
    //       double.parse(Get.find<LocationController>().getUserAddress()!.latitude!),
    //       double.parse(Get.find<LocationController>().getUserAddress()!.longitude!),
    //     ));
  }

  // void _startApiCall() {
  //   _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
  //     Get.find<OrderController>().timerTrackOrder(widget.orderID.toString(), contactNumber: widget.contactNumber);
  //   });
  // }

  @override
  void initState() {
    super.initState();

    _loadData();
    // _startApiCall();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller?.dispose();
  //   _timer?.cancel();
  // }

  // Widget _customMarker(String path) {
  //   return Stack(
  //     children: [
  //       Image.asset(Images.locationMarker, height: 40, width: 40),
  //       Positioned(top: 3, left: 0, right: 0, child: Center(
  //         child: ClipOval(child: CustomImage(image: path, placeholder: Images.userMarker, height: 20, width: 20, fit: BoxFit.cover)),
  //       )),
  //     ],
  //   );
  // }
  double subTotal = 0.0;
  double calculateTotalAmount({
    required double subTotal,
    double? deliveryCharge,
    double? coupon,
  }) {
    double totalAmount = subTotal;

    if (deliveryCharge != null) {
      totalAmount += deliveryCharge;
    }

    if (coupon != null) {
      totalAmount -= coupon;
    }

    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'order_tracking'.tr),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: GetBuilder<OrderTrackingController>(
        initState: (state) {},
        builder: (orderController) {
          OrderTrackModel? track;
          // subTotal = 0.0;

          if (orderController.orderTackModel != null) {
            track = orderController.orderTackModel;
            if (subTotal == 0.0) {
              for (var prices in track!.details) {
                var amount = prices.price;
                subTotal += amount!.toDouble();
              }
            }

            /*if(_controller != null && GetPlatform.isWeb) {
            if(_track.deliveryAddress != null) {
              _controller.showMarkerInfoWindow(MarkerId('destination'));
            }
            if(_track.store != null) {
              _controller.showMarkerInfoWindow(MarkerId('store'));
            }
            if(_track.deliveryMan != null) {
              _controller.showMarkerInfoWindow(MarkerId('delivery_boy'));
            }
          }*/
          }

          return track != null
              ? SingleChildScrollView(
                  child: SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          TrackingStepperWidget(
                            status: track.orderStatus,
                            takeAway: track.orderType == 'take_away',
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          //? order id and invoice
                          Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('order_id'.tr, style: robotoRegular),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text('#${track.id}', style: robotoBold),
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Handle button press
                                },
                                icon: const Icon(
                                  Icons.download,
                                  size: 16,
                                ), // The icon
                                label: const Text('Download Invoice'), // The text
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          //? items details
                          Container(
                            width: Get.size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(
                                width: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: ListView.builder(
                                itemCount: track.details.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var items = track!.details[index];

                                  Map<String, dynamic> itemDetails = jsonDecode(items.itemDetails.toString());
                                  // log(itemDetails.toString());
                                  var imageBaseUrl = Get.find<SplashController>().configModel!.baseUrls!.itemImageUrl;
                                  // print('full image base url: ');
                                  var fullImageBaseUrl = '$imageBaseUrl/${itemDetails['images'][0]}';

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: Alignment.center,
                                          child: ClipOval(
                                            child: Image.network(
                                              fullImageBaseUrl,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                return Image.asset(
                                                  Images.placeholder, // Path to your local asset image
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text('${itemDetails['name']}'),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                TrackingRichText(
                                                  titleText: 'QTY :',
                                                  value: ' ${itemDetails['unit_value']}',
                                                ),
                                                const SizedBox(width: 8),
                                                RichText(
                                                  text: TextSpan(
                                                    style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeExtraSmall),
                                                    children: [
                                                      const TextSpan(
                                                        text: 'Rs :',
                                                      ),
                                                      TextSpan(text: ' ${items.price}'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: Get.size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white12,
                            ),
                            child: Card(
                              elevation: 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Delivered To',
                                      style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Work',
                                      style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                        children: [
                                          const TextSpan(
                                            text: 'Receiver :',
                                          ),
                                          TextSpan(
                                            text: ' demo Supplier',
                                            style: robotoRegular.copyWith(color: Colors.black54, fontSize: Dimensions.fontSizeDefault),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                        children: [
                                          const TextSpan(
                                            text: 'Contact :',
                                          ),
                                          TextSpan(
                                            text: ' 984513465',
                                            style: robotoRegular.copyWith(color: Colors.black54, fontSize: Dimensions.fontSizeDefault),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                        children: [
                                          const TextSpan(
                                            text: 'Landmark :',
                                          ),
                                          TextSpan(
                                            text: ' asdasdasd',
                                            style: robotoRegular.copyWith(color: Colors.black54, fontSize: Dimensions.fontSizeDefault),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          //?payment details card
                          Container(
                            width: Get.size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white12,
                            ),
                            child: Card(
                              elevation: 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payment Details',
                                      style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Payment Method',
                                      style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '${track.paymentMethod}',
                                      style: robotoRegular.copyWith(color: Colors.black54, fontSize: Dimensions.fontSizeLarge),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Divider(),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Transaction date',
                                      style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      DateConverter.newDateTimeStringToDateTime(track.createdAt!.toString()),
                                      style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //? final summary
                          Container(
                            width: Get.size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  width: 0.3,
                                  color: Theme.of(context).primaryColor,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Total Summary',
                                    style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Subtotal',
                                        style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                      ),
                                      Text('Rs ${subTotal}'),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Delivery Free',
                                        style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                      ),
                                      Text('(+) Rs ${track.deliveryCharge ?? 0}'),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Coupon Discount',
                                        style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                      ),
                                      Text('(-) Rs ${track.couponCode ?? 0}'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeLarge),
                                      ),
                                      Text('Rs ${calculateTotalAmount(subTotal: subTotal, deliveryCharge: track.deliveryCharge!.toDouble(), coupon: track.couponCode)}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // void setMarker(Store? store, DeliveryMan? deliveryMan, AddressModel? addressModel, bool takeAway, bool parcel, bool isRestaurant) async {
  //   try {
  //     Uint8List restaurantImageData = await convertAssetToUnit8List(
  //         parcel
  //             ? Images.userMarker
  //             : isRestaurant
  //                 ? Images.restaurantMarker
  //                 : Images.markerStore,
  //         width: isRestaurant ? 100 : 150);
  //     Uint8List deliveryBoyImageData = await convertAssetToUnit8List(Images.deliveryManMarker, width: 100);
  //     Uint8List destinationImageData = await convertAssetToUnit8List(
  //       takeAway ? Images.myLocationMarker : Images.userMarker,
  //       width: takeAway ? 50 : 100,
  //     );

  //     // Animate to coordinate
  //     LatLngBounds? bounds;
  //     double rotation = 0;
  //     if (_controller != null) {
  //       if (double.parse(addressModel!.latitude!) < double.parse(store!.latitude!)) {
  //         bounds = LatLngBounds(
  //           southwest: LatLng(double.parse(addressModel.latitude!), double.parse(addressModel.longitude!)),
  //           northeast: LatLng(double.parse(store.latitude!), double.parse(store.longitude!)),
  //         );
  //         rotation = 0;
  //       } else {
  //         bounds = LatLngBounds(
  //           southwest: LatLng(double.parse(store.latitude!), double.parse(store.longitude!)),
  //           northeast: LatLng(double.parse(addressModel.latitude!), double.parse(addressModel.longitude!)),
  //         );
  //         rotation = 180;
  //       }
  //     }
  //     LatLng centerBounds = LatLng(
  //       (bounds!.northeast.latitude + bounds.southwest.latitude) / 2,
  //       (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
  //     );

  //     _controller!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: centerBounds, zoom: GetPlatform.isWeb ? 10 : 17)));
  //     if (!ResponsiveHelper.isWeb()) {
  //       zoomToFit(_controller, bounds, centerBounds, padding: 1.5);
  //     }

  //     /// user for normal order , but sender for parcel order
  //     _markers = HashSet<Marker>();
  //     // _customMarkers = [];
  //     addressModel != null
  //         ? _markers.add(Marker(
  //             markerId: const MarkerId('destination'),
  //             position: LatLng(double.parse(addressModel.latitude!), double.parse(addressModel.longitude!)),
  //             infoWindow: InfoWindow(
  //               title: parcel ? 'Sender' : 'Destination',
  //               snippet: addressModel.address,
  //             ),
  //             icon: GetPlatform.isWeb ? BitmapDescriptor.defaultMarker : BitmapDescriptor.fromBytes(destinationImageData),
  //           ))
  //         : const SizedBox();
  //     /*addressModel != null ? _customMarkers.add(MarkerData(
  //       marker: Marker(markerId: const MarkerId('destination'),
  //         position: LatLng(double.parse(addressModel.latitude!), double.parse(addressModel.longitude!)),
  //         infoWindow: InfoWindow(
  //           title: parcel ? 'Sender' : 'Destination',
  //           snippet: addressModel.address,
  //         ),
  //       ),
  //       child:  GetPlatform.isWeb ? const Icon(Icons.location_on, size: 18) : _customMarker('${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${''}'),
  //     )) : const SizedBox();*/

  //     ///store for normal order , but receiver for parcel order
  //     store != null
  //         ? _markers.add(Marker(
  //             markerId: const MarkerId('store'),
  //             position: LatLng(double.parse(store.latitude!), double.parse(store.longitude!)),
  //             infoWindow: InfoWindow(
  //               title: parcel
  //                   ? 'Receiver'
  //                   : Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
  //                       ? 'store'.tr
  //                       : 'store'.tr,
  //               snippet: store.address,
  //             ),
  //             icon: GetPlatform.isWeb ? BitmapDescriptor.defaultMarker : BitmapDescriptor.fromBytes(restaurantImageData),
  //           ))
  //         : const SizedBox();

  //     /*store != null ? _customMarkers.add(MarkerData(
  //       marker: Marker(markerId: const MarkerId('store'),
  //         position: LatLng(double.parse(store.latitude!), double.parse(store.longitude!)),
  //         infoWindow: InfoWindow(
  //           title: parcel ? 'Receiver' : Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'store'.tr : 'store'.tr,
  //           snippet: store.address,
  //         ),
  //       ),
  //       child: GetPlatform.isWeb ? const Icon(Icons.location_on, size: 18) : _customMarker('${Get.find<SplashController>().configModel!.baseUrls!.storeImageUrl}/${store.logo}'),
  //     )) : const SizedBox();*/

  //     // deliveryMan != null
  //     //     ? _markers.add(Marker(
  //     //         markerId: const MarkerId('delivery_boy'),
  //     //         position: LatLng(double.parse(deliveryMan.lat ?? '0'), double.parse(deliveryMan.lng ?? '0')),
  //     //         infoWindow: InfoWindow(
  //     //           title: 'delivery_man'.tr,
  //     //           snippet: deliveryMan.location,
  //     //         ),
  //     //         rotation: rotation,
  //     //         icon: GetPlatform.isWeb ? BitmapDescriptor.defaultMarker : BitmapDescriptor.fromBytes(deliveryBoyImageData),
  //     //       ))
  //     //     : const SizedBox();

  //     /*deliveryMan != null ? _customMarkers.add(MarkerData(
  //       marker: Marker(markerId: const MarkerId('delivery_boy'),
  //         position: LatLng(double.parse(deliveryMan.lat ?? '0'), double.parse(deliveryMan.lng ?? '0')),
  //         infoWindow: InfoWindow(
  //           title: 'delivery_man'.tr,
  //           snippet: deliveryMan.location,
  //         ),
  //       ),
  //       child: GetPlatform.isWeb ? const Icon(Icons.location_on, size: 18) : _customMarker('${Get.find<SplashController>().configModel!.baseUrls!.deliveryManImageUrl}/${deliveryMan.image}'),
  //     )) : const SizedBox();*/
  //   } catch (_) {}
  //   setState(() {});
  // }

  // Future<void> zoomToFit(GoogleMapController? controller, LatLngBounds? bounds, LatLng centerBounds, {double padding = 0.5}) async {
  //   bool keepZoomingOut = true;

  //   while (keepZoomingOut) {
  //     final LatLngBounds screenBounds = await controller!.getVisibleRegion();
  //     if (fits(bounds!, screenBounds)) {
  //       keepZoomingOut = false;
  //       final double zoomLevel = await controller.getZoomLevel() - padding;
  //       controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //         target: centerBounds,
  //         zoom: zoomLevel,
  //       )));
  //       break;
  //     } else {
  //       // Zooming out by 0.1 zoom level per iteration
  //       final double zoomLevel = await controller.getZoomLevel() - 0.1;
  //       controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //         target: centerBounds,
  //         zoom: zoomLevel,
  //       )));
  //     }
  //   }
  // }

  // bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
  //   final bool northEastLatitudeCheck = screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
  //   final bool northEastLongitudeCheck = screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

  //   final bool southWestLatitudeCheck = screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
  //   final bool southWestLongitudeCheck = screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

  //   return northEastLatitudeCheck && northEastLongitudeCheck && southWestLatitudeCheck && southWestLongitudeCheck;
  // }

  // Future<Uint8List> convertAssetToUnit8List(String imagePath, {int width = 50}) async {
  //   ByteData data = await rootBundle.load(imagePath);
  //   Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //   FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
  // }
}

class TrackingRichText extends StatelessWidget {
  final String titleText;
  final String value;
  const TrackingRichText({
    required this.titleText,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeExtraSmall),
        children: [
          TextSpan(
            text: titleText,
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
