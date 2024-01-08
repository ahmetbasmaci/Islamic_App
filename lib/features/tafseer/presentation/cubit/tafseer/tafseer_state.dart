part of 'tafseer_cubit.dart';

class TafseerState extends Equatable {
  final int selectedTafseerIdAr;
  final int selectedTafseerIdEn;
  final List<TafseerManagerModel> tafseerModels;
  final String message;
  final bool loading;
  const TafseerState({
    required this.selectedTafseerIdAr,
    required this.selectedTafseerIdEn,
    required this.tafseerModels,
    required this.message,
    required this.loading,
  });
  TafseerState.init()
      : selectedTafseerIdAr = 0,
        selectedTafseerIdEn = 0,
        tafseerModels = [],
        message = '',
        loading = true;
  TafseerState copyWith({
    int? selectedTafseerIdAr,
    int? selectedTafseerIdEn,
    List<TafseerManagerModel>? tafseerModels,
    String? message,
  }) {
    return TafseerState(
      selectedTafseerIdAr: selectedTafseerIdAr ?? this.selectedTafseerIdAr,
      selectedTafseerIdEn: selectedTafseerIdEn ?? this.selectedTafseerIdEn,
      tafseerModels: tafseerModels ?? this.tafseerModels,
      message: message ?? '',
      loading: false,
    );
  }

  @override
  List<Object> get props => [selectedTafseerIdAr, selectedTafseerIdEn, tafseerModels, message];
}
