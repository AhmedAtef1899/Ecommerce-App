
class GetOrderModel {
  bool? status;
  Data? data;
  

  GetOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  
}

class Data {
  int? currentPage;
  List<dynamic>? data;
  String? firstPageUrl;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? total;
  

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <dynamic>[];
      json['data'].forEach((v) {
        data!.add(v);
      });
    }
    firstPageUrl = json['first_page_url'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    total = json['total'];
  }

 
}
