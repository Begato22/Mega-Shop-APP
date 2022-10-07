class SearchModel {
  late bool status;
  SearchDataModel? searchDataModel;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    searchDataModel = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
  late int currentPage;
  List<Product> data = [];

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(Product.fromJson(element));
    });
  }
}



class Product {
  late int id;
  late String name;
  late String image;
  late dynamic price;
  late String description;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
  }
}
