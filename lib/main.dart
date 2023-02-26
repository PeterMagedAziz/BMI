import 'package:bmi/layout/news_app/cubit/cubit.dart';
import 'package:bmi/layout/news_app/news_layout.dart';
import 'package:bmi/layout/shop_app/cubit/cubit.dart';
import 'package:bmi/layout/shop_app/shop_layout.dart';
import 'package:bmi/layout/todo_app/todo_layout.dart';
import 'package:bmi/modules/basics/home/home_screen.dart';
import 'package:bmi/modules/bmi_app/bmi/bmi-screen.dart';
import 'package:bmi/modules/counter_app/counter/counter_screen.dart';
import 'package:bmi/modules/messenger_app/messenger/messenger_screen.dart';
import 'package:bmi/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:bmi/shared/cubit/cubit.dart';
import 'package:bmi/shared/cubit/states.dart';
import 'package:bmi/shared/network/local/cache_helper.dart';
import 'package:bmi/shared/network/remote/dio_helper.dart';
import 'package:bmi/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/basics/login/login_Screen.dart';
import 'modules/basics/users/user_screen.dart';
import 'modules/shop_app/login/shop_login_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'shared/block_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.cacheInit();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  var token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding)
  {
    if(token != null) {
      widget =  const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else
  {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
    onBoarding: onBoarding,
  ));
}
class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({
    super.key,
     this.isDark,
     this.startWidget, required onBoarding,
  });



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness()..getSciences()..getSports()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode()),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()),
      ],
      child: BlocConsumer<AppCubit,AppStates>
        (
          builder: (context,state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark ,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: startWidget,
            );
          },
          listener: (context,state) {},
      ),
    );
  }
}
// NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light