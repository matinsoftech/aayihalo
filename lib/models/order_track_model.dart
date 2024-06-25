class OrderTrackModel {
  OrderTrackModel({
    required this.id,
    required this.userId,
    required this.orderAmount,
    required this.couponDiscountAmount,
    required this.couponDiscountTitle,
    required this.paymentStatus,
    required this.orderStatus,
    required this.arrivedToCustomer,
    required this.totalTaxAmount,
    required this.paymentMethod,
    required this.transactionReference,
    required this.deliveryAddressId,
    required this.deliveryManId,
    required this.couponCode,
    required this.orderNote,
    required this.orderType,
    required this.checked,
    required this.storeId,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryCharge,
    required this.scheduleAt,
    required this.callback,
    required this.otp,
    required this.pending,
    required this.accepted,
    required this.acknowledged,
    required this.storeArrivalTime,
    required this.confirmed,
    required this.processing,
    required this.handover,
    required this.pickedUp,
    required this.customerArrivalTime,
    required this.delivered,
    required this.canceled,
    required this.refundRequested,
    required this.refunded,
    required this.deliveryAddress,
    required this.scheduled,
    required this.storeDiscountAmount,
    required this.originalDeliveryCharge,
    required this.failed,
    required this.adjusment,
    required this.edited,
    required this.deliveryTime,
    required this.zoneId,
    required this.moduleId,
    required this.orderAttachment,
    required this.parcelCategoryId,
    required this.receiverDetails,
    required this.chargePayer,
    required this.distance,
    required this.dmTips,
    required this.freeDeliveryBy,
    required this.refundRequestCanceled,
    required this.prescriptionOrder,
    required this.taxStatus,
    required this.dmVehicleId,
    required this.cancellationReason,
    required this.canceledBy,
    required this.couponCreatedBy,
    required this.discountOnProductBy,
    required this.processingTime,
    required this.unavailableItemNote,
    required this.cutlery,
    required this.deliveryInstruction,
    required this.taxPercentage,
    required this.additionalCharge,
    required this.orderProof,
    required this.partiallyPaidAmount,
    required this.isGuest,
    required this.flashAdminDiscountAmount,
    required this.flashStoreDiscountAmount,
    required this.merchantTxnId,
    required this.processId,
    required this.detailsCount,
    required this.store,
    required this.deliveryMan,
    required this.refundCancellationNote,
    required this.refundCustomerNote,
    required this.minDeliveryTime,
    required this.maxDeliveryTime,
    required this.offlinePayment,
    required this.customerAddress,
    required this.moduleType,
    required this.parcelCategory,
    required this.refund,
    required this.payments,
    required this.details,
    required this.module,
  });

  final int? id;
  final int? userId;
  final int? orderAmount;
  final int? couponDiscountAmount;
  final dynamic couponDiscountTitle;
  final String? paymentStatus;
  final String? orderStatus;
  final dynamic arrivedToCustomer;
  final int? totalTaxAmount;
  final String? paymentMethod;
  final dynamic transactionReference;
  final int? deliveryAddressId;
  final int? deliveryManId;
  final dynamic couponCode;
  final dynamic orderNote;
  final String? orderType;
  final int? checked;
  final int? storeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? deliveryCharge;
  final dynamic scheduleAt;
  final dynamic callback;
  final dynamic otp;
  final dynamic pending;
  final dynamic accepted;
  final dynamic acknowledged;
  final dynamic storeArrivalTime;
  final dynamic confirmed;
  final dynamic processing;
  final dynamic handover;
  final dynamic pickedUp;
  final dynamic customerArrivalTime;
  final dynamic delivered;
  final dynamic canceled;
  final dynamic refundRequested;
  final dynamic refunded;
  final dynamic deliveryAddress;
  final int? scheduled;
  final int? storeDiscountAmount;
  final int? originalDeliveryCharge;
  final dynamic failed;
  final String? adjusment;
  final int? edited;
  final dynamic deliveryTime;
  final dynamic zoneId;
  final int? moduleId;
  final dynamic orderAttachment;
  final dynamic parcelCategoryId;
  final dynamic receiverDetails;
  final dynamic chargePayer;
  final int? distance;
  final int? dmTips;
  final dynamic freeDeliveryBy;
  final dynamic refundRequestCanceled;
  final bool? prescriptionOrder;
  final dynamic taxStatus;
  final dynamic dmVehicleId;
  final dynamic cancellationReason;
  final dynamic canceledBy;
  final dynamic couponCreatedBy;
  final String? discountOnProductBy;
  final dynamic processingTime;
  final dynamic unavailableItemNote;
  final bool? cutlery;
  final dynamic deliveryInstruction;
  final dynamic taxPercentage;
  final int? additionalCharge;
  final dynamic orderProof;
  final int? partiallyPaidAmount;
  final bool? isGuest;
  final int? flashAdminDiscountAmount;
  final int? flashStoreDiscountAmount;
  final dynamic merchantTxnId;
  final dynamic processId;
  final int? detailsCount;
  final Store? store;
  final DeliveryMan? deliveryMan;
  final dynamic refundCancellationNote;
  final dynamic refundCustomerNote;
  final int? minDeliveryTime;
  final int? maxDeliveryTime;
  final dynamic offlinePayment;
  final dynamic customerAddress;
  final String? moduleType;
  final dynamic parcelCategory;
  final dynamic refund;
  final List<dynamic> payments;
  final List<Detail> details;
  final Module? module;

  factory OrderTrackModel.fromJson(Map<String, dynamic> json) {
    return OrderTrackModel(
      id: json["id"],
      userId: json["user_id"],
      orderAmount: json["order_amount"],
      couponDiscountAmount: json["coupon_discount_amount"],
      couponDiscountTitle: json["coupon_discount_title"],
      paymentStatus: json["payment_status"],
      orderStatus: json["order_status"],
      arrivedToCustomer: json["arrived_to_customer"],
      totalTaxAmount: json["total_tax_amount"],
      paymentMethod: json["payment_method"],
      transactionReference: json["transaction_reference"],
      deliveryAddressId: json["delivery_address_id"],
      deliveryManId: json["delivery_man_id"],
      couponCode: json["coupon_code"],
      orderNote: json["order_note"],
      orderType: json["order_type"],
      checked: json["checked"],
      storeId: json["store_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deliveryCharge: json["delivery_charge"],
      scheduleAt: json["schedule_at"],
      callback: json["callback"],
      otp: json["otp"],
      pending: json["pending"],
      accepted: json["accepted"],
      acknowledged: json["acknowledged"],
      storeArrivalTime: json["store_arrival_time"],
      confirmed: json["confirmed"],
      processing: json["processing"],
      handover: json["handover"],
      pickedUp: json["picked_up"],
      customerArrivalTime: json["customer_arrival_time"],
      delivered: json["delivered"],
      canceled: json["canceled"],
      refundRequested: json["refund_requested"],
      refunded: json["refunded"],
      deliveryAddress: json["delivery_address"],
      scheduled: json["scheduled"],
      storeDiscountAmount: json["store_discount_amount"],
      originalDeliveryCharge: json["original_delivery_charge"],
      failed: json["failed"],
      adjusment: json["adjusment"],
      edited: json["edited"],
      deliveryTime: json["delivery_time"],
      zoneId: json["zone_id"],
      moduleId: json["module_id"],
      orderAttachment: json["order_attachment"],
      parcelCategoryId: json["parcel_category_id"],
      receiverDetails: json["receiver_details"],
      chargePayer: json["charge_payer"],
      distance: json["distance"],
      dmTips: json["dm_tips"],
      freeDeliveryBy: json["free_delivery_by"],
      refundRequestCanceled: json["refund_request_canceled"],
      prescriptionOrder: json["prescription_order"],
      taxStatus: json["tax_status"],
      dmVehicleId: json["dm_vehicle_id"],
      cancellationReason: json["cancellation_reason"],
      canceledBy: json["canceled_by"],
      couponCreatedBy: json["coupon_created_by"],
      discountOnProductBy: json["discount_on_product_by"],
      processingTime: json["processing_time"],
      unavailableItemNote: json["unavailable_item_note"],
      cutlery: json["cutlery"],
      deliveryInstruction: json["delivery_instruction"],
      taxPercentage: json["tax_percentage"],
      additionalCharge: json["additional_charge"],
      orderProof: json["order_proof"],
      partiallyPaidAmount: json["partially_paid_amount"],
      isGuest: json["is_guest"],
      flashAdminDiscountAmount: json["flash_admin_discount_amount"],
      flashStoreDiscountAmount: json["flash_store_discount_amount"],
      merchantTxnId: json["merchant_txn_id"],
      processId: json["process_id"],
      detailsCount: json["details_count"],
      store: json["store"] == null ? null : Store.fromJson(json["store"]),
      deliveryMan: json["delivery_man"] == null ? null : DeliveryMan.fromJson(json["delivery_man"]),
      refundCancellationNote: json["refund_cancellation_note"],
      refundCustomerNote: json["refund_customer_note"],
      minDeliveryTime: json["min_delivery_time"],
      maxDeliveryTime: json["max_delivery_time"],
      offlinePayment: json["offline_payment"],
      customerAddress: json["customer_address"],
      moduleType: json["module_type"],
      parcelCategory: json["parcel_category"],
      refund: json["refund"],
      payments: json["payments"] == null ? [] : List<dynamic>.from(json["payments"]!.map((x) => x)),
      details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
      module: json["module"] == null ? null : Module.fromJson(json["module"]),
    );
  }
}

class DeliveryMan {
  DeliveryMan({
    required this.id,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.identityNumber,
    required this.identityType,
    required this.identityImage,
    required this.image,
    required this.fcmToken,
    required this.zoneId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.active,
    required this.earning,
    required this.currentOrders,
    required this.type,
    required this.storeId,
    required this.applicationStatus,
    required this.orderCount,
    required this.assignedOrderCount,
    required this.vehicleId,
    required this.avgRating,
    required this.ratingCount,
    required this.lat,
    required this.lng,
    required this.location,
  });

  final int? id;
  final String? fName;
  final String? lName;
  final String? phone;
  final String? email;
  final String? identityNumber;
  final String? identityType;
  final String? identityImage;
  final String? image;
  final String? fcmToken;
  final int? zoneId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? status;
  final int? active;
  final int? earning;
  final int? currentOrders;
  final String? type;
  final dynamic storeId;
  final String? applicationStatus;
  final int? orderCount;
  final int? assignedOrderCount;
  final int? vehicleId;
  final int? avgRating;
  final int? ratingCount;
  final String? lat;
  final String? lng;
  final String? location;

  factory DeliveryMan.fromJson(Map<String, dynamic> json) {
    return DeliveryMan(
      id: json["id"],
      fName: json["f_name"],
      lName: json["l_name"],
      phone: json["phone"],
      email: json["email"],
      identityNumber: json["identity_number"],
      identityType: json["identity_type"],
      identityImage: json["identity_image"],
      image: json["image"],
      fcmToken: json["fcm_token"],
      zoneId: json["zone_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      status: json["status"],
      active: json["active"],
      earning: json["earning"],
      currentOrders: json["current_orders"],
      type: json["type"],
      storeId: json["store_id"],
      applicationStatus: json["application_status"],
      orderCount: json["order_count"],
      assignedOrderCount: json["assigned_order_count"],
      vehicleId: json["vehicle_id"],
      avgRating: json["avg_rating"],
      ratingCount: json["rating_count"],
      lat: json["lat"],
      lng: json["lng"],
      location: json["location"],
    );
  }
}

class Detail {
  Detail({
    required this.id,
    required this.itemId,
    required this.orderId,
    required this.price,
    required this.itemDetails,
    required this.variation,
    required this.addOns,
    required this.discountOnItem,
    required this.discountType,
    required this.quantity,
    required this.taxAmount,
    required this.variant,
    required this.createdAt,
    required this.updatedAt,
    required this.itemCampaignId,
    required this.totalAddOnPrice,
  });

  final int? id;
  final int? itemId;
  final int? orderId;
  final int? price;
  final String? itemDetails;
  final String? variation;
  final String? addOns;
  final int? discountOnItem;
  final String? discountType;
  final int? quantity;
  final int? taxAmount;
  final String? variant;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic itemCampaignId;
  final int? totalAddOnPrice;

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json["id"],
      itemId: json["item_id"],
      orderId: json["order_id"],
      price: json["price"],
      itemDetails: json["item_details"],
      variation: json["variation"],
      addOns: json["add_ons"],
      discountOnItem: json["discount_on_item"],
      discountType: json["discount_type"],
      quantity: json["quantity"],
      taxAmount: json["tax_amount"],
      variant: json["variant"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      itemCampaignId: json["item_campaign_id"],
      totalAddOnPrice: json["total_add_on_price"],
    );
  }
}

class Module {
  Module({
    required this.id,
    required this.moduleName,
    required this.moduleType,
    required this.thumbnail,
    required this.status,
    required this.storesCount,
    required this.createdAt,
    required this.updatedAt,
    required this.icon,
    required this.themeId,
    required this.description,
    required this.allZoneService,
    required this.translations,
  });

  final int? id;
  final String? moduleName;
  final String? moduleType;
  final String? thumbnail;
  final String? status;
  final int? storesCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? icon;
  final int? themeId;
  final String? description;
  final int? allZoneService;
  final List<Translation> translations;

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json["id"],
      moduleName: json["module_name"],
      moduleType: json["module_type"],
      thumbnail: json["thumbnail"],
      status: json["status"],
      storesCount: json["stores_count"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      icon: json["icon"],
      themeId: json["theme_id"],
      description: json["description"],
      allZoneService: json["all_zone_service"],
      translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
    );
  }
}

