import 'package:bloc/bloc.dart';
import 'package:bmi/layout/news_app/cubit/cubit.dart';
import 'package:bmi/layout/news_app/news_layout.dart';
import 'package:bmi/layout/todo_app/todo_layout.dart';
import 'package:bmi/shared/cubit/cubit.dart';
import 'package:bmi/shared/cubit/states.dart';
import 'package:bmi/shared/network/local/cache_helper.dart';
import 'package:bmi/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'shared/block_observer.dart';

void main(){

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness()..getSciences()..getSports()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode()),
      ],
      child: BlocConsumer<AppCubit,AppStates>
        (
          builder: (context,state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                    color: Colors.deepOrange,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )

                ),
              ),
              themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light ,
              darkTheme: ThemeData(
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme:  AppBarTheme(
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  titleTextStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle:  SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light),
                ),
                bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: HexColor('333739'),
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )

                ),
              ),
              home: const NewsLayout(),
            );
          },
          listener: (context,state) {},
      ),
    );
  }
}
// NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light