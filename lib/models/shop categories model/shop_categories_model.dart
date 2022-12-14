class CategoryModel {
  late bool status;
  CategoryDataModel? categoryDataModel;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoryDataModel = CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  late int currentPpage;
  List<Data> data = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPpage = json['current_page'];
    json['data'].forEach(
      (element) {
        data.add(Data.fromJson(element));
      },
    );
  }
}

class Data {
  late int id;
  late String name;
  late String image;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
