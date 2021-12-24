abstract class TaskStates {}

class TaskInitialState extends TaskStates {}

class TaskAddUserLoadingState extends TaskStates {}
class TaskAddUserSuccessState extends TaskStates {}
class TaskAddUserErrorsState extends TaskStates {
  late final String Error;
  TaskAddUserErrorsState(this.Error);
}

class TaskGetUserLoadingState extends TaskStates {}
class TaskGetUserSuccessState extends TaskStates {}
class TaskGetUserErrorState extends TaskStates
{
  final String error;
  TaskGetUserErrorState(this.error);
}

class TaskChangeBottomNavState extends TaskStates {}