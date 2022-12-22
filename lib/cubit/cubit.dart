import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/dio_helper/dio_helper.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:flutter/material.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
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
        print(value.data);
        emit(AppLoginSuccessState());
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

// void changeBetweenBottomNavBarItems(int index) {
//   currentIndex = index;
//   emit(AppBottomNavState());
// }
//
// void changeModeTheme({bool? fromShared}) {
//   if (fromShared != null) {
//     isDark = fromShared;
//     emit(AppThemeChangeState());
//   } else {
//     isDark = !isDark;
//     CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
//       emit(AppThemeChangeState());
//     });
//   }
// }
}
