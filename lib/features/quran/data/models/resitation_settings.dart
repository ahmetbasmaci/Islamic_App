import 'package:equatable/equatable.dart';

import '../../quran.dart';

class ResitationSettings extends Equatable {
  final Ayah startAyah;
  final Ayah endAyah;
  final Surah surah;
  final int repeetAllCount;
  final int repeetAyahCount;
  final bool isUnlimitRepeatAll;
  final bool isUnlimitRepeatAyah;

  const ResitationSettings({
    required this.startAyah,
    required this.endAyah,
    required this.surah,
    required this.repeetAllCount,
    required this.repeetAyahCount,
    required this.isUnlimitRepeatAll,
    required this.isUnlimitRepeatAyah,
  });

  factory ResitationSettings.initial() {
    return ResitationSettings(
      startAyah: Ayah.empty(),
      endAyah: Ayah.empty(),
      surah: Surah.empty(),
      repeetAllCount: 0,
      repeetAyahCount: 0,
      isUnlimitRepeatAll: false,
      isUnlimitRepeatAyah: false,
    );
  }

  ResitationSettings copyWith({
    Ayah? startAyah,
    Ayah? endAyah,
    Surah? surah,
    int? repeetAllCount,
    int? repeetAyahCount,
    bool? isUnlimitRepeatAll,
    bool? isUnlimitRepeatAyah,
  }) {
    return ResitationSettings(
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      surah: surah ?? this.surah,
      repeetAllCount: repeetAllCount ?? this.repeetAllCount,
      repeetAyahCount: repeetAyahCount ?? this.repeetAyahCount,
      isUnlimitRepeatAll: isUnlimitRepeatAll ?? this.isUnlimitRepeatAll,
      isUnlimitRepeatAyah: isUnlimitRepeatAyah ?? this.isUnlimitRepeatAyah,
    );
  }

  @override
  List<Object?> get props => [
        startAyah,
        endAyah,
        surah,
        repeetAllCount,
        repeetAyahCount,
        isUnlimitRepeatAll,
        isUnlimitRepeatAyah,
      ];
}
