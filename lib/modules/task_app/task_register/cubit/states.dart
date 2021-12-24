abstract class TaskRegisterStates {}

class TaskRegisterInitialState extends TaskRegisterStates {}

class TaskRegisterLoadingState extends TaskRegisterStates {}

class TaskRegisterSuccessState extends TaskRegisterStates{}

class TaskRegisterErrorState extends TaskRegisterStates
{
  final String error;

  TaskRegisterErrorState(this.error);
}

class TaskCraetUserSuccessState extends TaskRegisterStates{}

class TaskCraetUserErrorState extends TaskRegisterStates
{
  final String error;

  TaskCraetUserErrorState(this.error);
}

class TaskRegisterChangePasswordVisibilityState extends TaskRegisterStates {}