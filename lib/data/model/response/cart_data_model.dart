import 'dart:convert';

class CartDataModel {
    final int? id;
    final int? userId;
    final int? moduleId;
    final int? itemId;
    final bool? isGuest;
    final AddOnIds? addOnIds;
    final AddOnIds? addOnQtys;
    final ItemTypeEnum? itemType;
    final num? price;
     int? quantity;
    final String ? variation;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final CartItem? item;

    CartDataModel({
        this.id,
        this.userId,
        this.moduleId,
        this.itemId,
        this.isGuest,
        this.addOnIds,
        this.addOnQtys,
        this.itemType,
        this.price,
        this.quantity,
        this.variation,
        this.createdAt,
        this.updatedAt,
        this.item,
    });

    CartDataModel copyWith({
        int? id,
        int? userId,
        int? moduleId,
        int? itemId,
        bool? isGuest,
        AddOnIds? addOnIds,
        AddOnIds? addOnQtys,
        ItemTypeEnum? itemType,
        int? price,
        int? quantity,
        String? variation,
        DateTime? createdAt,
        DateTime? updatedAt,
        CartItem? item,
    }) => 
        CartDataModel(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            moduleId: moduleId ?? this.moduleId,
            itemId: itemId ?? this.itemId,
            isGuest: isGuest ?? this.isGuest,
            addOnIds: addOnIds ?? this.addOnIds,
            addOnQtys: addOnQtys ?? this.addOnQtys,
            itemType: itemType ?? this.itemType,
            price: price ?? this.price,
            quantity: quantity ?? this.quantity,
            variation: variation ?? this.variation,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            item: item ?? this.item,
        );

    factory CartDataModel.fromRawJson(String str) => CartDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartDataModel.fromJson(Map<String, dynamic> json) => CartDataModel(
        id: json["id"],
        userId: json["user_id"],
        moduleId: json["module_id"],
        itemId: json["item_id"],
        isGuest: json["is_guest"],
        addOnIds: addOnIdsValues.map[json["add_on_ids"]]!,
        addOnQtys: addOnIdsValues.map[json["add_on_qtys"]]!,
        itemType: itemTypeEnumValues.map[json["item_type"]]!,
        price: json["price"],
        quantity: json["quantity"],
        variation: json["variant_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        item: json["item"] == null ? null : CartItem.fromJson(json["item"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "module_id": moduleId,
        "item_id": itemId,
        "is_guest": isGuest,
        "add_on_ids": addOnIdsValues.reverse[addOnIds],
        "add_on_qtys": addOnIdsValues.reverse[addOnQtys],
        "item_type": itemTypeEnumValues.reverse[itemType],
        "price": price,
        "quantity": quantity,
        "variation": variation,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "item": item?.toJson(),
    };
}

enum AddOnIds {
    ADD_ON_IDS,
    EMPTY
}

final addOnIdsValues = EnumValues({
    "\"[]\"": AddOnIds.ADD_ON_IDS,
    "[]": AddOnIds.EMPTY
});

class CartItem {
    final int? id;
    final String? name;
    final String? description;
    final String? image;
    final int? categoryId;
    final int? costPrice;


    final String? sku;
    final String? variation;
    final AddOnIds? addOns;
   dynamic attributes;
    final String? choiceOptions;
    final int? price;
    final int? tax;
    final DiscountTypeEnum? taxType;
    final int? discount;
    final DiscountTypeEnum? discountType;
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
    final AddOnIds? foodVariations;
    final String? slug;
    final int? recommended;
    final int? organic;
    final int? maximumCartQuantity;
    final int? isApproved;
    final String? unitType;
    final List<Translation>? translations;
    final UnitClass? unit;

    CartItem({
        this.id,
        this.name,
        this.description,
        this.image,
        this.categoryId,
        this.costPrice,
       
        this.sku,
        this.variation,
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
        this.translations,
        this.unit,
    });

