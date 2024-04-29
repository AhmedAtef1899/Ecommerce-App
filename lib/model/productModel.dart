
class HomeModel {
  bool? status;
  ProductData? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ProductData.fromJson(json['data']) : null;
  }

}

class ProductData {
  List<Products>? products;
  String? ad;

  ProductData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    ad = json['ad'];
  }

}

class Products {
  int? id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price']?.toDouble(); // Convert to double if possible
    oldPrice = json['old_price']?.toDouble(); // Convert to double if possible
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images']?.cast<String>(); // Cast to List<String> if present
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

