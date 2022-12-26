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
  late final int currentPage;
  late final List<FavoritesData> data = [];
  late final String firstPageUrl;
  late final int from;
  late final int lastPage;
  late final String lastPageUrl;
  late final String path;
  late final int perPage;
  late final int to;
  late final int total;

  Data.fromJson({required Map<String, dynamic> json}) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      FavoritesData favoritesData = FavoritesData.fromJson(json: element);
      data.add(favoritesData);
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
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
