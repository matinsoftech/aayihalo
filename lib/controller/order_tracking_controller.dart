import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/data/model/response/response_model.dart';
import 'package:sixam_mart/data/repository/order_repo.dart';
import 'package:sixam_mart/models/order_track_model.dart';

class OrderTrackingController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderTrackingController({required this.orderRepo});

  OrderTrackModel? _orderTrackModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  OrderTrackModel? get orderTackModel => _orderTrackModel;

  Future<ResponseModel?> newTrackOrder(String? orderID, OrderTrackModel? orderTrackModel, bool fromTracking, {String? contactNumber, bool? fromGuestInput = false}) async {
    ResponseModel? responseModel;
    try {
      _isLoading = true;
      update();
      final String? guestId = Get.find<AuthController>().isLoggedIn() ? null : Get.find<AuthController>().getGuestId();
      Response response = await orderRepo.trackOrder(
        orderID,
        guestId,
        contactNumber: contactNumber,
      );
      if (response.statusCode == 200) {
        _orderTrackModel = OrderTrackModel.fromJson(response.body);
        responseModel = ResponseModel(true, 'Success');
      } else {
        responseModel = ResponseModel(false, 'Failed to load tracking details: ${response.statusCode}');
        debugPrint('Failed to load tracking details: ${response.statusCode}');
      }
    } catch (exception) {
      responseModel = ResponseModel(false, 'Error occurred: $exception');
      debugPrint('Error: orderTracking controller $exception');
    } finally {
      _isLoading = false;
      update();
    }
    return responseModel;
  }
}
