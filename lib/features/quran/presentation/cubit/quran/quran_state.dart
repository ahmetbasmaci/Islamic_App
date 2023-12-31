part of 'quran_cubit.dart';

class QuranState extends Equatable {
  final Ayah selectedAyah;
  final String message;
  final bool quranViewModeInImages;
  final bool showTafseerPage;
  final double quranFontSize;
  final SelectedPageInfo selectedPageInfo;
  final bool showTopFooterPart;
  final bool isLoading;
  final double downloadProgress;
  const QuranState({
    required this.selectedAyah,
    required this.message,
    required this.quranViewModeInImages,
    required this.showTafseerPage,
    required this.quranFontSize,
    required this.selectedPageInfo,
    required this.showTopFooterPart,
    required this.isLoading,
    required this.downloadProgress,
  });

  factory QuranState.initial() {
    return QuranState(
      selectedAyah: Ayah.empty(),
      message: '',
      quranViewModeInImages: true,
      showTafseerPage: false,
      quranFontSize: AppSizes.minQuranFontSize,
      selectedPageInfo: SelectedPageInfo.empty(),
      showTopFooterPart: false,
      isLoading: false,
      downloadProgress: 0,
    );
  }

  QuranState copyWith({
    Ayah? selectedAyah,
    String? message,
    bool? quranViewModeInImages,
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
      quranViewModeInImages: quranViewModeInImages ?? this.quranViewModeInImages,
      showTafseerPage: showTafseerPage ?? this.showTafseerPage,
      quranFontSize: quranFontSize ?? this.quranFontSize,
      selectedPageInfo: selectedPageInfo ?? this.selectedPageInfo,
      showTopFooterPart: showTopFooterPart ?? this.showTopFooterPart,
      isLoading: isLoading ?? this.isLoading,
      downloadProgress: downloadProgress ?? this.downloadProgress,
    );
  }

  @override
  List<Object> get props => [
        selectedAyah,
        message,
        quranViewModeInImages,
        showTafseerPage,
        quranFontSize,
        selectedPageInfo,
        showTopFooterPart,
        isLoading,
        downloadProgress,
      ];
}