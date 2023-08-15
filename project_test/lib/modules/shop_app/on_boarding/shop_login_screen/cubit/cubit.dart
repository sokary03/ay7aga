import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/modules/shop_app/on_boarding/shop_login_screen/cubit/states.dart';
import 'package:project_test/networks/end_points.dart';
import 'package:project_test/networks/remote/dio_helper.dart';

import '../../../../../models/shop_app/login_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {


  ShopLoginModel? loginmodel;


  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
   DioHelper.postData(
       url: LOGIN,
       data: {
         'email':email,
         'password':password,
       })?.then((value) {
      loginmodel =  ShopLoginModel.fromjson(value.data);
      emit(ShopLoginSuccesState(loginmodel!));
   }).catchError((error){
     emit(ShopLoginFailState(
       error: error.toString(),

     ));
   });
  }
}