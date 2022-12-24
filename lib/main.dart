import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/screens/login_screen/login_screen.dart';
import 'package:shop_app/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/shop_layout/shop_layout.dart';
import 'package:shop_app/shared/dio_helper/dio_helper.dart';

import 'shared/cache_helper/cache_helper.dart';
import 'shared/cubit/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(
    key: 'OnBoarding',
  );
  String? token = CacheHelper.getData(
    key: 'token',
  );
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    start: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget start;

  MyApp({required this.start});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          bodyText1: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
        ),
      ),
      home: start,
    );
  }
}
