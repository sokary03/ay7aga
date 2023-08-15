class ShopLoginModel {
  late bool status;
  late String message;
  LoginData? data;

  ShopLoginModel.fromjson(Map<String,dynamic> json){
    status = json['status'];

    message = json['message'] ?? 'MESSAGE IS NULL';
    data = json['data'] != null ? LoginData.fromjson(json['data']) : null;
;
  }
}

class LoginData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;


  LoginData.fromjson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    credit = json['credit'];
    token = json['token'];
  }
}