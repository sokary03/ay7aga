 import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/components/constants.dart';
import 'package:project_test/models/shop_app/search_model.dart';
import 'package:project_test/modules/shop_app/on_boarding/search/cubit/states.dart';
import 'package:project_test/networks/end_points.dart';
import 'package:project_test/networks/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchState> {

  SearchCubit(): super(SearchInitialState());

  static void get(context) => BlocProvider.of(context);
  static SearchCubit r = SearchCubit();

  static SearchModel? model;

  void search(String text){

    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {"text":text},
      token: token,
    )?.then((value){
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccesState());

    }).catchError((error){
      emit(SearchFailState());
      print(error.toString());
    });

  }



}