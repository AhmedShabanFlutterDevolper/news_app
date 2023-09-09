import 'package:bloc/bloc.dart';
import 'package:elnews/moudels/Setting.dart';
import 'package:elnews/moudels/home/business.dart';
import 'package:elnews/moudels/home/sports.dart';
import 'package:elnews/shared/components/componenets.dart';
import 'package:elnews/shared/cubit/set.dart';
import 'package:elnews/shared/network/cash_helper.dart';
import 'package:elnews/shared/network/dioHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../moudels/home/scinences.dart';

class NewsCubit extends Cubit<NewStates> {
  NewsCubit() : super(NewInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Scinences'),
  ];
  List<Widget> screans = [
    businessScrean(),
    SportsScrean(),
    ScinencesScrean(),
  ];
  void ChangeBottomNavBar(int index) {
    CurrentIndex = index;
    if (index == 1) getSports();
    if (index == 0) getBusiness();
    if (index == 2) getScinences();
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessSuccessState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessLoadingState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsSuccessState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsLoadingState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchSuccessState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchLoadingState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  List<dynamic> scinences = [];
  void getScinences() {
    emit(NewsGetScienceSuccessState());
    if (scinences.length == 00) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        scinences = value.data['articles'];
        print(scinences[0]['title']);

        emit(NewsGetSportsLoadingState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeThemeMode());
    } else {
      isDark = !isDark;

      CachHelper.putData(key: 'isDark', value: isDark)?.then((value) {
        emit(AppChangeThemeMode());
      });
    }
  }
}
