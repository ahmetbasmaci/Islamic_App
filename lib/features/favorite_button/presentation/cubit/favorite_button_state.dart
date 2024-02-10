part of 'favorite_button_cubit.dart';

abstract class FavoriteButtonState extends Equatable {
  final bool isFavorite;
  const FavoriteButtonState({required this.isFavorite});

  @override
  List<Object> get props => [];
}

class FavoriteButtonInitialState extends FavoriteButtonState {
  const FavoriteButtonInitialState({bool? isFavorite}) : super(isFavorite: isFavorite ?? false);
}

class FavoriteButtonErrorState extends FavoriteButtonState {
  const FavoriteButtonErrorState() : super(isFavorite: false);
}

class FavoriteButtonInitial extends FavoriteButtonState {
  const FavoriteButtonInitial() : super(isFavorite: false);
}
