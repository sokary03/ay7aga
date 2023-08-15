abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

class GetBusinessSucessState extends NewsState {}

class NewsGetBusinessLoadingState extends NewsState {}

class GetBusinessFaiedState extends NewsState
{
  final String error;

  GetBusinessFaiedState({
    required this.error,
});

}

class GetSportsSucessState extends NewsState {}

class NewsGetSportsLoadingState extends NewsState {}

class GetSportsFaiedState extends NewsState
{
   final String error;

  GetSportsFaiedState({
    required this.error,
  });

}

class GetScienceSucessState extends NewsState {}

class NewsGetScienceLoadingState extends NewsState {}

class GetScienceFaiedState extends NewsState
{
  final String error;

  GetScienceFaiedState({
    required this.error,
  });

}

class GetSearchSucessState extends NewsState {}

class NewsGetSearchLoadingState extends NewsState {}

class GetSearchFaiedState extends NewsState
{
  final String error;

  GetSearchFaiedState({
    required this.error,
  });

}


