import 'package:get/get.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {"tr": tr, "en": en};

  Map<String, String> get tr => {
        "تنشيط الوضع اليلي": "Gece Modunu Aktif Et",
        "2": "asdas",
      };
  Map<String, String> get en => {
        "تنشيط الوضع اليلي": "Activate Dark Mode",
        "2": "asdas",
      };
}
