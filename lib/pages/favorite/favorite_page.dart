import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_icons.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/moduls/enums.dart';
import '../../components/my_drawer.dart';
import 'favorite_body.dart';
import 'favorite_page_ctr.dart';
import 'favorite_search_delegate.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  static const id = 'FavoritePage';
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  GetStorage getStorage = GetStorage();
  FavoriteCtr favoriteCtr = Get.find<FavoriteCtr>();
  @override
  void initState() {
    super.initState();
    favoriteCtr.selectedZikrType.value = ZikrType.values[getStorage.read('selectedZikrType') ?? 0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'المفضلة',
          actions: [
            MyIcons.menu(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MySiezes.cardPadding),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ZikrType>(
                    iconEnabledColor: MyColors.primary(),
                    value: favoriteCtr.selectedZikrType.value,
                    items: [
                      DropdownMenuItem(value: ZikrType.all, child: MyTexts.dropDownMenuItem(title: 'الكل')),
                      DropdownMenuItem(
                          value: ZikrType.allahNames, child: MyTexts.dropDownMenuItem(title: 'أسماء الله')),
                      DropdownMenuItem(value: ZikrType.azkar, child: MyTexts.dropDownMenuItem(title: 'الأذكار')),
                      DropdownMenuItem(value: ZikrType.quran, child: MyTexts.dropDownMenuItem(title: 'القرآن')),
                      DropdownMenuItem(value: ZikrType.hadith, child: MyTexts.dropDownMenuItem(title: 'الحديث')),
                    ],
                    onChanged: (newSelectedType) {
                      getStorage.write('selectedZikrType', newSelectedType!.index);
                      setState(() => favoriteCtr.selectedZikrType.value = newSelectedType);
                    }),
              ),
            ),
            IconButton(
              icon: MyIcons.search(),
              onPressed: () => showSearch(context: context, delegate: FavoriteSearchDelegate()),
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: FavoriteBody());
  }
}
