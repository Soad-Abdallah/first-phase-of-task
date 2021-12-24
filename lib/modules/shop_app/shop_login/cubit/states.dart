import 'package:fristapp/model/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}
class ShopLoginLoadingState extends ShopLoginStates {}
class ShopLoginSuccessState extends ShopLoginStates {
  late final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginStates {
  late final String Error;
  ShopLoginErrorState(this.Error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}

