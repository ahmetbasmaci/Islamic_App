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
  final ResitationSettings resitationSettings;
  final List<MarkedPage> markedList;
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
    required this.resitationSettings,
    required this.markedList,
  });

  factory QuranState.initial() {
    return QuranState(
      selectedAyah: Ayah.empty(),
      message: '',
      quranViewModeInImages: true,
      showTafseerPage: false,
      quranFontSize: AppSizes.minQuranFontSize,
      selectedPageInfo: const SelectedPageInfo.empty(),
      showTopFooterPart: false,
      isLoading: false,
      downloadProgress: 0,
      resitationSettings: ResitationSettings.initial(),
      markedList: [],
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
    ResitationSettings? resitationSettings,
    List<MarkedPage>? markedList,
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
      resitationSettings: resitationSettings ?? this.resitationSettings,
      markedList: markedList ?? this.markedList,
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
        resitationSettings,
        markedList,
      ];
}
