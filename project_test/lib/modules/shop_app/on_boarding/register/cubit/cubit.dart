import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/modules/shop_app/on_boarding/register/cubit/states.dart';
import 'package:project_test/modules/shop_app/on_boarding/shop_login_screen/cubit/states.dart';
import 'package:project_test/networks/end_points.dart';
import 'package:project_test/networks/remote/dio_helper.dart';

import '../../../../../models/shop_app/login_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {


  ShopLoginModel? loginmodel;


  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
}){
    emit(ShopRegisterLoadingState());
   DioHelper.postData(
       url: REGISTER,
       data: {
         'email':email,
         'password':password,
         'name':name,
         'phone':phone,
       })?.then((value) {
      loginmodel =  ShopLoginModel.fromjson(value.data);
      emit(ShopRegisterSuccesState(loginmodel!));
   }).catchError((error){
     emit(ShopRegisterFailState(
       error: error.toString(),
     ));
   });
  }


}