import 'package:bmi/layout/news_app/cubit/cubit.dart';
import 'package:bmi/layout/news_app/cubit/states.dart';
import 'package:bmi/shared/cubit/cubit.dart';
import 'package:bmi/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..getSciences()..getSports(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, states) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:  const Text('News App'),
              actions: [
                IconButton(onPressed: () {},
                icon: const Icon(Icons.search),
                ),
                IconButton(onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: const Icon(Icons.brightness_4),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        },
        listener: (context, states) {},
      ),
    );
  }
}
