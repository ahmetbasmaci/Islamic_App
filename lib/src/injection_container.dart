import 'package:get_it/get_it.dart';
import 'package:zad_almumin/core/packages/app_internet_connection/app_internet_connection.dart';
import 'package:zad_almumin/core/packages/location_detector/i_location_detector.dart';
import 'package:zad_almumin/core/utils/api/api_consumer.dart';
import 'package:zad_almumin/core/utils/api/http_consumer.dart';
import '../core/packages/audio_player/audio_player.dart';
import '../core/packages/local_storage/local_storage.dart';
import '../core/packages/location_detector/location_detector.dart';
import '../features/alarm/alarm.dart';
import '../features/azkar/azkar.dart';
import '../features/home/home.dart';
import '../features/locale/locale.dart';
import '../features/pray_times/pray_times.dart';
import '../features/quran/quran.dart';
import '../features/theme/theme.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initExternal();

  await _initTheme();
  await _initLcoale();
  await _initQuran();
  await _initAzkar();
  await _initAlarm();
  await _initPrayTimes();
  await _initHome();
}

Future _initExternal() async {
  //!External
  sl.registerLazySingleton(() => AudioPlayer());
  sl.registerLazySingleton<ILocalStorage>(() => LocalStorage());
  sl.registerLazySingleton<ApiConsumer>(() => HttpConsumer());
  sl.registerLazySingleton<IAppInternetConnection>(() => AppInternetConnection());
  sl.registerLazySingleton<ILocationDetector>(() => LocationDetector());
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
  sl.registerLazySingleton(() => HomeCardGetRandomAyahUseCase(quranDataRepository: sl()));
  sl.registerLazySingleton(() => HomeCardGetNextAyahUseCase(quranDataRepository: sl()));

  //!Cubit
  sl.registerFactory(() => HomeCubit());
  sl.registerFactory(() => HomeHadithCardCubit(
        homeCardGetRandomHadithUseCase: sl(),
      ));
  sl.registerFactory(() => HomeQuranCardCubit(
        homeCardGetRandomAyahUseCase: sl(),
        homeCardGetNextAyahUseCase: sl(),
      ));
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

Future _initPrayTimes() async {
//!DataSource
  sl.registerLazySingleton<IGetPrayTimeDataSource>(() => GetPrayTimeDataSource(
        apiConsumer: sl(),
        appInternetConnection: sl(),
      ));

  //!Repository
  sl.registerLazySingleton<IPrayTimesRepository>(
    () => PrayTimesRepository(getPrayTimeDataSource: sl()),
  );

  //!usecase
  sl.registerLazySingleton(() => GetPrayTimeUseCase(
        prayTimesRepository: sl(),
      ));

  //!Cubit
  sl.registerFactory(() => PrayTimesCubit(
        getPrayTimeseCase: sl(),
        locationDetector: sl(),
      ));
}

Future _initQuran() async {
//!DataSource
  QuranDataDataSource quranDataDataSource = QuranDataDataSource(localStorage: sl());
  await quranDataDataSource.loadSurahs();
  sl.registerLazySingleton<IQuranDataDataSource>(() => quranDataDataSource);

  //!Repository
  sl.registerLazySingleton<IQuranDataRepository>(
    () => QuranDataRepository(
      quranDataDataSource: sl(),
    ),
  );

  //!usecase

  //!Cubit
  sl.registerFactory(
    () => QuranCubit(
      quranDataRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => QuranSearchCubit(
      quranDataRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => QuranReaderCubit(
      quranDataRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => QuranEndDrawerCubit(
      quranDataRepository: sl(),
    ),
  );
}
