class BannerModel {
  bool? status;
  List<BannerDate>? data;

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      // Ensure 'data' key exists and is a list
      if (json['data'] is List) {
        data = List<BannerDate>.from(
          json['data'].map((element) => BannerDate.fromJson(element)),
        );
      } else {
        // If 'data' key exists but is not a list, set data to null or an empty list as per your requirement
        data = null; // or data = [];
      }
    }
  }
}

class BannerDate {
  int? id;
  String? image;

  BannerDate.fromJson(Map<String, dynamic> json) {
    // Ensure 'id' and 'image' keys exist in json
    if (json.containsKey('id') && json.containsKey('image')) {
      id = json['id'];
      image = json['image'] ?? '';
    } else {
      // If 'id' or 'image' key is missing, handle error accordingly
      // Here, we choose to set them to null
      id = null;
      image = null;
    }
  }
}
