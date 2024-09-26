import '../core/Caching/CacheHelper.dart';

class loginmodel {
  UserData? data;
  int? type=0;
  String? token="";

  loginmodel(this.data, this.type);

  loginmodel.fromJson(Map<dynamic, dynamic> json) {
    type = json['type'] ;
    token = json['token'] ;
    data = UserData.fromJson(json['user']) ;
  }
}

class UserData {

  int? id=0;
  int? category_id=0;
  String name="";
  String phone="";
  String email="";
 // String picture="";
  String location="";
  UserData(this.id, this.category_id, this.name, this.phone,
      this.email, this.location);

  UserData.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    category_id = json['category_id'];
    location = json['location'];
    // CacheHelper.saveData(key: 'id', value: json['id']);
    // CacheHelper.saveData(key: 'name', value: json['name']);
    // CacheHelper.saveData(key: 'phone', value: json['phone']);
    // CacheHelper.saveData(key: 'email', value: json['email']);
    // CacheHelper.saveData(key: 'picture', value: json['picture']);
    // CacheHelper.saveData(key: 'location', value: json['location']);
    // CacheHelper.saveData(key: 'token', value: json['token']);
  }
}
