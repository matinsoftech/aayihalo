import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/cart_data_model.dart';
// import 'package:sixam_mart/data/model/response/cart_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/module_model.dart';
import 'package:sixam_mart/data/model/response/online_cart_model.dart';
import 'package:sixam_mart/data/repository/cart_repo.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  List<CartDataModel> _cartList = [];
  List<OnlineCartModel> _onlineCartList = [];

  AddressModel? addressModel;

  int _deliveryAddressId = -1;
  int get deliveryAddressId => _deliveryAddressId;

  set deliveryAddressId(int id) {
    _deliveryAddressId = id;
  }

  double _subTotal = 0;
  final double _itemPrice = 0;
  final double _itemDiscountPrice = 0;
  final double _addOns = 0;
  final double _variationPrice = 0;
  final List<List<AddOns>> _addOnsList = [];
  final List<bool> _availableList = [];
  String _variationType = '';
  String get variationType => _variationType;

  set variationType(String type) {
    _variationType = type;
  }

  List<String> notAvailableList = ['Remove it from my cart', 'I’ll wait until it’s restocked', 'Please cancel the order', 'Call me ASAP', 'Notify me when it’s back'];
  bool _addCutlery = false;
  int _notAvailableIndex = -1;
  int _currentIndex = 0;
  bool _isLoading = false;

  int _currentItemId = 0;
  int get currentItemId => _currentItemId;

  set currentItemId(int index) {
    _currentItemId = index;
  }

  bool _addingToCart = false;
  bool get addingToCart => _addingToCart;

  String _appliedCoupon = '';
  String get appliedCoupon => _appliedCoupon;

  void setAppliedCoupon(String coupon) {
    _appliedCoupon = coupon;
    update();
  }

  List<CartDataModel> get cartList => _cartList;
  List<OnlineCartModel> get onlineCartList => _onlineCartList;
  double get subTotal => _subTotal;
  double get itemPrice => _itemPrice;
  double get itemDiscountPrice => _itemDiscountPrice;
  double get addOns => _addOns;
  double get variationPrice => _variationPrice;
  List<List<AddOns>> get addOnsList => _addOnsList;
  List<bool> get availableList => _availableList;
  bool get addCutlery => _addCutlery;
  int get notAvailableIndex => _notAvailableIndex;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;

  void setAvailableIndex(int index, {bool isUpdate = true}) {
    if (_notAvailableIndex == index) {
      _notAvailableIndex = -1;
    } else {
      _notAvailableIndex = index;
    }
    if (isUpdate) {
      update();
    }
  }

  void updateCutlery({bool isUpdate = true}) {
    _addCutlery = !_addCutlery;
    if (isUpdate) {
      update();
    }
  }

  Future<void> forcefullySetModule(int moduleId) async {
    if (Get.find<SplashController>().module == null) {
      if (Get.find<SplashController>().moduleList != null) {
        for (ModuleModel module in Get.find<SplashController>().moduleList!) {
          if (module.id == moduleId) {
            await Get.find<SplashController>().setModule(module);
            HomeScreen.loadData(true);
            break;
          }
        }
      }
    }
  }

  // double calculationCart() {
  //   _addOnsList = [];
  //   _availableList = [];
  //   _itemPrice = 0;
  //   _itemDiscountPrice = 0;
  //   _addOns = 0;
  //   _variationPrice = 0;
  //   bool isFoodVariation = false;
  //   double variationWithoutDiscountPrice = 0;
  //   bool haveVariation = false;
  //   for (var cartModel in cartList) {
  //     // isFoodVariation = Get.find<SplashController>().getModuleConfig(cartModel.item!.moduleType).newVariation!;
  //     double? discount = cartModel.item!.storeDiscount == 0
  //         ? cartModel.item!.discount
  //         : cartModel.item!.storeDiscount;
  //     String? discountType = cartModel.item!.storeDiscount == 0
  //         ? cartModel.item!.discountType
  //         : 'percent';

  //     List<AddOns> addOnList = [];
  //     for (var addOnId in cartModel.addOnIds!) {
  //       for (AddOns addOns in cartModel.item!.addOns!) {
  //         if (addOns.id == addOnId.id) {
  //           addOnList.add(addOns);
  //           break;
  //         }
  //       }
  //     }
  //     _addOnsList.add(addOnList);

  //     _availableList.add(DateConverter.isAvailable(
  //         cartModel.item!.availableTimeStarts,
  //         cartModel.item!.availableTimeEnds));

  //     for (int index = 0; index < addOnList.length; index++) {
  //       _addOns = _addOns +
  //           (addOnList[index].price! * cartModel.addOnIds![index].quantity!);
  //     }

  //     if (isFoodVariation) {
  //       for (int index = 0;
  //           index < cartModel.item!.foodVariations!.length;
  //           index++) {
  //         for (int i = 0;
  //             i <
  //                 cartModel
  //                     .item!.foodVariations![index].variationValues!.length;
  //             i++) {
  //           if (cartModel.foodVariations![index][i]!) {
  //             _variationPrice += (PriceConverter.convertWithDiscount(
  //                     cartModel.item!.foodVariations![index].variationValues![i]
  //                         .optionPrice!,
  //                     discount,
  //                     discountType)! *
  //                 cartModel.quantity!);
  //           }
  //         }
  //       }
  //     } else {
  //       String variationType = '';
  //       for (int i = 0; i < cartModel.variation!.length; i++) {
  //         variationType = cartModel.variation![i].type!;
  //       }

  //       for (item_variation.Variation variation
  //           in cartModel.item!.variations!) {
  //         if (variation.type == variationType) {
  //           _variationPrice = (PriceConverter.convertWithDiscount(
  //                   variation.price!, discount, discountType)! *
  //               cartModel.quantity!);
  //           variationWithoutDiscountPrice =
  //               (variation.price! * cartModel.quantity!);
  //           haveVariation = true;
  //           break;
  //         }
  //       }
  //     }

  //     double price = haveVariation
  //         ? variationWithoutDiscountPrice
  //         : (cartModel.item!.price! * cartModel.quantity!);
  //     double discountPrice = haveVariation
  //         ? (variationWithoutDiscountPrice - _variationPrice)
  //         : (price -
  //             (PriceConverter.convertWithDiscount(
  //                     cartModel.item!.price!, discount, discountType)! *
  //                 cartModel.quantity!));

  //     _itemPrice = _itemPrice + price;
  //     _itemDiscountPrice = _itemDiscountPrice + discountPrice;

  //     haveVariation = false;
  //   }
  //   if (isFoodVariation) {
  //     _subTotal = (_itemPrice - _itemDiscountPrice) + _addOns + _variationPrice;
  //   } else {
  //     _subTotal = (_itemPrice - _itemDiscountPrice);
  //   }

  //   return _subTotal;
  // }

  void getCartData() {
    getCartDataOnline();
  }

  int? getCartId(int cartIndex) {
    if (cartIndex != -1) {
      return _cartList[cartIndex].id!;
    } else {
      return null;
    }
  }

  // void setQuantity(
  //     bool isIncrement, int cartIndex, int? stock, int? quantityLimit) {
  //   _isLoading = true;
  //   update();

  //   if (isIncrement) {
  //     if (Get.find<SplashController>()
  //             .configModel!
  //             .moduleConfig!
  //             .module!
  //             .stock! &&
  //         cartList[cartIndex].quantity! >= stock!) {
  //       showCustomSnackBar('out_of_stock'.tr);
  //     } else if (quantityLimit != null) {
  //       if (_cartList[cartIndex].quantity! >= quantityLimit &&
  //           quantityLimit != 0) {
  //         showCustomSnackBar('${'maximum_quantity_limit'.tr} $quantityLimit');
  //       } else {
  //         _cartList[cartIndex].quantity = _cartList[cartIndex].quantity! + 1;
  //       }
  //     } else {
  //       _cartList[cartIndex].quantity = _cartList[cartIndex].quantity! + 1;
  //     }
  //   } else {
  //     _cartList[cartIndex].quantity = _cartList[cartIndex].quantity! - 1;
  //   }
  //   // _cartList[cartIndex].isLoading = true;

  //   double discountedPrice = calculateDiscountedPrice(
  //       _cartList[cartIndex], _cartList[cartIndex].quantity!);
  //   // if(Get.find<SplashController>().getModuleConfig(_cartList[cartIndex].item!.moduleType).newVariation!) {
  //   //   Get.find<ItemController>().setExistInCart(_cartList[cartIndex].item, notify: true);
  //   // }

  //   updateCartQuantityOnline(_cartList[cartIndex].id!, discountedPrice,
  //       _cartList[cartIndex].quantity!);
  // }

  // double calculateDiscountedPrice(CartDataModel cartModel, int quantity) {
  //   double? discount = cartModel.item!.storeDiscount == 0
  //       ? cartModel.item!.discount
  //       : cartModel.item!.storeDiscount;
  //   String? discountType = cartModel.item!.storeDiscount == 0
  //       ? cartModel.item!.discountType
  //       : 'percent';
  //   double variationPrice = 0;
  //   double addonPrice = 0;

  //   // if(Get.find<SplashController>().getModuleConfig(cartModel.item!.moduleType).newVariation!) {
  //   //   for(int index = 0; index< cartModel.item!.foodVariations!.length; index++) {
  //   //     for(int i=0; i<cartModel.item!.foodVariations![index].variationValues!.length; i++) {
  //   //       if(cartModel.foodVariations![index][i]!) {
  //   //         variationPrice += (PriceConverter.convertWithDiscount(cartModel.item!.foodVariations![index].variationValues![i].optionPrice!, discount, discountType)! * cartModel.quantity!);
  //   //       }
  //   //     }
  //   //   }

  //   //   List<AddOns> addOnList = [];
  //   //   for (var addOnId in cartModel.addOnIds!) {
  //   //     for(AddOns addOns in cartModel.item!.addOns!) {
  //   //       if(addOns.id == addOnId.id) {
  //   //         addOnList.add(addOns);
  //   //         break;
  //   //       }
  //   //     }
  //   //   }
  //   //   for(int index=0; index<addOnList.length; index++) {
  //   //     addonPrice = addonPrice + (addOnList[index].price! * cartModel.addOnIds![index].quantity!);
  //   //   }
  //   // }
  //   double discountedPrice = addonPrice +
  //       variationPrice +
  //       (cartModel.item!.price! * quantity) -
  //       PriceConverter.calculation(
  //           cartModel.item!.price!, discount, discountType!, quantity);
  //   return discountedPrice;
  // }

  // void removeFromCart(int index, {Item? item}) {
  //   removeCartItemOnline(_cartList[index].id!, item: item);
  //   if (Get.find<ItemController>().item != null) {
  //     Get.find<ItemController>().cartIndexSet();
  //   }
  // }

  // void removeAddOn(int index, int addOnIndex) {
  //   _cartList[index];
  //   cartRepo.addToCartList(_cartList);
  //   // calculationCart();
  //   update();
  // }

  void clearCartList() {
    _cartList = [];
    if ((Get.find<AuthController>().isLoggedIn() || Get.find<AuthController>().isGuestLoggedIn()) && (Get.find<SplashController>().module != null || Get.find<SplashController>().cacheModule != null)) {
      clearCartOnline();
    }
  }

  int isExistInCart(int? itemID, String variationType, bool isUpdate, int? cartIndex) {
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].item!.id == itemID && _cartList[i].variation == variationType) {
        if (isUpdate) {
          // setQuantity(true, i, _cartList[i].item!.stock, _cartList[i].item!.quantityLimit);
        }
        return i;
      }
    }
    return -1;
  }

  // bool existAnotherStoreItem(int? storeID, int? moduleId) {
  //   for (CartModel cartModel in _cartList) {
  //     if (cartModel.item!.storeId != storeID &&
  //         cartModel.item!.moduleId == moduleId) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // void removeAllAndAddToCart(CartModel cartModel) async {
  //   _cartList = [];
  //   for (CartModel cartItem in cartRepo.getCartList()) {
  //     if (cartItem.item!.moduleId != cartModel.item!.moduleId) {
  //       _cartList.add(cartItem);
  //     }
  //   }
  //   _cartList.add(cartModel);
  //   await cartRepo.addToCartList(_cartList);
  //   getCartData();
  //   calculationCart();
  //   Get.find<ItemController>().setExistInCart(cartModel.item, notify: true);
  //   update();
  // }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }

  // Future<bool> addToCartOnline(OnlineCart cart) async {
  //   _isLoading = true;
  //   bool success = false;
  //   update();
  //   Response response = await cartRepo.addToCartOnline(cart);
  //   if (response.statusCode == 200) {
  //     _onlineCartList = [];
  //     _cartList = [];
  //     response.body.forEach(
  //         (cart) => _onlineCartList.add(OnlineCartModel.fromJson(cart)));
  //     _cartList.addAll(CartHelper.formatOnlineCartToLocalCart(
  //         onlineCartModel: _onlineCartList));
  //     calculationCart();
  //     success = true;
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   _isLoading = false;
  //   update();

  //   return success;
  // }

  // Future<bool> updateCartOnline(OnlineCart cart) async {
  //   _isLoading = true;
  //   bool success = false;
  //   update();
  //   Response response = await cartRepo.updateCartOnline(cart);
  //   if (response.statusCode == 200) {
  //     _onlineCartList = [];
  //     _cartList = [];
  //     response.body.forEach(
  //         (cart) => _onlineCartList.add(OnlineCartModel.fromJson(cart)));
  //     _cartList.addAll(CartHelper.formatOnlineCartToLocalCart(
  //         onlineCartModel: _onlineCartList));
  //     calculationCart();
  //     success = true;
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   _isLoading = false;
  //   update();

  //   return success;
  // }

  Future<void> updateCartQuantityOnline(int cartId, double price, int quantity) async {
    _isLoading = true;
    update();
    Response response = await cartRepo.updateCartQuantityOnline(cartId, quantity);
    if (response.statusCode == 200) {
      getCartDataOnline();
      // calculationCart();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> getCartDataOnline() async {
    if (Get.find<SplashController>().module != null || Get.find<SplashController>().cacheModule != null) {
      print('---------cart data call------');
      _isLoading = true;

      Response response = await cartRepo.getCartDataOnline();
      if (response.statusCode == 200) {
        _onlineCartList = [];
        _cartList = [];
        _subTotal = 0;
        response.body.forEach((cart) {
          print('cart data: $cart');
          final res = CartDataModel.fromJson(cart);

          _subTotal = _subTotal + res.price! * res.quantity!;

          _cartList.add(res);
        });

        print(_cartList.length);

        // _cartList.addAll(CartHelper.formatOnlineCartToLocalCart(
        //     onlineCartModel: _onlineCartList));
        // print('-------vvvvv->>>> $_cartList');
        // calculationCart();
      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
  }

  Future<bool> removeCartItemOnline(int cartIndex, {Item? item}) async {
    _isLoading = true;
    bool isSuccess = false;

    update();

    final cartId = _cartList[cartIndex].id!;
    _cartList.removeAt(cartIndex);

    Response response = await cartRepo.removeCartItemOnline(cartId, Get.find<AuthController>().isLoggedIn() ? null : Get.find<AuthController>().getGuestId());
    if (response.statusCode == 201) {
      isSuccess = true;

      getCartData();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<bool> clearCartOnline() async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response = await cartRepo.clearCartOnline();
    if (response.statusCode == 200) {
      isSuccess = true;
      getCartDataOnline();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  // int cartQuantity(int itemId) {
  //   int quantity = 0;
  //   for (CartModel cart in _cartList) {
  //     if (cart.item!.id == itemId) {
  //       quantity += cart.quantity!;
  //     }
  //   }
  //   return quantity;
  // }

  // String cartVariant(int itemId) {
  //   String variant = '';
  //   for (CartModel cart in _cartList) {
  //     if (cart.item!.id == itemId) {
  //       // if(!Get.find<SplashController>().getModuleConfig(cart.item!.moduleType).newVariation!) {
  //       //   variant = (cart.variation != null && cart.variation!.isNotEmpty) ? cart.variation![0].type! : '';
  //       // }
  //     }
  //   }
  //   return variant;
  // }

  Future<void> addToCart({required int quantity, required int productId, int? index, required String? variantType}) async {
    final Map<String, dynamic> body = {
      "product_id": productId,
      "quantity": quantity,
      "variant_type": variantType,
    };

    try {
      /// the product id is the id of the product that is being added to the cart

      _addingToCart = true;
      _isLoading = true;
      update();
      if (index != null) {
        _cartList[index].quantity = quantity;
        update();
      }

      final res = await cartRepo.addToCart(body: body);
      getCartData();

      print(res);
    } catch (e) {
      print(e);
    }

    _addingToCart = false;
    update();
  }

  int getItemQuantity({required var item}) {
    for (CartDataModel data in _cartList) {
      if (data.item!.id == item.id) {
        // print('items is found in cart');
        return data.quantity!;
      }
    }
    // print('items is not found in cart');

    return 0; // Return 0 if the item is not found
  }

  //by nirajan
  int newGetItemQuantity({required var itemId}) {
    for (CartDataModel data in _cartList) {
      if (data.item!.id == itemId) {
        // print('items is found in cart');
        return data.quantity!;
      }
    }
    // print('items is not found in cart');

    return 0; // Return 0 if the item is not found
  }
//

  Future<void> placeOrder({String? couponCode, required int deliveryAddressId}) async {
    try {
      final body = {"delivery_address_id": deliveryAddressId, "coupon_code": couponCode};

      final res = await cartRepo.placeOrder(body: body);

      if (res.statusCode == 200) {
        getCartData();

        showCustomSnackBar('Order placed successfully', isError: false);
        Get.back();
      } else {
        ApiChecker.checkApi(res);
      }
    } catch (e) {
      print(e);
    }
  }
}
