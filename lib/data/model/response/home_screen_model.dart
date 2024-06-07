import 'dart:convert';


class HomeScreenDataModel {
    final NearestStore? nearestStore;
    final String? roadDistance;
    final int? deliveryTime;
    final List<StoreCollection>? storeCollections;

    HomeScreenDataModel({
        this.nearestStore,
        this.roadDistance,
        this.deliveryTime,
        this.storeCollections,
    });

    HomeScreenDataModel copyWith({
        NearestStore? nearestStore,
        String? roadDistance,
        int? deliveryTime,
        List<StoreCollection>? storeCollections,
    }) => 
        HomeScreenDataModel(
            nearestStore: nearestStore ?? this.nearestStore,
            roadDistance: roadDistance ?? this.roadDistance,
            deliveryTime: deliveryTime ?? this.deliveryTime,
            storeCollections: storeCollections ?? this.storeCollections,
        );

    factory HomeScreenDataModel.fromRawJson(String str) => HomeScreenDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HomeScreenDataModel.fromJson(Map<String, dynamic> json) => HomeScreenDataModel(
        nearestStore: json["nearest_store"] == null ? null : NearestStore.fromJson(json["nearest_store"]),
        roadDistance: json["road_distance"],
        deliveryTime: json["delivery_time"],
        storeCollections: json["store_collections"] == null ? [] : List<StoreCollection>.from(json["store_collections"]!.map((x) => StoreCollection.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nearest_store": nearestStore?.toJson(),
        "road_distance": roadDistance,
        "delivery_time": deliveryTime,
        "store_collections": storeCollections == null ? [] : List<dynamic>.from(storeCollections!.map((x) => x.toJson())),
    };
}

class NearestStore {
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
    final List<int>? rating;
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
    final String? roadDistance;
    final bool? gstStatus;
    final String? gstCode;
    final List<Translation>? translations;

    NearestStore({
        this.id,
        this.name,
        this.phone,
        this.email,
        this.logo,
        this.latitude,
        this.longitude,
        this.address,
        this.footerText,
        this.minimumOrder,
        this.comission,
        this.scheduleOrder,
        this.status,
        this.vendorId,
        this.createdAt,
        this.updatedAt,
        this.freeDelivery,
        this.rating,
        this.coverPhoto,
        this.delivery,
        this.takeAway,
        this.itemSection,
        this.tax,
        this.zoneId,
        this.reviewsSection,
        this.active,
        this.offDay,
        this.selfDeliverySystem,
        this.posSystem,
        this.minimumShippingCharge,
        this.deliveryTime,
        this.veg,
        this.nonVeg,
        this.orderCount,
        this.totalOrder,
        this.moduleId,
        this.orderPlaceToScheduleInterval,
        this.featured,
        this.perKmShippingCharge,
        this.prescriptionOrder,
        this.slug,
        this.maximumShippingCharge,
        this.cutlery,
        this.metaTitle,
        this.metaDescription,
        this.metaImage,
        this.announcement,
        this.announcementMessage,
        this.roadDistance,
        this.gstStatus,
        this.gstCode,
        this.translations,
    });

    NearestStore copyWith({
        int? id,
        String? name,
        String? phone,
        String? email,
        String? logo,
        String? latitude,
        String? longitude,
        dynamic address,
        dynamic footerText,
        int? minimumOrder,
        dynamic comission,
        bool? scheduleOrder,
        int? status,
        int? vendorId,
        DateTime? createdAt,
        DateTime? updatedAt,
        bool? freeDelivery,
        List<int>? rating,
        String? coverPhoto,
        bool? delivery,
        bool? takeAway,
        bool? itemSection,
        int? tax,
        int? zoneId,
        bool? reviewsSection,
        bool? active,
        String? offDay,
        int? selfDeliverySystem,
        bool? posSystem,
        int? minimumShippingCharge,
        String? deliveryTime,
        int? veg,
        int? nonVeg,
        int? orderCount,
        int? totalOrder,
        int? moduleId,
        int? orderPlaceToScheduleInterval,
        int? featured,
        int? perKmShippingCharge,
        bool? prescriptionOrder,
        String? slug,
        dynamic maximumShippingCharge,
        bool? cutlery,
        dynamic metaTitle,
        dynamic metaDescription,
        dynamic metaImage,
        int? announcement,
        dynamic announcementMessage,
        String? roadDistance,
        bool? gstStatus,
        String? gstCode,
        List<Translation>? translations,
    }) => 
        NearestStore(
            id: id ?? this.id,
            name: name ?? this.name,
            phone: phone ?? this.phone,
            email: email ?? this.email,
            logo: logo ?? this.logo,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
            address: address ?? this.address,
            footerText: footerText ?? this.footerText,
            minimumOrder: minimumOrder ?? this.minimumOrder,
            comission: comission ?? this.comission,
            scheduleOrder: scheduleOrder ?? this.scheduleOrder,
            status: status ?? this.status,
            vendorId: vendorId ?? this.vendorId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            freeDelivery: freeDelivery ?? this.freeDelivery,
            rating: rating ?? this.rating,
            coverPhoto: coverPhoto ?? this.coverPhoto,
            delivery: delivery ?? this.delivery,
            takeAway: takeAway ?? this.takeAway,
            itemSection: itemSection ?? this.itemSection,
            tax: tax ?? this.tax,
            zoneId: zoneId ?? this.zoneId,
            reviewsSection: reviewsSection ?? this.reviewsSection,
            active: active ?? this.active,
            offDay: offDay ?? this.offDay,
            selfDeliverySystem: selfDeliverySystem ?? this.selfDeliverySystem,
            posSystem: posSystem ?? this.posSystem,
            minimumShippingCharge: minimumShippingCharge ?? this.minimumShippingCharge,
            deliveryTime: deliveryTime ?? this.deliveryTime,
            veg: veg ?? this.veg,
            nonVeg: nonVeg ?? this.nonVeg,
            orderCount: orderCount ?? this.orderCount,
            totalOrder: totalOrder ?? this.totalOrder,
            moduleId: moduleId ?? this.moduleId,
            orderPlaceToScheduleInterval: orderPlaceToScheduleInterval ?? this.orderPlaceToScheduleInterval,
            featured: featured ?? this.featured,
            perKmShippingCharge: perKmShippingCharge ?? this.perKmShippingCharge,
            prescriptionOrder: prescriptionOrder ?? this.prescriptionOrder,
            slug: slug ?? this.slug,
            maximumShippingCharge: maximumShippingCharge ?? this.maximumShippingCharge,
            cutlery: cutlery ?? this.cutlery,
            metaTitle: metaTitle ?? this.metaTitle,
            metaDescription: metaDescription ?? this.metaDescription,
            metaImage: metaImage ?? this.metaImage,
            announcement: announcement ?? this.announcement,
            announcementMessage: announcementMessage ?? this.announcementMessage,
            roadDistance: roadDistance ?? this.roadDistance,
            gstStatus: gstStatus ?? this.gstStatus,
            gstCode: gstCode ?? this.gstCode,
            translations: translations ?? this.translations,
        );

    factory NearestStore.fromRawJson(String str) => NearestStore.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NearestStore.fromJson(Map<String, dynamic> json) => NearestStore(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
        roadDistance: json["road_distance"],
        gstStatus: json["gst_status"],
        gstCode: json["gst_code"],
        translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "logo": logo,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "footer_text": footerText,
        "minimum_order": minimumOrder,
        "comission": comission,
        "schedule_order": scheduleOrder,
        "status": status,
        "vendor_id": vendorId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "free_delivery": freeDelivery,
        "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x)),
        "cover_photo": coverPhoto,
        "delivery": delivery,
        "take_away": takeAway,
        "item_section": itemSection,
        "tax": tax,
        "zone_id": zoneId,
        "reviews_section": reviewsSection,
        "active": active,
        "off_day": offDay,
        "self_delivery_system": selfDeliverySystem,
        "pos_system": posSystem,
        "minimum_shipping_charge": minimumShippingCharge,
        "delivery_time": deliveryTime,
        "veg": veg,
        "non_veg": nonVeg,
        "order_count": orderCount,
        "total_order": totalOrder,
        "module_id": moduleId,
        "order_place_to_schedule_interval": orderPlaceToScheduleInterval,
        "featured": featured,
        "per_km_shipping_charge": perKmShippingCharge,
        "prescription_order": prescriptionOrder,
        "slug": slug,
        "maximum_shipping_charge": maximumShippingCharge,
        "cutlery": cutlery,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_image": metaImage,
        "announcement": announcement,
        "announcement_message": announcementMessage,
        "road_distance": roadDistance,
        "gst_status": gstStatus,
        "gst_code": gstCode,
        "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
    };
}

class Translation {
    final int? id;
    final TranslationableType? translationableType;
    final int? translationableId;
    final Locale? locale;
    final Key? key;
    final String? value;
    final dynamic createdAt;
    final dynamic updatedAt;

    Translation({
        this.id,
        this.translationableType,
        this.translationableId,
        this.locale,
        this.key,
        this.value,
        this.createdAt,
        this.updatedAt,
    });

    Translation copyWith({
        int? id,
        TranslationableType? translationableType,
        int? translationableId,
        Locale? locale,
        Key? key,
        String? value,
        dynamic createdAt,
        dynamic updatedAt,
    }) => 
        Translation(
            id: id ?? this.id,
            translationableType: translationableType ?? this.translationableType,
            translationableId: translationableId ?? this.translationableId,
            locale: locale ?? this.locale,
            key: key ?? this.key,
            value: value ?? this.value,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Translation.fromRawJson(String str) => Translation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        translationableType: translationableTypeValues.map[json["translationable_type"]]!,
        translationableId: json["translationable_id"],
        locale: localeValues.map[json["locale"]]!,
        key: keyValues.map[json["key"]]!,
        value: json["value"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "translationable_type": translationableTypeValues.reverse[translationableType],
        "translationable_id": translationableId,
        "locale": localeValues.reverse[locale],
        "key": keyValues.reverse[key],
        "value": value,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

enum Key {
    ADDRESS,
    DESCRIPTION,
    NAME,
    UNIT
}

final keyValues = EnumValues({
    "address": Key.ADDRESS,
    "description": Key.DESCRIPTION,
    "name": Key.NAME,
    "unit": Key.UNIT
});

enum Locale {
    EN
}

final localeValues = EnumValues({
    "en": Locale.EN
});

enum TranslationableType {
    APP_MODELS_ITEM,
    APP_MODELS_STORE,
    APP_MODELS_UNIT
}

final translationableTypeValues = EnumValues({
    "App\\Models\\Item": TranslationableType.APP_MODELS_ITEM,
    "App\\Models\\Store": TranslationableType.APP_MODELS_STORE,
    "App\\Models\\Unit": TranslationableType.APP_MODELS_UNIT
});

class StoreCollection {
    final int? id;
    final int? storeId;
    final String? name;
    final String? slug;
    final int? sortOrder;
    final String? image;
    final String? description;
    final String? metaTitle;
    final String? metaDescription;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Product>? products;

    StoreCollection({
        this.id,
        this.storeId,
        this.name,
        this.slug,
        this.sortOrder,
        this.image,
        this.description,
        this.metaTitle,
        this.metaDescription,
        this.createdAt,
        this.updatedAt,
        this.products,
    });

    StoreCollection copyWith({
        int? id,
        int? storeId,
        String? name,
        String? slug,
        int? sortOrder,
        String? image,
        String? description,
        String? metaTitle,
        String? metaDescription,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<Product>? products,
    }) => 
        StoreCollection(
            id: id ?? this.id,
            storeId: storeId ?? this.storeId,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            sortOrder: sortOrder ?? this.sortOrder,
            image: image ?? this.image,
            description: description ?? this.description,
            metaTitle: metaTitle ?? this.metaTitle,
            metaDescription: metaDescription ?? this.metaDescription,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            products: products ?? this.products,
        );

    factory StoreCollection.fromRawJson(String str) => StoreCollection.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StoreCollection.fromJson(Map<String, dynamic> json) => StoreCollection(
        id: json["id"],
        storeId: json["store_id"],
        name: json["name"],
        slug: json["slug"],
        sortOrder: json["sort_order"],
        image: json["image"],
        description: json["description"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "name": name,
        "slug": slug,
        "sort_order": sortOrder,
        "image": image,
        "description": description,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    };
}

class Product {
    final int? id;
    final String? name;
    final String? description;
    final String? image;
    final int? categoryId;
    final String? categoryIds;
    final String? variations;
    final AddOns? addOns;
    final AddOns? attributes;
    final ChoiceOptions? choiceOptions;
    final double? price;
    final int? tax;
    final Type? taxType;
    final int? discount;
    final Type? discountType;
    final String? availableTimeStarts;
    final String? availableTimeEnds;
    final int? veg;
    final int? status;
    final int? storeId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? orderCount;
    final int? avgRating;
    final int? ratingCount;
    final String? rating;
    final int? moduleId;
    final int? stock;
    final int? unitId;
    final List<String>? images;
    final AddOns? foodVariations;
    final String? slug;
    final int? recommended;
    final int? organic;
    final int? maximumCartQuantity;
    final int? isApproved;
    final UnitTypeEnum? unitType;
    final Pivot? pivot;
    final List<Translation>? translations;
    final UnitClass? unit;

    Product({
        this.id,
        this.name,
        this.description,
        this.image,
        this.categoryId,
        this.categoryIds,
        this.variations,
        this.addOns,
        this.attributes,
        this.choiceOptions,
        this.price,
        this.tax,
        this.taxType,
        this.discount,
        this.discountType,
        this.availableTimeStarts,
        this.availableTimeEnds,
        this.veg,
        this.status,
        this.storeId,
        this.createdAt,
        this.updatedAt,
        this.orderCount,
        this.avgRating,
        this.ratingCount,
        this.rating,
        this.moduleId,
        this.stock,
        this.unitId,
        this.images,
        this.foodVariations,
        this.slug,
        this.recommended,
        this.organic,
        this.maximumCartQuantity,
        this.isApproved,
        this.unitType,
        this.pivot,
        this.translations,
        this.unit,
    });

    Product copyWith({
        int? id,
        String? name,
        String? description,
        String? image,
        int? categoryId,
        String? categoryIds,
        String? variations,
        AddOns? addOns,
        AddOns? attributes,
        ChoiceOptions? choiceOptions,
        double? price,
        int? tax,
        Type? taxType,
        int? discount,
        Type? discountType,
        String? availableTimeStarts,
        String? availableTimeEnds,
        int? veg,
        int? status,
        int? storeId,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? orderCount,
        int? avgRating,
        int? ratingCount,
        String? rating,
        int? moduleId,
        int? stock,
        int? unitId,
        List<String>? images,
        AddOns? foodVariations,
        String? slug,
        int? recommended,
        int? organic,
        int? maximumCartQuantity,
        int? isApproved,
        UnitTypeEnum? unitType,
        Pivot? pivot,
        List<Translation>? translations,
        UnitClass? unit,
    }) => 
        Product(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            image: image ?? this.image,
            categoryId: categoryId ?? this.categoryId,
            categoryIds: categoryIds ?? this.categoryIds,
            variations: variations ?? this.variations,
            addOns: addOns ?? this.addOns,
            attributes: attributes ?? this.attributes,
            choiceOptions: choiceOptions ?? this.choiceOptions,
            price: price ?? this.price,
            tax: tax ?? this.tax,
            taxType: taxType ?? this.taxType,
            discount: discount ?? this.discount,
            discountType: discountType ?? this.discountType,
            availableTimeStarts: availableTimeStarts ?? this.availableTimeStarts,
            availableTimeEnds: availableTimeEnds ?? this.availableTimeEnds,
            veg: veg ?? this.veg,
            status: status ?? this.status,
            storeId: storeId ?? this.storeId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            orderCount: orderCount ?? this.orderCount,
            avgRating: avgRating ?? this.avgRating,
            ratingCount: ratingCount ?? this.ratingCount,
            rating: rating ?? this.rating,
            moduleId: moduleId ?? this.moduleId,
            stock: stock ?? this.stock,
            unitId: unitId ?? this.unitId,
            images: images ?? this.images,
            foodVariations: foodVariations ?? this.foodVariations,
            slug: slug ?? this.slug,
            recommended: recommended ?? this.recommended,
            organic: organic ?? this.organic,
            maximumCartQuantity: maximumCartQuantity ?? this.maximumCartQuantity,
            isApproved: isApproved ?? this.isApproved,
            unitType: unitType ?? this.unitType,
            pivot: pivot ?? this.pivot,
            translations: translations ?? this.translations,
            unit: unit ?? this.unit,
        );

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        categoryId: json["category_id"],
        categoryIds: json["category_ids"],
        variations: json["variations"],
        addOns: addOnsValues.map[json["add_ons"]]!,
        attributes: addOnsValues.map[json["attributes"]],
        choiceOptions: choiceOptionsValues.map[json["choice_options"]],
        price: double.parse(json["price"].toString()),
        tax: json["tax"],
        taxType: typeValues.map[json["tax_type"]],
        discount: json["discount"],
        discountType: typeValues.map[json["discount_type"]],
        availableTimeStarts: json["available_time_starts"],
        availableTimeEnds: json["available_time_ends"],
        veg: json["veg"],
        status: json["status"],
        storeId: json["store_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        orderCount: json["order_count"],
        avgRating: json["avg_rating"],
        ratingCount: json["rating_count"],
        rating: json["rating"],
        moduleId: json["module_id"],
        stock: json["stock"],
        unitId: json["unit_id"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        foodVariations: addOnsValues.map[json["food_variations"]]!,
        slug: json["slug"],
        recommended: json["recommended"],
        organic: json["organic"],
        maximumCartQuantity: json["maximum_cart_quantity"],
        isApproved: json["is_approved"],
        unitType:json["unit_type"] ==null ? null :  unitTypeEnumValues.map[json["unit_type"]],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
        unit: json["unit"] == null ? null : UnitClass.fromJson(json["unit"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "category_id": categoryId,
        "category_ids": categoryIds,
        "variations": variations,
        "add_ons": addOnsValues.reverse[addOns],
        "attributes": addOnsValues.reverse[attributes],
        "choice_options": choiceOptionsValues.reverse[choiceOptions],
        "price": price,
        "tax": tax,
        "tax_type": typeValues.reverse[taxType],
        "discount": discount,
        "discount_type": typeValues.reverse[discountType],
        "available_time_starts": availableTimeStarts,
        "available_time_ends": availableTimeEnds,
        "veg": veg,
        "status": status,
        "store_id": storeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order_count": orderCount,
        "avg_rating": avgRating,
        "rating_count": ratingCount,
        "rating": rating,
        "module_id": moduleId,
        "stock": stock,
        "unit_id": unitId,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "food_variations": addOnsValues.reverse[foodVariations],
        "slug": slug,
        "recommended": recommended,
        "organic": organic,
        "maximum_cart_quantity": maximumCartQuantity,
        "is_approved": isApproved,
        "unit_type": unitTypeEnumValues.reverse[unitType],
        "pivot": pivot?.toJson(),
        "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "unit": unit?.toJson(),
    };


    // Item toItem() { 
    //   return  Item(
    //     id: id,
    //     name: name,
    //     description: description,
    //     image: image,
    //     categoryId: categoryId
    //   );
    // }
}

enum AddOns {
    EMPTY,
    THE_1
}

final addOnsValues = EnumValues({
    "[]": AddOns.EMPTY,
    "[\"1\"]": AddOns.THE_1
});

enum ChoiceOptions {
    EMPTY,
    NAME_CHOICE_1_TITLE_SIZE_OPTIONS_500_ML_750_ML
}

final choiceOptionsValues = EnumValues({
    "[]": ChoiceOptions.EMPTY,
    "[{\"name\":\"choice_1\",\"title\":\"Size\",\"options\":[\"500ml\",\"750ml\"]}]": ChoiceOptions.NAME_CHOICE_1_TITLE_SIZE_OPTIONS_500_ML_750_ML
});

enum Type {
    PERCENT
}

final typeValues = EnumValues({
    "percent": Type.PERCENT
});

class Pivot {
    final int? storeCollectionId;
    final int? itemId;

    Pivot({
        this.storeCollectionId,
        this.itemId,
    });

    Pivot copyWith({
        int? storeCollectionId,
        int? itemId,
    }) => 
        Pivot(
            storeCollectionId: storeCollectionId ?? this.storeCollectionId,
            itemId: itemId ?? this.itemId,
        );

    factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        storeCollectionId: json["store_collection_id"],
        itemId: json["item_id"],
    );

    Map<String, dynamic> toJson() => {
        "store_collection_id": storeCollectionId,
        "item_id": itemId,
    };
}

class UnitClass {
    final int? id;
    final UnitTypeEnum? unit;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Translation>? translations;

    UnitClass({
        this.id,
        this.unit,
        this.createdAt,
        this.updatedAt,
        this.translations,
    });

    UnitClass copyWith({
        int? id,
        UnitTypeEnum? unit,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<Translation>? translations,
    }) => 
        UnitClass(
            id: id ?? this.id,
            unit: unit ?? this.unit,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            translations: translations ?? this.translations,
        );

    factory UnitClass.fromRawJson(String str) => UnitClass.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UnitClass.fromJson(Map<String, dynamic> json) => UnitClass(
        id: json["id"],
        unit: unitTypeEnumValues.map[json["unit"]],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "unit": unitTypeEnumValues.reverse[unit],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
    };
}

enum UnitTypeEnum {
    BOTTLE,
    PCS
}

final unitTypeEnumValues = EnumValues({
    "Bottle": UnitTypeEnum.BOTTLE,
    "Pcs": UnitTypeEnum.PCS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
