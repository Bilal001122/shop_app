import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

import '../../models/change_favorites_model.dart';
import '../../models/login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoginLoadingState extends AppStates {}

class AppLoginSuccessState extends AppStates {
  final LoginModel loginModel;

  AppLoginSuccessState({required this.loginModel});
}

class AppLoginErrorState extends AppStates {
  final String error;

  AppLoginErrorState(this.error);
}

class AppChangePasswordVisibilityState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppHomeLoadingState extends AppStates {}

class AppHomeSuccessState extends AppStates {
  final HomeModel? homeModel;

  AppHomeSuccessState({required this.homeModel});
}

class AppHomeErrorState extends AppStates {
  final String error;

  AppHomeErrorState(this.error);
}

class AppCategoriesSuccessState extends AppStates {
  final CategoriesModel? categoriesModel;

  AppCategoriesSuccessState({required this.categoriesModel});
}

class AppCategoriesErrorState extends AppStates {
  final String error;

  AppCategoriesErrorState(this.error);
}

class AppChangeFavoritesSuccessState extends AppStates {
  final ChangeFavoritesModel? changeFavoritesModel;

  AppChangeFavoritesSuccessState({required this.changeFavoritesModel});
}

class AppChangeFavoritesState extends AppStates {}

class AppChangeFavoritesErrorState extends AppStates {
  final String error;

  AppChangeFavoritesErrorState(this.error);
}

class AppGetFavLoadingState extends AppStates {}

class AppGetFavSuccessState extends AppStates {}

class AppGetFavErrorState extends AppStates {
  final String error;

  AppGetFavErrorState(this.error);
}
