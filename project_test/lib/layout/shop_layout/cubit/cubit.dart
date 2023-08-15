import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/layout/shop_layout/cubit/states.dart';
import 'package:project_test/models/shop_app/favorites_model_item.dart';
import 'package:project_test/networks/remote/dio_helper.dart';

import '../../../components/constants.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../modules/shop_app/on_boarding/categories/categories.dart';
import '../../../modules/shop_app/on_boarding/favorites/favorites.dart';
import '../../../modules/shop_app/on_boarding/products/products.dart';
import '../../../modules/shop_app/on_boarding/settings/settings.dart';
import '../../../networks/end_points.dart';

class ShopAppLayoutCubit extends Cubit<ShopLayOutState> {

  ShopAppLayoutCubit(): super(ShopLayOutInitialState());
  static ShopAppLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreenes = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  HomeModel? homeModel;
  CategoriesModel? categorieModel;
  Map<int?,bool?> favorites = {};
  ChangedFavoriteModel? changedfavoritemodel;
  FavoriteModel? favoritemodel;


  void ChangeBottomIndex(index){
    currentIndex = index;
    emit(ShopNavBarChangedState());
  }

  void getHomeData(){
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: HOME,token: token).then((value){
      emit(ShopSuccessHomeState());
      homeModel = HomeModel.fromjson(value.data);
      homeModel?.data?.products.forEach((element){
        favorites.addAll({
          element.id:element.in_favorites,
        });
      });
      print(favorites.toString());

    }).catchError((error){
      emit(ShopFailHomeState());
      print(error.toString());
    });
  }

  void getCategoriesData(){
    DioHelper.getData(url: GET_CATEGORIES,token: token).then((value){
      emit(ShopSuccessCategorieState());
      categorieModel = CategoriesModel.fromjson(value.data);
      print(categorieModel?.status);
    }).catchError((error){
      emit(ShopFailCategorieState());
      print(error.toString());
    });
  }
  
  void changeFavorite(int productId){
    favorites[productId] = !favorites[productId]!;
    emit(ShopSuccessChangeFavoriteState());
    DioHelper.postData(url: FAVORITES, data: {'product_id':productId},token: token)?.then((value){
      emit(ShopSuccessFavoriteState());

      changedfavoritemodel = ChangedFavoriteModel.fromjson(value.data);

      if(changedfavoritemodel!.status == false){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoritesData();
      }
    }).catchError((error){
      emit(ShopFailFavoriteState());
      favorites[productId] = !favorites[productId]!;
      print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkklllllllllllllllllllllllllllllllllllllllllllllllll');
      print(error.toString());
    });
  }

  void getFavoritesData(){
    emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(url: FAVORITES,token: token).then((value){
      emit(ShopSuccessGetFavoriteState());
      favoritemodel = FavoriteModel.fromJson(value.data);
      print(favoritemodel?.status);
    }).catchError((error){
      emit(ShopFailGetFavoriteState());
      print(error.toString());
    });
  }

  ShopLoginModel? userModel;

  void getUserData(){
    emit(ShopLoadingGetUserState());
    DioHelper.getData(url: PROFILE,token: token).then((value){
      userModel = ShopLoginModel.fromjson(value.data);
      emit(ShopSuccessGetUserState(userModel: userModel));
    }).catchError((error){
      emit(ShopFailGetUserState());
      print(error.toString());
    });
  }
  void updateUserData({
    required String name,
    required String phone,
    required String email,
}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url: UPDATE,
        token: token,
      data: {
          "name":name,
          "phone":phone,
          "email":email,
      },
    )?.then((value){
      userModel = ShopLoginModel.fromjson(value.data);
      emit(ShopSuccessUpdateUserState(userModel: userModel));
    }).catchError((error){
      emit(ShopFailUpdateUserState());
      print(error.toString());
    });
  }










}