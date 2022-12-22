abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoginLoadingState extends AppStates {}

class AppLoginSuccessState extends AppStates {}

class AppLoginErrorState extends AppStates {
  final String error;

  AppLoginErrorState(this.error);
}

class AppChangePasswordVisibilityState extends AppStates {}
