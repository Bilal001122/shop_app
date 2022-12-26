import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/screens/shop_layout/categories_screen/categories_screen.dart';
import 'package:shop_app/screens/shop_layout/favorites_screen/favorites_screen.dart';
import 'package:shop_app/screens/shop_layout/products_screen/products_screen.dart';
import 'package:shop_app/screens/shop_layout/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/dio_helper/dio_helper.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:flutter/material.dart';

import '../../models/favorites_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  late LoginModel loginModel;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<int, bool> favorites = {};
  ChangeFavoritesModel? changeFavoritesModel;
  FavoritesModel? favoritesModel;

  void changeBottomItemNavBar(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());
    DioHelper.postData(
      url: login,
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        loginModel = LoginModel.fromJson(value.data);
        emit(AppLoginSuccessState(loginModel: loginModel));
      },
    ).catchError((error) {
      emit(AppLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown == false
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(AppChangePasswordVisibilityState());
  }

  void getHomeData() {
    emit(AppHomeLoadingState());
    DioHelper.getData(
      url: home,
      query: null,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(json: value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFav!,
        });
      });
      emit(
        AppHomeSuccessState(
          homeModel: homeModel,
        ),
      );
    }).catchError((onError) {
      emit(
        AppHomeErrorState(onError.toString()),
      );
    });
  }

  void getCategoriesData() {
    DioHelper.getData(
      url: categories,
      query: null,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(json: value.data);
      emit(
        AppCategoriesSuccessState(
          categoriesModel: categoriesModel,
        ),
      );
    }).catchError((onError) {
      emit(
        AppCategoriesErrorState(onError.toString()),
      );
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(AppChangeFavoritesState());
    DioHelper.postData(
      url: favoritess,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(json: value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavData();
      }
      emit(AppChangeFavoritesSuccessState(
          changeFavoritesModel: changeFavoritesModel));
    }).catchError((onError) {
      favorites[productId] = !favorites[productId]!;
      emit(AppChangeFavoritesErrorState(onError));
    });
  }

  void getFavData() {
    emit(AppGetFavLoadingState());
    DioHelper.getData(
      url: favoritess,
      query: null,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(json: value.data);
      emit(AppGetFavSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(
        AppGetFavErrorState(onError.toString()),
      );
    });
  }
}
