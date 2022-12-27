import 'home_model.dart';

class SearchModel {
  late final bool status;
  late final Data data;

  SearchModel.fromJson({required Map<String, dynamic> json}) {
    status = json['status'];
    data = Data.fromJson(json: json['data']);
  }
}

class Data {
  late final int? currentPage;
  late final List<ProductModel> data = [];

  Data.fromJson({required Map<String, dynamic> json}) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      ProductModel productModel = ProductModel.fromJson(json: element);
      data.add(productModel);
    });
  }
}
