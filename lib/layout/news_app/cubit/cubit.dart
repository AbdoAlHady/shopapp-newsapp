import 'package:bmicalc/layout/news_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsIntialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBAr(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingSatate());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '330450d5ca2a4142ab73943340aef00b'
    }).then((value) {
      business = value.data['articles'];
      print(value.data['articles'][0]['title']);
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessSatate());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorSatate(error));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingSatate());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '330450d5ca2a4142ab73943340aef00b'
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessSatate());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorSatate(Error));
      });
    } else {
      emit(NewsGetSportsSuccessSatate());
    }
  }

  List<dynamic> scince = [];

  void getScience() {
    emit(NewsGetScienceLoadingSatate());
    if (scince.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '330450d5ca2a4142ab73943340aef00b'
      }).then((value) {
        scince = value.data['articles'];
        print(scince[0]['title']);
        emit(NewsGetScienceSuccessSatate());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorSatate(error));
      });
    } else {
      emit(NewsGetScienceSuccessSatate());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingSatate());
    DioHelper.getData(url: 'v2/everything', query: {

      'q': '${value}' ,
      'apiKey': '330450d5ca2a4142ab73943340aef00b'
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessSatate());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorSatate(error));
          });
  }
}
