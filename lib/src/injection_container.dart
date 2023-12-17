import 'package:get_it/get_it.dart';
import '../core/packages/audio_player/audio_player.dart';
import '../core/packages/local_storage/local_storage.dart';
import '../features/alarm/alarm.dart';
import '../features/azkar/azkar.dart';
import '../features/home/home.dart';
import '../features/locale/locale.dart';
import '../features/theme/theme.dart';

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
  sl.registerLazySingleton<IAlarmGetDatapartDataSource>(() => AlarmGetDatapartDataSource(
        localStorage: sl(),
      ));

  //!Repository
  sl.registerLazySingleton<IAlarmRepository>(
    () => AlarmRepository(alarmGetDatapartDataSource: sl()),
  );

  //!usecase
  sl.registerLazySingleton(() => GetAlarmPartDataUseCase(alarmrepository: sl()));
  sl.registerLazySingleton(() => UpdateAlarmModelUseCase(alarmrepository: sl()));

  //!Cubit

  sl.registerFactory(() => AlarmCubit(
        getAlarmPartDataUseCase: sl(),
        triggerAlarmActivatingUseCase: sl(),
      ));
}
