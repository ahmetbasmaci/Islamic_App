import 'package:flutter/material.dart';
import '../../tafseer.dart';

class TafssersListWidget extends StatelessWidget {
  final List<TafseerManagerModel> tafseerModels;
  const TafssersListWidget({super.key, required this.tafseerModels});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tafseerModels.length,
      itemBuilder: (context, index) {
        return TafseersListItem(tafseerModel: tafseerModels[index]);
      },
    );
  }
}
