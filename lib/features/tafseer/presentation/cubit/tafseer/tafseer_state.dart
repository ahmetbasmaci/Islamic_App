part of 'tafseer_cubit.dart';

class TafseerState extends Equatable {
  final SelectedTafseerIdModel selectedTafseerId;
  final List<TafseerManagerModel> tafseerModels;
  final String message;
  final bool loading;
  const TafseerState({
    required this.selectedTafseerId,
    required this.tafseerModels,
    required this.message,
    required this.loading,
  });
  TafseerState.init()
      : selectedTafseerId = const SelectedTafseerIdModel.init(),
        tafseerModels = [],
        message = '',
        loading = true;
  TafseerState copyWith({
    SelectedTafseerIdModel? selectedTafseerId,
    List<TafseerManagerModel>? tafseerModels,
    String? message,
  }) {
    return TafseerState(
      selectedTafseerId: selectedTafseerId ?? this.selectedTafseerId,
      tafseerModels: tafseerModels ?? this.tafseerModels,
      message: message ?? '',
      loading: false,
    );
  }

  @override
  List<Object> get props => [selectedTafseerId, tafseerModels, message, loading];
}
