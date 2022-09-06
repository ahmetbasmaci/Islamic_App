import 'package:get/state_manager.dart';

import '../../moduls/enums.dart';

class FavoriteCtr extends GetxController{
    Rx<ZikrType> selectedZikrType = ZikrType.all.obs;
}