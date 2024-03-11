import 'package:kafil/features/home/domain/entities/countries.dart';

class CountriesModel extends Countries {
  CountriesModel({
    super.status,
    super.success,
    super.data,
    super.pagination,
  });

  CountriesModel.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CountriesDataModel.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? CountriesPaginationModel.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data
          ?.map((v) => CountriesDataModel(
                name: v.name,
                id: v.id,
                capital: v.capital,
                countryCode: v.countryCode,
              ).toJson())
          .toList();
    }
    if (pagination != null) {
      map['pagination'] = CountriesPaginationModel(
        count: pagination?.count,
        currentPage: pagination?.currentPage,
        links: pagination?.links,
        perPage: pagination?.perPage,
        total: pagination?.total,
        totalPages: pagination?.totalPages,
      ).toJson();
    }
    return map;
  }
}

class CountriesPaginationModel extends CountriesPagination {
  CountriesPaginationModel({
    super.count,
    super.total,
    super.perPage,
    super.currentPage,
    super.totalPages,
    super.links,
  });

  CountriesPaginationModel.fromJson(dynamic json) {
    count = json['count'];
    total = json['total'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    links = json['links'] != null
        ? CountriesLinksModel.fromJson(json['links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['total'] = total;
    map['perPage'] = perPage;
    map['currentPage'] = currentPage;
    map['totalPages'] = totalPages;
    if (links != null) {
      map['links'] = CountriesLinksModel(
        next: links?.next,
        previous: links?.previous,
      ).toJson();
    }
    return map;
  }
}

class CountriesLinksModel extends CountriesLinks {
  CountriesLinksModel({
    super.next,
    super.previous,
  });

  CountriesLinksModel.fromJson(dynamic json) {
    next = json['next'];
    previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['next'] = next;
    map['previous'] = previous;
    return map;
  }
}

class CountriesDataModel extends CountriesData {
  CountriesDataModel({
    super.id,
    super.countryCode,
    super.name,
    super.capital,
  });

  CountriesDataModel.fromJson(dynamic json) {
    id = json['id'];
    countryCode = json['country_code'];
    name = json['name'];
    capital = json['capital'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country_code'] = countryCode;
    map['name'] = name;
    map['capital'] = capital;
    return map;
  }
}
