part of 'home_quran_card_cubit.dart';

abstract class HomeQuranCardState extends Equatable {
  const HomeQuranCardState();

  @override
  List<Object> get props => [];
}

class HomeQuranCardInitialState extends HomeQuranCardState {}

class HomeQuranCardLoadingState extends HomeQuranCardState {}

class HomeQuranCardLoadedState extends HomeQuranCardState {
  QuranCardModel quranCardModel;

  HomeQuranCardLoadedState({required this.quranCardModel});
}

class HomeQuranCardErrorState extends HomeQuranCardState {
  String message;

  HomeQuranCardErrorState({required this.message});
}

class HomeQuranCardAudioPlayingState extends HomeQuranCardState {}
