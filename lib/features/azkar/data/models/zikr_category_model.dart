import '../../../../core/utils/enums/enums.dart';

class ZikrCategoryModel {
  final String title;
  final ZikrCategories category;
  final String imagePath;
  ZikrCategoryModel({
    required this.title,
    required this.category,
    required this.imagePath,
  });
}
/*
extension ZikrCategoriesExtention on ZikrCategories {
  String translatedTitle(BuildContext context) {
    switch (this) {
      case ZikrCategories.morning:
        return AppStrings.of(context).morningZikr;
      case ZikrCategories.evening:
        return AppStrings.of(context).eveningZikr;
      case ZikrCategories.sleep:
        return AppStrings.of(context).sleepZikr;
      case ZikrCategories.wakeUp:
        return AppStrings.of(context).wakeUpZikr;
      case ZikrCategories.home:
        return AppStrings.of(context).homeZikr;
      case ZikrCategories.travel:
        return AppStrings.of(context).travelZikr;
      case ZikrCategories.eating:
        return AppStrings.of(context).eatingZikr;
      case ZikrCategories.mosque:
        return AppStrings.of(context).mosqueZikr;
      case ZikrCategories.toilet:
        return AppStrings.of(context).toiletZikr;
      case ZikrCategories.haj:
        return AppStrings.of(context).hajZikr;
      case ZikrCategories.allahNames:
        return AppStrings.of(context).allahNamesZikr;
    }
  }
}

*/