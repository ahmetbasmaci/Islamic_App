part of 'azkar_cubit.dart';

abstract class AzkarState extends Equatable {
  const AzkarState();

  @override
  List<Object> get props => [];
}

class AzkarpageInitialState extends AzkarState {}

class AzkarpageLoadingState extends AzkarState {}

class AzkarpageLoadedState extends AzkarState {
  final List<ZikrCardModel> zikrDataList;
  final List<AllahNamesModel> allahNamesDataList;

  AzkarpageLoadedState({
    List<ZikrCardModel>? zikrDataList,
    List<AllahNamesModel>? allahNamesDataList,
  })  : zikrDataList = zikrDataList ?? [],
        allahNamesDataList = allahNamesDataList ?? [];
}

class AzkarpageFieldState extends AzkarState {
  final String message;

  AzkarpageFieldState(this.message);
}
