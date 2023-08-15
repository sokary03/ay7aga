import 'package:project_test/models/shop_app/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccesState extends ShopLoginState {

  ShopLoginModel loginModel;

  ShopLoginSuccesState(this.loginModel);
}

class ShopLoginFailState extends ShopLoginState {

  final String error;

  ShopLoginFailState({required this.error});
}