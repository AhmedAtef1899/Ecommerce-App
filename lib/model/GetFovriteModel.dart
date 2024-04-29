
class FavModel {
  bool? status;
  FavDataModel? data;


  FavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? FavDataModel.fromJson(json['data']) : null;
  }

}

class FavDataModel {
  int? currentPage;
  List<FavData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;


  FavDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavData>[];
      json['data'].forEach((v) {
        data!.add(FavData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}

class FavData {
  int? id;
  ProductFav? product;

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? ProductFav.fromJson(json['product']) : null;
  }

}

class ProductFav {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;


  ProductFav.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
