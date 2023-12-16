part of 'home_hadith_card_cubit.dart';

abstract class HomeHadithCardState extends Equatable {
  const HomeHadithCardState();

  @override
  List<Object> get props => [];
}

class HomeHadithCardInitial extends HomeHadithCardState {}

class HomeHadithCardLoadingState extends HomeHadithCardState {}

class HomeHadithCardLoadedState extends HomeHadithCardState {
  final HadithCardModel hadithCardModel;
  HomeHadithCardLoadedState({required this.hadithCardModel});

  @override
  List<Object> get props => [hadithCardModel];
}

class HomeHadithCardFieldState extends HomeHadithCardState {
  final String message;
  HomeHadithCardFieldState(this.message);
  @override
  List<Object> get props => [message];
}
