import 'package:bmi/layout/shop_app/cubit/states.dart';
import 'package:bmi/models/shop_app/categories_model.dart';
import 'package:bmi/models/shop_app/change_favorites_model.dart';
import 'package:bmi/models/shop_app/home_model.dart';
import 'package:bmi/modules/shop_app/categories/categories_screen.dart';
import 'package:bmi/modules/shop_app/favourites/favourite__screen.dart';
import 'package:bmi/modules/shop_app/products/products__screen.dart';
import 'package:bmi/modules/shop_app/settings/settings_screen.dart';
import 'package:bmi/shared/components/constants.dart';
import 'package:bmi/shared/network/end_points/end__points.dart';
import 'package:bmi/shared/network/local/cache_helper.dart';
import 'package:bmi/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouriteScreen() ,
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int,bool> favorites= {};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      // print(homeModel!.data.banners[0].image);
      // print(homeModel!.status);

      for (var element in homeModel!.data.products) {
        favorites.addAll({element.id:element.inFavorites});
      }
      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavouritesModel;
  void changeFavourites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit( ShopSuccessChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data:{
          'product_id':productId
        } ,
        token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      changeFavouritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!changeFavouritesModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }
      // else{
      //   getFavouriteData();
      // }
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      // ShopErrorFavouritesState();
      emit(ShopErrorChangeFavoritesState());
    });
  }


}