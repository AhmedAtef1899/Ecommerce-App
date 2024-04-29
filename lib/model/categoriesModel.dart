
class CategoriesModels
{
  bool? status;
  CategoriesDataModels? data;
  // named constructor
  CategoriesModels.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null? CategoriesDataModels.fromJson(json['data']) : null;
  }
}

class CategoriesDataModels
{
  int? currentPage;
  List<DataModel> catData = [];
  CategoriesDataModels.fromJson(Map<String,dynamic>json)
  {
    currentPage = json['current_page'];
    if (json['data'] != null)
    {
      catData = List<DataModel>.from(json['data'].map((e) => DataModel.fromJson(e))
      );
    }
  }
}
class DataModel
{
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}