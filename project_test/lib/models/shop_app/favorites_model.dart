class ChangedFavoriteModel{
  bool? status;
  String? message;

  ChangedFavoriteModel.fromjson(Map<String,dynamic> json){

    status = json['status'];
  }
}