import 'package:get/get.dart';
import 'package:zad_almumin/moduls/enums.dart';

class FilterChipProp {
  FilterChipProp({required this.text, required this.isSelected, required this.searchFilter});
  String text;
  RxBool isSelected;
  SearchFilter searchFilter;

  factory FilterChipProp.fromJson(Map<String, dynamic> json) => FilterChipProp(
        text: json["text"],
        isSelected: (json["isSelected"] as bool).obs,
        searchFilter: SearchFilter.values[json["searchFilter"]],
      );

  Map toJson() => {
        "text": text.toString(),
        "isSelected": isSelected.value,
        "searchFilter": searchFilter.index,
      };
}
