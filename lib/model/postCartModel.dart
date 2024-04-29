
class PostCartProduct {
  int? id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  PostCartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price']?.toDouble(); // Convert to double if possible
    oldPrice = json['old_price']?.toDouble(); // Convert to double if possible
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

class PostCartData {
  int? id;
  int? quantity;
  PostCartProduct? product;

  PostCartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null ? PostCartProduct.fromJson(json['product']) : null;
  }
}

class PostResponseModel {
  bool? status;
  String? message;
  PostCartData? data;

  PostResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? PostCartData.fromJson(json['data']) : null;
  }
}
