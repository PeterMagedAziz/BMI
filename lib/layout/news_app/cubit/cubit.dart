import 'package:bmi/layout/news_app/cubit/states.dart';
import 'package:bmi/modules/business/business_screen.dart';
import 'package:bmi/modules/science/science_screen.dart';
import 'package:bmi/modules/sports/sports_screen.dart';
import 'package:bmi/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
  ];

  void changeBottomNavBar(int index)
  {
      currentIndex = index;
    if(index == 1) {
      getSports();
      getSciences();
    }
      emit(NewsBottomNavStates());
  }
  // https://newsapi.org/
  // v2/top-headlines?
  // country=us&category=business&apiKey=API_KEY

  List<dynamic>   business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': "7ee21ac3112b43aaab160f2ef40c3af9",
      },
    ).then((value) {
      {
        // print(value.data['totalResults']);
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessStates());
      }
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorStates(error.toString()));
    });
  }



  List<dynamic>   sciences = [];
  void getSciences() {
    emit(NewsGetSciencesLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'science',
        'apiKey': "7ee21ac3112b43aaab160f2ef40c3af9",
      },
    ).then((value) {
      {
        // print(value.data['totalResults']);
        sciences = value.data['articles'];
        print(sciences[0]['title']);
        emit(NewsGetSciencesSuccessStates());
      }
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSciencesErrorStates(error.toString()));
    });
  }

  List<dynamic>   sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': "7ee21ac3112b43aaab160f2ef40c3af9",
      },
    ).then((value) {
      {
        // print(value.data['totalResults']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessStates());
      }
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorStates(error.toString()));
    });
  }

}

