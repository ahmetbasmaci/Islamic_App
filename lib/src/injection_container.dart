import 'package:get_it/get_it.dart';
import '../core/packages/audio_player/audio_player.dart';
import '../core/packages/local_storage/local_storage.dart';
import '../features/alarm/data/datasources/alarm_get_datapart_data_source.dart';
import '../features/alarm/domain/repositories/i_alarm_repository.dart';
import '../features/alarm/domain/usecases/get_alarm_part_data_use_case.dart';
import '../features/alarm/presentation/cubit/alarm_cubit.dart';
import '../features/home/presentation/cubit/cubit_quran/cubit_quran_audio_button/home_quran_audio_button_cubit.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/locale/cubit/locale_cubit.dart';
import '../features/theme/cubit/theme_cubit.dart';
import '../features/alarm/data/repositories/alarm_repository.dart';
import '../features/azkar/azkar.dart';
import '../features/home/data/datasources/home_card_get_random_hadith_data_source/home_card_get_random_hadith_data_source.dart';
import '../features/home/data/datasources/home_card_play_single_audio_data_source.dart';
import '../features/home/data/repositories/home_repository.dart';
import '../features/home/domain/repositories/i_home_repository.dart';
import '../features/home/domain/usecases/home_card_get_random_hadith_use_case.dart';
import '../features/home/domain/usecases/home_card_play_pause_single_audio_use_case.dart';
import '../features/home/presentation/cubit/cubit_hadith/home_hadith_card_cubit.dart';
import '../features/home/presentation/cubit/cubit_quran/home_quran_card_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
//!External

  sl.registerLazySingleton<ILocalStorage>(() => LocalStorage());
  sl.registerLazySingleton(() => AudioPlayer());

  await _initTheme();
  await _initLcoale();
  await _initHome();
  await _initAzkar();
  await _initAlarm();
}

Future _initTheme() async {
  //!Cubit
  sl.registerFactory(() => ThemeCubit(localStorage: sl()));
}

Future _initLcoale() async {
  //!Cubit
  sl.registerFactory(() => LocaleCubit(localStorage: sl()));
}

Future _initHome() async {
//!DataSource
  sl.registerLazySingleton<IHomeCardPlayPauseSingleAudioDataSource>(
      () => HomeCardPlayPauseSingleAudioDataSource(audioService: sl()));
  sl.registerLazySingleton<IHomeCardGetRandomHadithDataSource>(() => HomeCardGetRandomHadithDataSource());

  //!Repository
  sl.registerLazySingleton<IHomeRepository>(
    () => HomeRepository(
      homeCardPlayPauseSingleAudioDataSource: sl(),
      homeCardGetRandomHadithDataSource: sl(),
    ),
  );

  //!usecase
  sl.registerLazySingleton(() => HomeCardPlayPauseSingleAudioUseCase(repository: sl()));
  sl.registerLazySingleton(() => HomeCardGetRandomHadithUseCase(repository: sl()));

  //!Cubit
  sl.registerFactory(() => HomeCubit());
  sl.registerFactory(() => HomeHadithCardCubit(
        homeCardGetRandomHadithUseCase: sl(),
      ));
  sl.registerFactory(() => HomeQuranCardCubit());
  sl.registerFactory(() => HomeQuranAudioButtonCubit(playPauseSingleAudioUseCase: sl()));
}

Future _initAzkar() async {
//!DataSource
  sl.registerLazySingleton<IZikrCardGetZikrDataSource>(() => ZikrCardGetZikrDataSource());
  sl.registerLazySingleton<IZikrCardGetAllahNamesDataSource>(() => ZikrCardGetAllahNamesDataSource());

  //!Repository
  sl.registerLazySingleton<IAzkarRepository>(
    () => AzkarRepository(
      zikrCardGetZikrDataSource: sl(),
      zikrCardGetAllahNamesDataSource: sl(),
    ),
  );

  //!usecase
  sl.registerLazySingleton(() => ZikrCardGetZikrUseCase(azkarRepository: sl()));
  sl.registerLazySingleton(() => ZikrCardGetAllahNamesUseCase(azkarRepository: sl()));

  //!Cubit

  sl.registerFactory(() => AzkarCubit(
        zikrCardGetZikrUseCase: sl(),
        zikrCardGetAllahNamesUseCase: sl(),
      ));
}

Future _initAlarm() async {
//!DataSource
  sl.registerLazySingleton<IAlarmGetDatapartDataSource>(() => AlarmGetDatapartDataSource());

  //!Repository
  sl.registerLazySingleton<IAlarmRepository>(
    () => AlarmRepository(alarmGetDatapartDataSource: sl()),
  );

  //!usecase
  sl.registerLazySingleton(() => GetAlarmPartDataUseCase(alarmrepository: sl()));

  //!Cubit

  sl.registerFactory(() => AlarmCubit(
        getAlarmPartDataUseCase: sl(),
      ));
}
