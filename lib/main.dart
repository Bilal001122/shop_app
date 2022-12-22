import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/cache_helper/cache_helper.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/dio_helper/dio_helper.dart';
import 'package:shop_app/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(
    isDark,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppCubit()..changeModeTheme(fromShared: isDark);
      },
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
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
            darkTheme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF333739),
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xFF333739),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: Color(0xFF333739),
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xFF333739),
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
              ),
              // textTheme: const TextTheme(
              //   bodyText1: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.white,
              //   ),
              // ),
              textTheme: GoogleFonts.poppinsTextTheme().copyWith(
                bodyText1: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: ThemeMode.light,
            // themeMode: cubit.isDark == false ? ThemeMode.light : ThemeMode.dark,
            home: OnBoardingScreen(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
