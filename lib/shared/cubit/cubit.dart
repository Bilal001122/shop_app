import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
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
  IconData suffix2 = Icons.visibility_outlined;

  bool isPasswordShown = true;
  bool isPasswordShown2 = true;
  int currentIndex = 0;
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  LoginModel? loginModel;
  LoginModel? registerModel;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<int, bool> favorites = {};
  ChangeFavoritesModel? changeFavoritesModel;
  FavoritesModel? favoritesModel;
  LoginModel? userModel;

  void changeBottomItemNavBar(int index) {
    currentIndex = index;
    if (index == 3) {
      getUserData();
    }
    if (index == 2) {
      getFavData();
    }
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

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(AppRegisterLoadingState());
    DioHelper.postData(
      url: register,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then(
      (value) {
        registerModel = LoginModel.fromJson(value.data);
        emit(AppRegisterSuccessState(registerModel: registerModel));
      },
    ).catchError((error) {
      print(error);
      emit(AppRegisterErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown == false
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(AppChangePasswordVisibilityState());
  }

  void changePasswordVisibility2() {
    isPasswordShown2 = !isPasswordShown2;
    suffix2 = isPasswordShown2 == false
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(AppChangePasswordVisibilityState2());
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

  void getUserData() {
    emit(AppUserDataLoadingState());
    DioHelper.getData(
      url: profile,
      query: null,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(AppUserDataSuccessState(userModel));
    }).catchError((onError) {
      print(onError);
      emit(
        AppUserDataErrorState(onError.toString()),
      );
    });
  }

  SearchModel? searchModel;

  void search(String text) {
    emit(AppSearchLoadingState());
    DioHelper.postData(token: token, url: searchc, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(json: value.data);
      emit(AppSearchSuccessState());
    }).catchError((onError) {
      emit(AppSearchErrorState(onError));
    });
  }
}
