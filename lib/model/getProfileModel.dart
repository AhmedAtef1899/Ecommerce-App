
class GetProfileModel
{
  bool? status;
  GetProfileData? data;
  GetProfileModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = json['data'] != null? GetProfileData.fromJson(json['data']) : null;
  }
}
class GetProfileData
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? token;

  GetProfileData.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }
}