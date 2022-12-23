import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/dio_helper/dio_helper.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:flutter/material.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  late LoginModel loginModel;
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
}
