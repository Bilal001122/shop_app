import 'home_model.dart';

class FavoritesModel {
  late final bool status;
  late final Data data;

  FavoritesModel.fromJson({required Map<String, dynamic> json}) {
    status = json['status'];
    data = Data.fromJson(json: json['data']);
  }
}

class Data {
  late final int? currentPage;
  late final List<FavoritesData> data = [];

  Data.fromJson({required Map<String, dynamic> json}) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      FavoritesData favoritesData = FavoritesData.fromJson(json: element);
      data.add(favoritesData);
    });
  }
}

class FavoritesData {
  late final int id;
  late final ProductModel productModel;

  FavoritesData({
    required this.id,
    required this.productModel,
  });

  FavoritesData.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    productModel = ProductModel.fromJson(json: json['product']);
  }
}
