class Countries {
  Countries({
    this.status,
    this.success,
    this.data,
    this.pagination,
  });

  int? status;
  bool? success;
  List<CountriesData>? data;
  CountriesPagination? pagination;
}

class CountriesPagination {
  CountriesPagination({
    this.count,
    this.total,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.links,
  });

  int? count;
  int? total;
  int? perPage;
  int? currentPage;
  int? totalPages;
  CountriesLinks? links;
}

class CountriesLinks {
  CountriesLinks({
    this.next,
    this.previous,
  });

  String? next;
  String? previous;
}

class CountriesData {
  CountriesData({
    this.id,
    this.countryCode,
    this.name,
    this.capital,
  });

  int? id;
  String? countryCode;
  String? name;
  String? capital;
}