    CartItem copyWith({
        int? id,
        String? name,
        String? description,
        String? image,
        int? categoryId,
        int? costPrice,
        List<int>? categoryIds,
        dynamic brandId,
        String? sku,
        String? variations,
        AddOnIds? addOns,
     dynamic attributes,
        String? choiceOptions,
        int? price,
        int? tax,
        DiscountTypeEnum? taxType,
        int? discount,
        DiscountTypeEnum? discountType,
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
        AddOnIds? foodVariations,
        String? slug,
        int? recommended,
        int? organic,
        int? maximumCartQuantity,
        int? isApproved,
        String? unitType,
        List<Translation>? translations,
        UnitClass? unit,
    }) => 
        CartItem(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            image: image ?? this.image,
            categoryId: categoryId ?? this.categoryId,
            costPrice: costPrice ?? this.costPrice,
           
            sku: sku ?? this.sku,
            variation: variations ?? this.variation,
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
            translations: translations ?? this.translations,
            unit: unit ?? this.unit,
        );

    factory CartItem.fromRawJson(String str) => CartItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"]!,
        categoryId: json["category_id"],
        costPrice: json["cost_price"],
   
      
        sku: json["sku"],
        variation: json["variation_type"],
        addOns: addOnIdsValues.map[json["add_ons"]]!,
        attributes: json["attributes"]!,
        choiceOptions: json["choice_options"],
        price: json["price"],
        tax: json["tax"],
        taxType: discountTypeEnumValues.map[json["tax_type"]]!,
        discount: json["discount"],
        discountType: discountTypeEnumValues.map[json["discount_type"]]!,
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
        foodVariations: addOnIdsValues.map[json["food_variations"]]!,
        slug: json["slug"],
        recommended: json["recommended"],
        organic: json["organic"],
        maximumCartQuantity: json["maximum_cart_quantity"],
        isApproved: json["is_approved"],
        unitType:json["unit_type"],
        translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
        unit: json["unit"] == null ? null : UnitClass.fromJson(json["unit"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image":image,
        "category_id": categoryId,
        "cost_price": costPrice,
      
    
        "sku": sku,
        "variations": variation,
        "add_ons": addOnIdsValues.reverse[addOns],
        "attributes": attributes,
        "choice_options": choiceOptions,
        "price": price,
        "tax": tax,
        "tax_type": discountTypeEnumValues.reverse[taxType],
        "discount": discount,
        "discount_type": discountTypeEnumValues.reverse[discountType],
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
        "food_variations": addOnIdsValues.reverse[foodVariations],
        "slug": slug,
        "recommended": recommended,
        "organic": organic,
        "maximum_cart_quantity": maximumCartQuantity,
        "is_approved": isApproved,
        "unit_type": unitType,
        "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "unit": unit?.toJson(),
    };
}









enum DiscountTypeEnum {
    PERCENT
}

final discountTypeEnumValues = EnumValues({
    "percent": DiscountTypeEnum.PERCENT
});










class Translation {
    final int? id;
    final ItemTypeEnum? translationableType;
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
        ItemTypeEnum? translationableType,
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
        translationableType: itemTypeEnumValues.map[json["translationable_type"]]!,
        translationableId: json["translationable_id"],
        locale: localeValues.map[json["locale"]]!,
        key: keyValues.map[json["key"]]!,
        value: json["value"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "translationable_type": itemTypeEnumValues.reverse[translationableType],
        "translationable_id": translationableId,
        "locale": localeValues.reverse[locale],
        "key": keyValues.reverse[key],
        "value": value,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

enum Key {
    DESCRIPTION,
    NAME,
    UNIT
}

final keyValues = EnumValues({
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

enum ItemTypeEnum {
    APP_MODELS_ITEM,
    APP_MODELS_UNIT
}

final itemTypeEnumValues = EnumValues({
    "App\\Models\\Item": ItemTypeEnum.APP_MODELS_ITEM,
    "App\\Models\\Unit": ItemTypeEnum.APP_MODELS_UNIT
});

class UnitClass {
    final int? id;
    final String? unit;
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
        String? unit,
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
        unit: json["unit"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "unit": unit,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
    };
}




class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
