import 'package:kafil/features/home/domain/entities/services.dart';

class ServicesModel extends Services {
  ServicesModel({
    super.status,
    super.success,
    super.data,
  });

  ServicesModel.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServicesDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data
          ?.map((v) => ServicesDataModel(
                id: v.id,
                title: v.title,
                averageRating: v.averageRating,
                completedSalesCount: v.completedSalesCount,
                discount: v.discount,
                mainImage: v.mainImage,
                price: v.price,
                priceAfterDiscount: v.priceAfterDiscount,
                recommended: v.recommended,
              ).toJson())
          .toList();
    }
    return map;
  }
}

class ServicesDataModel extends ServicesData {
  ServicesDataModel({
    super.id,
    super.mainImage,
    super.price,
    super.discount,
    super.priceAfterDiscount,
    super.title,
    super.averageRating,
    super.completedSalesCount,
    super.recommended,
  });

  ServicesDataModel.fromJson(dynamic json) {
    id = json['id'];
    mainImage = json['main_image'];
    price = json['price'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount'];
    title = json['title'];
    averageRating = json['average_rating'];
    completedSalesCount = json['completed_sales_count'];
    recommended = json['recommended'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['main_image'] = mainImage;
    map['price'] = price;
    map['discount'] = discount;
    map['price_after_discount'] = priceAfterDiscount;
    map['title'] = title;
    map['average_rating'] = averageRating;
    map['completed_sales_count'] = completedSalesCount;
    map['recommended'] = recommended;
    return map;
  }
}
