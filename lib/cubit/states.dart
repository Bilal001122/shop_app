abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavState extends AppStates {}

class AppGetBusinessLoadingState extends AppStates {}

class AppGetBusinessSuccessState extends AppStates {}

class AppGetBusinessOnErrorState extends AppStates {
  final String error;

  AppGetBusinessOnErrorState(this.error);
}

class AppGetSportsLoadingState extends AppStates {}

class AppGetSportsSuccessState extends AppStates {}

class AppGetSportsOnErrorState extends AppStates {
  final String error;

  AppGetSportsOnErrorState(this.error);
}

class AppGetScienceLoadingState extends AppStates {}

class AppGetScienceSuccessState extends AppStates {}

class AppGetScienceOnErrorState extends AppStates {
  final String error;

  AppGetScienceOnErrorState(this.error);
}

class AppThemeChangeState extends AppStates {}

class AppGetSearchLoadingState extends AppStates {}

class AppGetSearchSuccessState extends AppStates {}

class AppGetSearchOnErrorState extends AppStates {
  final String error;

  AppGetSearchOnErrorState(this.error);
}
