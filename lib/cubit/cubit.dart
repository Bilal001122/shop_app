import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache_helper/cache_helper.dart';
import 'package:shop_app/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDark = false;

  void changeBetweenBottomNavBarItems(int index) {
    currentIndex = index;
    emit(AppBottomNavState());
  }

  void changeModeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppThemeChangeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppThemeChangeState());
      });
    }
  }
}
