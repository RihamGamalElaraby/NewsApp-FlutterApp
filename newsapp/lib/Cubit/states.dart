abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class AppChangeModeStates extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSucssesState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetScientificLoadingState extends NewsStates {}

class NewsGetScientificSucssesState extends NewsStates {}

class NewsGetScientificErrorState extends NewsStates {
  final String error;
  NewsGetScientificErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSucssesState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetsearchLoadingState extends NewsStates {}

class NewsGetsearchSucssesState extends NewsStates {}

class NewsGetsearchErrorState extends NewsStates {
  final String error;
  NewsGetsearchErrorState(this.error);
}
