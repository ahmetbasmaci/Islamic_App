part of 'quran_cubit.dart';

class QuranState extends Equatable {
  final Ayah selectedAyah;
  final String message;
  final bool showQuranImages;
  final bool showTafseerPage;
  final double quranFontSize;
  final SelectedPageInfo selectedPageInfo;
  final bool showTopFooterPart;
  final bool showInKahf;
  final bool isLoading;
  final double downloadProgress;
  const QuranState({
    required this.selectedAyah,
    required this.message,
    required this.showQuranImages,
    required this.showTafseerPage,
    required this.quranFontSize,
    required this.selectedPageInfo,
    required this.showTopFooterPart,
    required this.showInKahf,
    required this.isLoading,
    required this.downloadProgress,
  });

  factory QuranState.initial() {
    return QuranState(
      selectedAyah: Ayah.empty(),
      message: '',
      showQuranImages: true,
      showTafseerPage: false,
      quranFontSize: 20,
      selectedPageInfo: SelectedPageInfo.empty(),
      showTopFooterPart: false,
      showInKahf: false,
      isLoading: false,
      downloadProgress: 0,
    );
  }

  QuranState copyWith({
    Ayah? selectedAyah,
    String? message,
    bool? showQuranImages,
    bool? showTafseerPage,
    double? quranFontSize,
    SelectedPageInfo? selectedPageInfo,
    bool? showTopFooterPart,
    bool? showInKahf,
    bool? isLoading,
    double? downloadProgress,
  }) {
    return QuranState(
      selectedAyah: selectedAyah ?? this.selectedAyah,
      message: message ?? '',
      showQuranImages: showQuranImages ?? this.showQuranImages,
      showTafseerPage: showTafseerPage ?? this.showTafseerPage,
      quranFontSize: quranFontSize ?? this.quranFontSize,
      selectedPageInfo: selectedPageInfo ?? this.selectedPageInfo,
      showTopFooterPart: showTopFooterPart ?? this.showTopFooterPart,
      showInKahf: showInKahf ?? this.showInKahf,
      isLoading: isLoading ?? this.isLoading,
      downloadProgress: downloadProgress ?? this.downloadProgress,
    );
  }

  @override
  List<Object> get props => [
        selectedAyah,
        message,
        showQuranImages,
        showTafseerPage,
        quranFontSize,
        selectedPageInfo,
        showTopFooterPart,
        showInKahf,
        isLoading,
        downloadProgress,
      ];
}
