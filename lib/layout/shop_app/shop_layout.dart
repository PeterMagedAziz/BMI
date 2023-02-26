import 'package:bmi/layout/shop_app/cubit/cubit.dart';
import 'package:bmi/layout/shop_app/cubit/states.dart';
import 'package:bmi/modules/shop_app/login/shop_login_screen.dart';
import 'package:bmi/modules/shop_app/search/shop_search_screen.dart';
import 'package:bmi/shared/components/components.dart';
import 'package:bmi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, const ShopSearchScreen());
              }, icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index){
              cubit.changeBottom(index);
            },
              currentIndex: cubit.currentIndex,
              items:
          const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined,
                ),
                label: 'Categories'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorite'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings'
            ),
          ]),
        );
      },
    );
  }
}
