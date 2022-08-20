abstract class NewsStates {}

class NewsIntialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}
class NewsGetBusinessSuccessSatate extends NewsStates {}
class NewsGetBusinessErrorSatate extends NewsStates {
  final Error;

  NewsGetBusinessErrorSatate(this.Error);
}
class NewsGetBusinessLoadingSatate extends NewsStates {}
class NewsGetSportsSuccessSatate extends NewsStates {}
class NewsGetSportsErrorSatate extends NewsStates {
  final Error;

  NewsGetSportsErrorSatate(this.Error);
}
class NewsGetSportsLoadingSatate extends NewsStates {}

class NewsGetScienceSuccessSatate extends NewsStates {}
class NewsGetScienceErrorSatate extends NewsStates {
  final Error;

  NewsGetScienceErrorSatate(this.Error);
}
class NewsGetScienceLoadingSatate extends NewsStates {}
class NewsGetSearchSuccessSatate extends NewsStates {}
class NewsGetSearchErrorSatate extends NewsStates {
  final Error;

  NewsGetSearchErrorSatate(this.Error);
}
class NewsGetSearchLoadingSatate extends NewsStates {}
