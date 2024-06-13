import 'dart:convert';

import 'package:get/get.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/basic_medicine_model.dart';

class ItemModel {
  int? totalSize;
  String? limit;
  int? offset;
  List<Item>? items;
  List<Categories>? categories;

  ItemModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.items,
    this.categories,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'].toString();
    offset = (json['offset'] != null && json['offset'].toString().trim().isNotEmpty) ? int.parse(json['offset'].toString()) : null;
    if (json['products'] != null) {
      items = [];
      json['products'].forEach((v) {
        if (v['module_type'] == null || !Get.find<SplashController>().getModuleConfig(v['module_type']).newVariation! || v['variations'] == null || v['variations'].isEmpty || (v['food_variations'] != null && v['food_variations'].isNotEmpty)) {
          items!.add(Item.fromJson(v));
        }
      });
    }
    if (json['items'] != null) {
      items = [];
      json['items'].forEach(
        (v) {
          if (v['module_type'] == null || !Get.find<SplashController>().getModuleConfig(v['module_type']).newVariation! || v['variations'] == null || v['variations'].isEmpty || (v['food_variations'] != null && v['food_variations'].isNotEmpty)) {
            items!.add(
              Item.fromJson(v),
            );
          }
        },
      );
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (items != null) {
      data['products'] = items!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  int? id;
  String? name;
  String? description;
  String? image;
  List<String>? images;
  int? categoryId;
  List<CategoryIds>? categoryIds;
  List<Variation>? variations;
  List<FoodVariation>? foodVariations;
  List<AddOns>? addOns;
  List<ChoiceOptions>? choiceOptions;
  double? price;
  double? tax;
  double? discount;
  String? discountType;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? storeId;
  String? storeName;
  int? zoneId;
  double? storeDiscount;
  bool? scheduleOrder;
  double? avgRating;
  int? ratingCount;
  int? veg;
  int? moduleId;
  String? moduleType;
  String? unitType;
  int? stock;
  String? availableDateStarts;
  int? organic;
  int? quantityLimit;
  int? flashSale;
  List<CategoryProduct>? categoryProducts;

  Item({
    this.id,
    this.name,
    this.description,
    this.image,
    this.images,
    this.categoryId,
    this.categoryIds,
    this.variations,
    this.foodVariations,
    this.addOns,
    this.choiceOptions,
    this.price,
    this.tax,
    this.discount,
    this.discountType,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.storeId,
    this.storeName,
    this.zoneId,
    this.storeDiscount,
    this.scheduleOrder,
    this.avgRating,
    this.ratingCount,
    this.veg,
    this.moduleId,
    this.moduleType,
    this.unitType,
    this.stock,
    this.organic,
    this.quantityLimit,
    this.flashSale,
    this.categoryProducts,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    categoryId = json['category_id'];
    if (json['variations'] != null) {
      variations = [];
      var variationsJson = json['variations'];
      if (variationsJson is String) {
        variationsJson = jsonDecode(variationsJson);
      }
      variationsJson.forEach((v) {
        variations!.add(Variation.fromJson(v));
      });
    }

    if (json['category_products'] != null) {
      categoryProducts = (json['category_products'] as List).map((i) => CategoryProduct.fromJson(i)).toList();
    }

    if (json['food_variations'] != null) {
      foodVariations = [];
      var foodVariationsJson = json['food_variations'];
      if (foodVariationsJson is String) {
        foodVariationsJson = jsonDecode(foodVariationsJson);
      }
      foodVariationsJson.forEach((v) {
        foodVariations!.add(FoodVariation.fromJson(v));
      });
    }
    if (json['add_ons'] != null) {
      addOns = [];
      if (json['add_ons'].length > 0 && json['add_ons'][0] != '[') {
        json['add_ons'].forEach((v) {
          addOns!.add(AddOns.fromJson(v));
        });
      } else if (json['addons'] != null) {
        json['addons'].forEach((v) {
          addOns!.add(AddOns.fromJson(v));
        });
      }
    }
    if (json['choice_options'] != null) {
      choiceOptions = [];
      // Check if 'choice_options' is a String, and parse it into a List if necessary
      var choiceOptionsJson = json['choice_options'];
      if (choiceOptionsJson is String) {
        // Parse the string into a list
        choiceOptionsJson = jsonDecode(choiceOptionsJson);
      }
      // Ensure it's now a list
      if (choiceOptionsJson is List) {
        choiceOptionsJson.forEach((v) {
          choiceOptions!.add(ChoiceOptions.fromJson(v));
        });
      } else {
        // Handle unexpected type or log an error
        print('Unexpected type for choice_options: ${choiceOptionsJson.runtimeType}');
      }
    }

    price = json['price'].toDouble();
    tax = json['tax']?.toDouble();
    discount = json['discount'].toDouble();
    discountType = json['discount_type'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    zoneId = json['zone_id'];
    if (json['store_discount'] != null) {
      // Check if json['store_discount'] is not null
      storeDiscount = json['store_discount'].toDouble();
    } else {
      // Handle the case where json['store_discount'] is null
      // You may assign a default value or handle it based on your application logic
      storeDiscount = 0.0; // or any other default value you prefer
    }

    scheduleOrder = json['schedule_order'];
    avgRating = json['avg_rating'].toDouble();
    ratingCount = json['rating_count'];
    moduleId = json['module_id'];
    moduleType = json['module_type'];
    veg = json['veg'] != null ? int.parse(json['veg'].toString()) : 0;
    stock = json['stock'];
    unitType = json['unit_type'];
    availableDateStarts = json['available_date_starts'];
    organic = json['organic'];
    quantityLimit = json['maximum_cart_quantity'];
    flashSale = json['flash_sale'];
    // json["attributes"] == null ? [] : List<String>.from(json["attributes"]!.map((v) => v));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['images'] = images;
    data['category_id'] = categoryId;
    if (categoryIds != null) {
      data['category_ids'] = categoryIds!.map((v) => v.toJson()).toList();
    }
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    if (categoryProducts != null) {
      data['category_products'] = categoryProducts!.map((v) => v.toJson()).toList();
    }
    if (foodVariations != null) {
      data['food_variations'] = foodVariations!.map((v) => v.toJson()).toList();
    }
    if (addOns != null) {
      data['add_ons'] = addOns!.map((v) => v.toJson()).toList();
    }
    if (choiceOptions != null) {
      data['choice_options'] = choiceOptions!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['tax'] = tax;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['available_time_starts'] = availableTimeStarts;
    data['available_time_ends'] = availableTimeEnds;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['zone_id'] = zoneId;
    data['store_discount'] = storeDiscount;
    data['schedule_order'] = scheduleOrder;
    data['avg_rating'] = avgRating;
    data['rating_count'] = ratingCount;
    data['veg'] = veg;
    data['module_id'] = moduleId;
    data['module_type'] = moduleType;
    data['stock'] = stock;
    data['unit_type'] = unitType;
    data['available_date_starts'] = availableDateStarts;
    data['organic'] = organic;
    data['maximum_cart_quantity'] = quantityLimit;
    data['flash_sale'] = flashSale;
    return data;
  }
}

class CategoryIds {
  String? id;

  CategoryIds({this.id});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Variation {
  String? type;
  double? price;
  int? stock;

  Variation({this.type, this.price, this.stock});

  Variation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price']?.toDouble();
    stock = json['stock'] != null ? int.parse(json['stock'].toString()) : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    data['stock'] = stock;
    return data;
  }
}

class AddOns {
  int? id;
  String? name;
  double? price;

  AddOns({this.id, this.name, this.price});

  AddOns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class ChoiceOptions {
  String? name;
  String? title;
  List<String>? options;

  ChoiceOptions({this.name, this.title, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['title'] = title;
    data['options'] = options;
    return data;
  }
}

class FoodVariation {
  String? name;
  bool? multiSelect;
  int? min;
  int? max;
  bool? required;
  List<VariationValue>? variationValues;

  FoodVariation({this.name, this.multiSelect, this.min, this.max, this.required, this.variationValues});

  FoodVariation.fromJson(Map<String, dynamic> json) {
    if (json['max'] != null) {
      name = json['name'];
      multiSelect = json['type'] == 'multi';
      min = multiSelect! ? int.parse(json['min'].toString()) : 0;
      max = multiSelect! ? int.parse(json['max'].toString()) : 0;
      required = json['required'] == 'on';
      if (json['values'] != null) {
        variationValues = [];
        json['values'].forEach((v) {
          variationValues!.add(VariationValue.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = multiSelect;
    data['min'] = min;
    data['max'] = max;
    data['required'] = required;
    if (variationValues != null) {
      data['values'] = variationValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariationValue {
  String? level;
  double? optionPrice;
  bool? isSelected;

  VariationValue({this.level, this.optionPrice, this.isSelected});

  VariationValue.fromJson(Map<String, dynamic> json) {
    level = json['label'];
    optionPrice = double.parse(json['optionPrice'].toString());
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = level;
    data['optionPrice'] = optionPrice;
    data['isSelected'] = isSelected;
    return data;
  }
}

class CategoryProduct {
  int? id;
  String? name;
  String? description;
  String? image;
  int? categoryId;
  int? costPrice;
  List<CategoryIds>? categoryIds;
  int? brandId;
  String? sku;
  List<Variation>? variations;
  List<AddOns>? addOns;
  // List<Attributes>? attributes;
  List<ChoiceOptions>? choiceOptions;
  double? price;
  double? tax;
  String? taxType;
  double? discount;
  String? discountType;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? veg;
  int? status;
  int? storeId;
  String? createdAt;
  String? updatedAt;
  int? orderCount;
  double? avgRating;
  int? ratingCount;
  String? rating;
  int? moduleId;
  int? stock;
  int? unitId;
  List<String>? images;
  List<FoodVariation>? foodVariations;
  String? slug;
  int? recommended;
  int? organic;
  int? maximumCartQuantity;
  int? isApproved;
  String? unitType;
  // List<Translation>? translations;
  Unit? unit;

  CategoryProduct({
    this.id,
    this.name,
    this.description,
    this.image,
    this.categoryId,
    this.costPrice,
    this.categoryIds,
    this.brandId,
    this.sku,
    this.variations,
    this.addOns,
    // this.attributes,
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
    // this.translations,
    this.unit,
  });

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    categoryId = json['category_id'];
    costPrice = json['cost_price'];
    categoryIds = (jsonDecode(json['category_ids']) as List).map((i) => CategoryIds.fromJson(i)).toList();
    brandId = json['brand_id'];
    sku = json['sku'];
    variations = (jsonDecode(json['variations']) as List).map((i) => Variation.fromJson(i)).toList();
    addOns = (jsonDecode(json['add_ons']) as List).map((i) => AddOns.fromJson(i)).toList();
    // attributes = (jsonDecode(json['attributes']) as List).map((i) => Attributes.fromJson(i)).toList();
    choiceOptions = (jsonDecode(json['choice_options']) as List).map((i) => ChoiceOptions.fromJson(i)).toList();
    price = json['price']?.toDouble();
    tax = json['tax']?.toDouble();
    taxType = json['tax_type'];
    discount = json['discount']?.toDouble();
    discountType = json['discount_type'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    veg = json['veg'];
    status = json['status'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderCount = json['order_count'];
    avgRating = json['avg_rating']?.toDouble();
    ratingCount = json['rating_count'];
    rating = json['rating'];
    moduleId = json['module_id'];
    stock = json['stock'];
    unitId = json['unit_id'];
    images = json['images']?.cast<String>() ?? [];
    foodVariations = (jsonDecode(json['food_variations']) as List).map((i) => FoodVariation.fromJson(i)).toList();
    slug = json['slug'];
    recommended = json['recommended'];
    organic = json['organic'];
    maximumCartQuantity = json['maximum_cart_quantity'];
    isApproved = json['is_approved'];
    unitType = json['unit_type'];
    // translations = (json['translations'] as List).map((i) => Translation.fromJson(i)).toList();
    unit = Unit.fromJson(json['unit']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['category_id'] = categoryId;
    data['cost_price'] = costPrice;
    if (categoryIds != null) {
      data['category_ids'] = jsonEncode(categoryIds!.map((v) => v.toJson()).toList());
    }
    data['brand_id'] = brandId;
    data['sku'] = sku;
    if (variations != null) {
      data['variations'] = jsonEncode(variations!.map((v) => v.toJson()).toList());
    }
    if (addOns != null) {
      data['add_ons'] = jsonEncode(addOns!.map((v) => v.toJson()).toList());
    }
    // if (attributes != null) {
    //   data['attributes'] = jsonEncode(attributes!.map((v) => v.toJson()).toList());
    // }
    if (choiceOptions != null) {
      data['choice_options'] = jsonEncode(choiceOptions!.map((v) => v.toJson()).toList());
    }
    data['price'] = price;
    data['tax'] = tax;
    data['tax_type'] = taxType;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['available_time_starts'] = availableTimeStarts;
    data['available_time_ends'] = availableTimeEnds;
    data['veg'] = veg;
    data['status'] = status;
    data['store_id'] = storeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['order_count'] = orderCount;
    data['avg_rating'] = avgRating;
    data['rating_count'] = ratingCount;
    data['rating'] = rating;
    data['module_id'] = moduleId;
    data['stock'] = stock;
    data['unit_id'] = unitId;
    data['images'] = images;
    if (foodVariations != null) {
      data['food_variations'] = jsonEncode(foodVariations!.map((v) => v.toJson()).toList());
    }
    data['slug'] = slug;
    data['recommended'] = recommended;
    data['organic'] = organic;
    data['maximum_cart_quantity'] = maximumCartQuantity;
    data['is_approved'] = isApproved;
    data['unit_type'] = unitType;
    // if (translations != null) {
    //   data['translations'] = translations!.map((v) => v.toJson()).toList();
    // }
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    return data;
  }
}
