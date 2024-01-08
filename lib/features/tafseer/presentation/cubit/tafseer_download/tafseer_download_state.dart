part of 'tafseer_download_cubit.dart';

class TafseerDownloadState extends Equatable {
  const TafseerDownloadState();

  @override
  List<Object> get props => [];
}

class TafseerDownloadInitialState extends TafseerDownloadState {}

class TafseerDownloadedState extends TafseerDownloadState {}

class TafseerDownloadErrorState extends TafseerDownloadState {
  final String message;

  const TafseerDownloadErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class TafseerDownloadDownloadingState extends TafseerDownloadState {
  final double progress;
  final TafseerManagerModel tafseerManagerModel;

  const TafseerDownloadDownloadingState({required this.progress, required this.tafseerManagerModel});

  @override
  List<Object> get props => [progress, tafseerManagerModel];
}
