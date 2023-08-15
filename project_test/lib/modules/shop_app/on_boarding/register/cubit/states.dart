import 'package:project_test/models/shop_app/login_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterState {}

class ShopRegisterSuccesState extends ShopRegisterState {

  ShopLoginModel loginModel;

  ShopRegisterSuccesState(this.loginModel);
}

class ShopRegisterFailState extends ShopRegisterState {

  final String error;

  ShopRegisterFailState({required this.error});
}

