import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/layout/news_app/cubit/states.dart';

import '../../../modules/news_app/search/business/business_screen.dart';
import '../../../modules/news_app/search/science/science_screen.dart';
import '../../../modules/news_app/search/settings/settings_screen.dart';
import '../../../modules/news_app/search/sports/sports_screen.dart';
import '../../../networks/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {

  NewsCubit() : super(NewsInitialState());

  int current_screen_index = 0;

  List<Widget> screens_list =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingssScreen(),
  ];

  List<String> Titles_list =
  [
    'Business screen',
    'Sports screen',
    'Science screen',
  ];

  List<BottomNavigationBarItem> nav_bar_items =
  [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.money,
        ),
        label: 'Business'
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports'
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science'
    ),
  ];

  List<dynamic> business = [];
  List<dynamic> Sports = [];
  List<dynamic> Science = [];
  List<dynamic> search = [];


  static NewsCubit get(context) => BlocProvider.of(context);

  void bottom_nav_bar_changed(index){
    current_screen_index = index;
    emit(NewsBottomNavState());
  }

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'70a80666620741ea9d0fbeb6b92ad8c2',
      },
    ).then((value){
      business = value.data['articles'];
      emit(GetBusinessSucessState());
    }).catchError((error){
      print(error.toString());
      emit(GetBusinessFaiedState( error: error.toString()));
    });
  }

  void getSports()
  {
    if(Sports.length == 0){

      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'70a80666620741ea9d0fbeb6b92ad8c2',
        },
      ).then((value){
        Sports = value.data['articles'];
        emit(GetSportsSucessState());
      }).catchError((error){
        print(error.toString());
        emit(GetSportsFaiedState( error: error.toString()));
      });
    }
    else{
      emit(GetSportsSucessState());
    }

  }

  void getscience()
  {
    if(Science.length == 0){

      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'70a80666620741ea9d0fbeb6b92ad8c2',
        },
      ).then((value){
        Science = value.data['articles'];
        emit(GetScienceSucessState());
      }).catchError((error){
        print(error.toString());
        emit(GetScienceFaiedState( error: error.toString()));
      });
    }
    else{
      emit(GetScienceSucessState());
    }

  }

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'70a80666620741ea9d0fbeb6b92ad8c2',
      },
    ).then((value){
      search = value.data['articles'];
      emit(GetSearchSucessState());
    }).catchError((error){
      print(error.toString());
      emit(GetScienceFaiedState( error: error.toString()));
    });

  }


}