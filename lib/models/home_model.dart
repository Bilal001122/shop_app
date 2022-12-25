class HomeModel {
  late final bool status;
  late final HomeDataModel data;

  HomeModel.fromJson({required Map<String, dynamic> json}) {
    status = json['status'];
    data = HomeDataModel.fromJson(
      json: json['data'],
    );
  }
}

class HomeDataModel {
  late final List<BannerModel> banners = [];
  late final List<ProductModel> products = [];

  HomeDataModel.fromJson({required Map<String, dynamic> json}) {
    json['banners'].forEach((element) {
      BannerModel bannerModel = BannerModel.fromJson(json: element);
      banners.add(bannerModel);
    });
    json['products'].forEach((element) {
      ProductModel productModel = ProductModel.fromJson(json: element);
      products.add(productModel);
    });
  }
}

class BannerModel {
  late final int id;
  late final String image;

  BannerModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late final int id;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final String image;
  late final String name;
  late final bool? inFav;
  late final bool? inCard;

  ProductModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFav = json['in_favorites'];
    inCard = json['in_carts'];
  }
}
