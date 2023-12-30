import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/helpers/pages_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void updateLastOpenedPageId() {
    PagesHelper.setLastOpendPageId(AppRoutes.home);
  }

  void updatePrayerTimesOnLoad() {
    //TODO
    //Get.find<PrayerTimeCtr>().updatePrayerTimesOnLoad();
  }
}
