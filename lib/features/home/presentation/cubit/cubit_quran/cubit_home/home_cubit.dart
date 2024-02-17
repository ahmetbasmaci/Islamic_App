import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/helpers/pages_helper.dart';
import 'package:zad_almumin/core/utils/app_router.dart';
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
