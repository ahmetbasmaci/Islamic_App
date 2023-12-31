import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../../../core/utils/enums/enums.dart';

class FilterChipModel extends Equatable {
  const FilterChipModel({required this.text, required this.isSelected, required this.searchFilter});
  final String text;
  final bool isSelected;
  final SearchFilter searchFilter;

  factory FilterChipModel.fromJson(dynamic json) => FilterChipModel(
        text: SearchFilter.values[json["searchFilter"]].translatedName,
        isSelected: (json["isSelected"] as bool),
        searchFilter: SearchFilter.values[json["searchFilter"]],
      );

  Map toJson() => {
        "isSelected": isSelected,
        "searchFilter": searchFilter.index,
      };

  FilterChipModel copyWith({
    String? text,
    bool? isSelected,
    SearchFilter? searchFilter,
  }) {
    return FilterChipModel(
      text: text ?? this.text,
      isSelected: isSelected ?? this.isSelected,
      searchFilter: searchFilter ?? this.searchFilter,
    );
  }

  @override
  List<Object> get props => [
        text,
        isSelected,
        searchFilter,
      ];
}
