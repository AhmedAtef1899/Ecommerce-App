
class AddFavouriteModel {
  bool? status;
  String? message;
  AddFavoriteData? data;

  AddFavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AddFavoriteData.fromJson(json['data']) : null;
  }

}

class AddFavoriteData {
  int? id;
  AddFavoriteProduct? product;


  AddFavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? AddFavoriteProduct.fromJson(json['product']) : null;
  }


}

class AddFavoriteProduct {
  int? id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;

  AddFavoriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price']?.toDouble();
    oldPrice = json['old_price']?.toDouble();
    discount = json['discount'];
    image = json['image'];
  }

}
