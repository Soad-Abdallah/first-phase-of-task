abstract class NewsStates{}
 
class NewsIntialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccessStete extends NewsStates{}

class NewsGetBusinessErrorStete extends NewsStates{
  late final String error;
  NewsGetBusinessErrorStete(this.error);
}

class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsSuccessStete extends NewsStates{}

class NewsGetSportsErrorStete extends NewsStates{
  late final String error;
  NewsGetSportsErrorStete(this.error);
}

class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceSuccessStete extends NewsStates{}

class NewsGetScienceErrorStete extends NewsStates{
  late final String error;
  NewsGetScienceErrorStete(this.error);
}


class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchSuccessStete extends NewsStates{}

class NewsGetSearchErrorStete extends NewsStates{
  late final String error;
  NewsGetSearchErrorStete(this.error);
}