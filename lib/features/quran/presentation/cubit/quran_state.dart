part of 'quran_cubit.dart';

class QuranState extends Equatable {
  final Ayah selectedAyah;
  final String message;
  final bool showQuranImages;
  final bool showTafseerPage;
  final double quranFontSize;
  final SelectedPageInfo selectedPage;
  final bool topFooterPartIsVisable;
  final bool showInKahf;
  const QuranState({
    required this.selectedAyah,
    required this.message,
    required this.showQuranImages,
    required this.showTafseerPage,
    required this.quranFontSize,
    required this.selectedPage,
    required this.topFooterPartIsVisable,
    required this.showInKahf,
  });

  factory QuranState.initial() {
    return QuranState(
      selectedAyah: Ayah.empty(),
      message: '',
      showQuranImages: true,
      showTafseerPage: false,
      quranFontSize: 20,
      selectedPage: SelectedPageInfo.empty(),
      topFooterPartIsVisable: false,
      showInKahf: false,
    );
  }

  QuranState copyWith({
    Ayah? selectedAyah,
    String? message,
    bool? showQuranImages,
    bool? showTafseerPage,
    double? quranFontSize,
    SelectedPageInfo? selectedPage,
    bool? topFooterPartIsVisable,
    bool? showInKahf,
  }) {
    return QuranState(
      selectedAyah: selectedAyah ?? this.selectedAyah,
      message: message ?? '',
      showQuranImages: showQuranImages ?? this.showQuranImages,
      showTafseerPage: showTafseerPage ?? this.showTafseerPage,
      quranFontSize: quranFontSize ?? this.quranFontSize,
      selectedPage: selectedPage ?? this.selectedPage,
      topFooterPartIsVisable: topFooterPartIsVisable ?? this.topFooterPartIsVisable,
      showInKahf: showInKahf ?? this.showInKahf,
    );
  }

  @override
  List<Object> get props => [
        selectedAyah,
        message,
        showQuranImages,
        showTafseerPage,
        quranFontSize,
        selectedPage,
        topFooterPartIsVisable,
        showInKahf,
      ];
}
