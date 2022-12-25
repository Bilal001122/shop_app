class CategoriesModel {
  late final bool status;
  late final CategoriesDataModel categoriesDataModel;

  CategoriesModel.fromJson({required Map<String, dynamic> json}) {
    status = json['status'];
    categoriesDataModel = CategoriesDataModel.fromJson(json: json['data']);
  }
}

class CategoriesDataModel {
  late final int currentPage;
  late final List<DataModel> data = [];

  CategoriesDataModel.fromJson({required Map<String, dynamic> json}) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(json: element));
    });
  }
}

class DataModel {
  late final int id;
  late final String name;
  late final String image;

  DataModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
