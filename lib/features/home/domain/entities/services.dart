class Services {
  Services({
    this.status,
    this.success,
    this.data,
  });

  int? status;
  bool? success;
  List<ServicesData>? data;
}

class ServicesData {
  ServicesData({
    this.id,
    this.mainImage,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.title,
    this.averageRating,
    this.completedSalesCount,
    this.recommended,
  });

  int? id;
  String? mainImage;
  int? price;
  dynamic discount;
  int? priceAfterDiscount;
  String? title;
  int? averageRating;
  int? completedSalesCount;
  bool? recommended;
}
