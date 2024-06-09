import 'package:get/get.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/util/app_constants.dart';

class BannerRepo {
  final ApiClient apiClient;
  BannerRepo({required this.apiClient});

  Future<Response> getBannerList() async {
    return await apiClient.getData(AppConstants.bannerUri);
  }

  Future<Response> getTaxiBannerList() async {
    return await apiClient.getData(AppConstants.taxiBannerUri);
  }

  Future<Response> getFeaturedBannerList() async {
    return await apiClient.getData('${AppConstants.bannerUri}?featured=1');
  }

  Future<Response> getParcelOtherBannerList() async {
    return await apiClient.getData(AppConstants.parcelOtherBannerUri);
  }

  Future<Response> getPromotionalBanner() async {
    return await apiClient.getData(AppConstants.promotionalBannerUri);
  }

//by nirajan
  // var storeId = Get.find<ItemController>().homeScreenDataModel?.nearestStore!.id;
  Future getBannerWithStoreId(var storeId) async {
    // print('store id is $storeId');
    return await apiClient.getData("${AppConstants.bannerWithStoreId}?store_id=$storeId");
  }
}
