class FavoriteModel {
  late bool status;
  FavoriteDataModel? favoriteDataModel;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    favoriteDataModel = FavoriteDataModel.fromJson(json['data']);
  }
}

class FavoriteDataModel {
  late int currentPage;
  List<Data> data = [];

  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  late int id;
  Product? product;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  late String name;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String description;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    description = json['description'];
  }
}
