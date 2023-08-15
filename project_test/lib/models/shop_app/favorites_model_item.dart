class FavoriteModel {
  bool? status;
  Data? data;



  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? currentPage;
  List<FavoritesData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavoritesData>[];
      json['data'].forEach((v) {
        data!.add(new FavoritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}

class FavoritesData {
  int? id;
  Product? product;



  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }
  FavoritesData.nell(id,price,oldPrice,discount,image,name,description,mainid) {
    id = mainid;
    product = new Product.nell(id, price, oldPrice, discount, image, name, description);
  }


}

class Product {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
  Product.nell(id,price,oldPrice,discount,image,name,description) {
    this.id = id;
    this.price = price;
    this.oldPrice = oldPrice;
    this.discount = discount;
    this.image = image;
    this.name = name;
    this.description = description;
  }


}
