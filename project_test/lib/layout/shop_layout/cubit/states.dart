import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/login_model.dart';

abstract class ShopLayOutState {}

class ShopLayOutInitialState  extends ShopLayOutState {}

class ShopNavBarChangedState  extends ShopLayOutState {}

class ShopLoadingHomeState  extends ShopLayOutState {}

class ShopSuccessHomeState  extends ShopLayOutState {}

class ShopFailHomeState  extends ShopLayOutState {}

class ShopSuccessCategorieState  extends ShopLayOutState {}

class ShopFailCategorieState  extends ShopLayOutState {}

class ShopSuccessFavoriteState  extends ShopLayOutState {}

class ShopSuccessChangeFavoriteState  extends ShopLayOutState {

  final ChangedFavoriteModel? fav;

  ShopSuccessChangeFavoriteState({this.fav});
}

class ShopFailFavoriteState  extends ShopLayOutState {}

class ShopFailGetFavoriteState  extends ShopLayOutState {}

class ShopSuccessGetFavoriteState  extends ShopLayOutState {}
class ShopLoadingGetFavoriteState  extends ShopLayOutState {}

class ShopFailGetUserState  extends ShopLayOutState {}

class ShopSuccessGetUserState  extends ShopLayOutState {
  final ShopLoginModel? userModel;

  ShopSuccessGetUserState({this.userModel});
}

class ShopLoadingGetUserState  extends ShopLayOutState {}

class ShopFailUpdateUserState  extends ShopLayOutState {}

class ShopSuccessUpdateUserState  extends ShopLayOutState {
  final ShopLoginModel? userModel;

  ShopSuccessUpdateUserState({this.userModel});
}

class ShopLoadingUpdateUserState  extends ShopLayOutState {}



