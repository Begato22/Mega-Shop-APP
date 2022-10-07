class ChangeFavoriteModel {
  late bool status;
  late String message;

  ChangeFavoriteModel.froJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
