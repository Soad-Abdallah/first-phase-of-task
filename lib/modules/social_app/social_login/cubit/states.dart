import 'package:fristapp/model/shop_app/login_model.dart';

abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}
class SocialLoginLoadingState extends SocialLoginStates {}
class SocialLoginSuccessState extends SocialLoginStates {
  late final String uId;
  SocialLoginSuccessState(
    this.uId,
  );

}
class SocialLoginErrorState extends SocialLoginStates {
  late final String Error;
  SocialLoginErrorState(this.Error);
}

class SocialChangePasswordVisibilityState extends SocialLoginStates {}