class Translation {
  Translation({
    required this.id,
    required this.translationableType,
    required this.translationableId,
    required this.locale,
    required this.key,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? translationableType;
  final int? translationableId;
  final String? locale;
  final String? key;
  final String? value;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      id: json["id"],
      translationableType: json["translationable_type"],
      translationableId: json["translationable_id"],
      locale: json["locale"],
      key: json["key"],
      value: json["value"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }
}

class Store {
  Store({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.logo,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.footerText,
    required this.minimumOrder,
    required this.comission,
    required this.scheduleOrder,
    required this.status,
    required this.vendorId,
    required this.createdAt,
    required this.updatedAt,
    required this.freeDelivery,
    required this.rating,
    required this.coverPhoto,
    required this.delivery,
    required this.takeAway,
    required this.itemSection,
    required this.tax,
    required this.zoneId,
    required this.reviewsSection,
    required this.active,
    required this.offDay,
    required this.selfDeliverySystem,
    required this.posSystem,
    required this.minimumShippingCharge,
    required this.deliveryTime,
    required this.veg,
    required this.nonVeg,
    required this.orderCount,
    required this.totalOrder,
    required this.moduleId,
    required this.orderPlaceToScheduleInterval,
    required this.featured,
    required this.perKmShippingCharge,
    required this.prescriptionOrder,
    required this.slug,
    required this.maximumShippingCharge,
    required this.cutlery,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaImage,
    required this.announcement,
    required this.announcementMessage,
    required this.gstStatus,
    required this.gstCode,
    required this.translations,
  });

  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? logo;
  final String? latitude;
  final String? longitude;
  final dynamic address;
  final dynamic footerText;
  final int? minimumOrder;
  final dynamic comission;
  final bool? scheduleOrder;
  final int? status;
  final int? vendorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? freeDelivery;
  final List<int> rating;
  final String? coverPhoto;
  final bool? delivery;
  final bool? takeAway;
  final bool? itemSection;
  final int? tax;
  final int? zoneId;
  final bool? reviewsSection;
  final bool? active;
  final String? offDay;
  final int? selfDeliverySystem;
  final bool? posSystem;
  final int? minimumShippingCharge;
  final String? deliveryTime;
  final int? veg;
  final int? nonVeg;
  final int? orderCount;
  final int? totalOrder;
  final int? moduleId;
  final int? orderPlaceToScheduleInterval;
  final int? featured;
  final int? perKmShippingCharge;
  final bool? prescriptionOrder;
  final String? slug;
  final dynamic maximumShippingCharge;
  final bool? cutlery;
  final dynamic metaTitle;
  final dynamic metaDescription;
  final dynamic metaImage;
  final int? announcement;
  final dynamic announcementMessage;
  final bool? gstStatus;
  final String? gstCode;
  final List<Translation> translations;

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      logo: json["logo"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      address: json["address"],
      footerText: json["footer_text"],
      minimumOrder: json["minimum_order"],
      comission: json["comission"],
      scheduleOrder: json["schedule_order"],
      status: json["status"],
      vendorId: json["vendor_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      freeDelivery: json["free_delivery"],
      rating: json["rating"] == null ? [] : List<int>.from(json["rating"]!.map((x) => x)),
      coverPhoto: json["cover_photo"],
      delivery: json["delivery"],
      takeAway: json["take_away"],
      itemSection: json["item_section"],
      tax: json["tax"],
      zoneId: json["zone_id"],
      reviewsSection: json["reviews_section"],
      active: json["active"],
      offDay: json["off_day"],
      selfDeliverySystem: json["self_delivery_system"],
      posSystem: json["pos_system"],
      minimumShippingCharge: json["minimum_shipping_charge"],
      deliveryTime: json["delivery_time"],
      veg: json["veg"],
      nonVeg: json["non_veg"],
      orderCount: json["order_count"],
      totalOrder: json["total_order"],
      moduleId: json["module_id"],
      orderPlaceToScheduleInterval: json["order_place_to_schedule_interval"],
      featured: json["featured"],
      perKmShippingCharge: json["per_km_shipping_charge"],
      prescriptionOrder: json["prescription_order"],
      slug: json["slug"],
      maximumShippingCharge: json["maximum_shipping_charge"],
      cutlery: json["cutlery"],
      metaTitle: json["meta_title"],
      metaDescription: json["meta_description"],
      metaImage: json["meta_image"],
      announcement: json["announcement"],
      announcementMessage: json["announcement_message"],
      gstStatus: json["gst_status"],
      gstCode: json["gst_code"],
      translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
    );
  }
}
