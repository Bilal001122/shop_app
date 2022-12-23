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
