import 'package:fristapp/model/shop_app/login_model.dart';

abstract class TaskLoginStates {}

class TaskLoginInitialState extends TaskLoginStates {}
class TaskLoginLoadingState extends TaskLoginStates {}
class TaskLoginSuccessState extends TaskLoginStates {
  late final String uId;
  TaskLoginSuccessState(
    this.uId,
  );

}
class TaskLoginErrorState extends TaskLoginStates {
  late final String Error;
  TaskLoginErrorState(this.Error);
}

class TaskChangePasswordVisibilityState extends TaskLoginStates {}

