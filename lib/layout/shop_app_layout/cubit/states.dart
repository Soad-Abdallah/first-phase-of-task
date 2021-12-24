import 'package:fristapp/model/shop_app/favorites_model.dart';

abstract class ShopStates{}

class ShopIntialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}


class ShopChangePasswordVisibilityState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}
class ShopHomeSuccessState extends ShopStates {
  // late final ShopLoginModel loginModel;
  // ShopHomeSuccessState(this.loginModel);
}
class ShopHomeErrorState extends ShopStates {
  // late final String Error;
  // ShopHomeErrorState(this.Error);
}

class ShopCategoriesSuccessState extends ShopStates {
  // late final ShopLoginModel loginModel;
  // ShopHomeSuccessState(this.loginModel);
}
class ShopCategoriesErrorState extends ShopStates {
  // late final String Error;
  // ShopHomeErrorState(this.Error);
}

class ShopChangeFavoriteState extends ShopStates {}
class ShopChangeFavoritesSuccessState extends ShopStates {
  late final ChangeFavoritesModel model;
  ShopChangeFavoritesSuccessState(this.model);
}
class ShopChangeFavoritesErrorState extends ShopStates {}