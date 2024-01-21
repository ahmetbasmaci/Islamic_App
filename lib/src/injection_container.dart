import 'package:get_it/get_it.dart';
import 'package:zad_almumin/core/packages/app_internet_connection/app_internet_connection.dart';
import 'package:zad_almumin/core/packages/location_detector/i_location_detector.dart';
import 'package:zad_almumin/core/services/files_service.dart';
import 'package:zad_almumin/core/services/json_service.dart';
import 'package:zad_almumin/core/utils/api/api.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';
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

class GetItManager {
  GetItManager._();
  static final _instance = GetItManager._();
  static GetItManager get instance => _instance;

  Future<void> init() async {
    await _initExternal();

    await _initTheme();
    await _initLcoale();
    await _initQuran();
    await _initAzkar();
    await _initAlarm();
    await _initPrayTimes();
    await _initHome();
    await _initTafseer();
  }

  ThemeCubit get themeCubit => _sl<ThemeCubit>();
  LocaleCubit get localeCubit => _sl<LocaleCubit>();

  HomeCubit get homeCubit => _sl<HomeCubit>();
  HomeHadithCardCubit get homeHadithCardCubit => _sl<HomeHadithCardCubit>();
  HomeQuranCardCubit get homeQuranCardCubit => _sl<HomeQuranCardCubit>();
  HomeQuranAudioButtonCubit get homeQuranAudioButtonCubit => _sl<HomeQuranAudioButtonCubit>();

  AzkarCubit get azkarCubit => _sl<AzkarCubit>();
  AlarmCubit get alarmCubit => _sl<AlarmCubit>();

  PrayTimesCubit get prayTimesCubit => _sl<PrayTimesCubit>();

  QuranCubit get quranCubit => _sl<QuranCubit>();
  QuranSearchCubit get quranSearchCubit => _sl<QuranSearchCubit>();
  QuranReaderCubit get quranReaderCubit => _sl<QuranReaderCubit>();
  QuranEndDrawerCubit get quranEndDrawerCubit => _sl<QuranEndDrawerCubit>();

  TafseerCubit get tafseerCubit => _sl<TafseerCubit>();
  TafseerDownloadCubit get tafseerDownloadCubit => _sl<TafseerDownloadCubit>();

  final _sl = GetIt.instance;

  Future _initExternal() async {
    //!External
    _sl.registerLazySingleton(() => AudioPlayer());
    _sl.registerLazySingleton<ILocalStorage>(() => LocalStorage());
    _sl.registerLazySingleton<ApiConsumer>(() => HttpConsumer());
    _sl.registerLazySingleton<IAppInternetConnection>(() => AppInternetConnection());
    _sl.registerLazySingleton<ILocationDetector>(() => LocationDetector());
    _sl.registerLazySingleton<IJsonService>(() => JsonService());
    _sl.registerLazySingleton<IFilesService>(() => FilesService());
    _sl.registerLazySingleton<IFirebaseStorageConsumer>(() => FirebaseStorageConsumer());
  }

  Future _initTheme() async {
    //!Cubit
    _sl.registerFactory(() => ThemeCubit(localStorage: _sl()));
  }

  Future _initLcoale() async {
    //!Cubit
    _sl.registerFactory(() => LocaleCubit(localStorage: _sl()));
  }

  Future _initHome() async {
//!DataSource
    _sl.registerLazySingleton<IHomeCardPlayPauseSingleAudioDataSource>(
        () => HomeCardPlayPauseSingleAudioDataSource(audioService: _sl()));
    _sl.registerLazySingleton<IHomeCardGetRandomHadithDataSource>(() => HomeCardGetRandomHadithDataSource(
          jsonService: _sl(),
        ));

    //!Repository
    _sl.registerLazySingleton<IHomeRepository>(
      () => HomeRepository(
        homeCardPlayPauseSingleAudioDataSource: _sl(),
        homeCardGetRandomHadithDataSource: _sl(),
      ),
    );

    //!usecase
    _sl.registerLazySingleton(() => HomeCardPlayPauseSingleAudioUseCase(repository: _sl()));
    _sl.registerLazySingleton(() => HomeCardGetRandomHadithUseCase(repository: _sl()));
    _sl.registerLazySingleton(() => HomeCardGetRandomAyahUseCase(quranDataRepository: _sl()));
    _sl.registerLazySingleton(() => HomeCardGetNextAyahUseCase(quranDataRepository: _sl()));

    //!Cubit
    _sl.registerFactory(() => HomeCubit());
    _sl.registerFactory(() => HomeHadithCardCubit(
          homeCardGetRandomHadithUseCase: _sl(),
        ));
    _sl.registerFactory(() => HomeQuranCardCubit(
          homeCardGetRandomAyahUseCase: _sl(),
          homeCardGetNextAyahUseCase: _sl(),
        ));
    _sl.registerFactory(() => HomeQuranAudioButtonCubit(playPauseSingleAudioUseCase: _sl()));
  }

  Future _initAzkar() async {
//!DataSource
    _sl.registerLazySingleton<IZikrCardGetZikrDataSource>(() => ZikrCardGetZikrDataSource(
          jsonService: _sl(),
        ));
    _sl.registerLazySingleton<IZikrCardGetAllahNamesDataSource>(() => ZikrCardGetAllahNamesDataSource(
          jsonService: _sl(),
        ));

    //!Repository
    _sl.registerLazySingleton<IAzkarRepository>(
      () => AzkarRepository(
        zikrCardGetZikrDataSource: _sl(),
        zikrCardGetAllahNamesDataSource: _sl(),
      ),
    );

    //!usecase
    _sl.registerLazySingleton(() => ZikrCardGetZikrUseCase(azkarRepository: _sl()));
    _sl.registerLazySingleton(() => ZikrCardGetAllahNamesUseCase(azkarRepository: _sl()));

    //!Cubit

    _sl.registerFactory(() => AzkarCubit(
          zikrCardGetZikrUseCase: _sl(),
          zikrCardGetAllahNamesUseCase: _sl(),
        ));
  }

  Future _initAlarm() async {
//!DataSource
    _sl.registerLazySingleton<IAlarmGetDatapartDataSource>(() => AlarmGetDatapartDataSource(
          localStorage: _sl(),
        ));

    //!Repository
    _sl.registerLazySingleton<IAlarmRepository>(
      () => AlarmRepository(alarmGetDatapartDataSource: _sl()),
    );

    //!usecase
    _sl.registerLazySingleton(() => GetAlarmPartDataUseCase(alarmrepository: _sl()));
    _sl.registerLazySingleton(() => UpdateAlarmModelUseCase(alarmrepository: _sl()));

    //!Cubit

    _sl.registerFactory(() => AlarmCubit(
          getAlarmPartDataUseCase: _sl(),
          triggerAlarmActivatingUseCase: _sl(),
        ));
  }

  Future _initPrayTimes() async {
//!DataSource
    _sl.registerLazySingleton<IGetPrayTimeDataSource>(() => GetPrayTimeDataSource(
          apiConsumer: _sl(),
          appInternetConnection: _sl(),
        ));

    //!Repository
    _sl.registerLazySingleton<IPrayTimesRepository>(
      () => PrayTimesRepository(getPrayTimeDataSource: _sl()),
    );

    //!usecase
    _sl.registerLazySingleton(() => GetPrayTimeUseCase(
          prayTimesRepository: _sl(),
        ));

    //!Cubit
    _sl.registerFactory(() => PrayTimesCubit(
          getPrayTimeseCase: _sl(),
          locationDetector: _sl(),
        ));
  }

  Future _initQuran() async {
//!DataSource
    QuranDataDataSource quranDataDataSource = QuranDataDataSource(localStorage: _sl(), jsonService: _sl());
    await quranDataDataSource.loadSurahs();
    _sl.registerLazySingleton<IQuranDataDataSource>(() => quranDataDataSource);

    //!Repository
    _sl.registerLazySingleton<IQuranDataRepository>(
      () => QuranDataRepository(
        quranDataDataSource: _sl(),
      ),
    );

    //!usecase

    //!Cubit
    _sl.registerFactory(
      () => QuranCubit(
        quranDataRepository: _sl(),
        tafseerManagerRepository: _sl(),
      ),
    );
    _sl.registerFactory(
      () => QuranSearchCubit(
        quranDataRepository: _sl(),
      ),
    );
    _sl.registerFactory(
      () => QuranReaderCubit(
        quranDataRepository: _sl(),
      ),
    );
    _sl.registerFactory(
      () => QuranEndDrawerCubit(
        quranDataRepository: _sl(),
      ),
    );
  }

  Future _initTafseer() async {
//!DataSource
    _sl.registerLazySingleton<ITafseerManagertaSource>(() => TafseerManagerDataSource(
          jsonService: _sl(),
          filesService: _sl(),
        ));
    _sl.registerLazySingleton<ITafseerDownloaderDataSource>(() => TafseerDownloaderDataSource(
          firebaseStorageConsumer: _sl(),
          apiConsumer: _sl(),
        ));
    _sl.registerLazySingleton<ITafseerFileDataSource>(() => TafseerFileDataSource(
          filesService: _sl(),
        ));
    _sl.registerLazySingleton<ITafseerSelectedDataSource>(() => TafseerSelectedDataSource(
          localStorage: _sl(),
          filesService: _sl(),
        ));

    //!Repository
    _sl.registerLazySingleton<ITafseerRepository>(
      () => TafseerRepository(
        tafseerManagerDataSource: _sl(),
        tafseerDownloaderDataSource: _sl(),
        tafseerFileDataSource: _sl(),
        tafseerSelectedDataSource: _sl(),
      ),
    );

    //!usecase
    _sl.registerLazySingleton(() => TafseerGetManagerUseCase(tafseerRepository: _sl()));
    _sl.registerLazySingleton(() => TafseerCheckIfDownloadedUseCase(tafseerRepository: _sl()));
    _sl.registerLazySingleton(() => TafseerDownloadUseCase(tafseerRepository: _sl()));
    _sl.registerLazySingleton(() => TafseerWriteDataIntoFileAsBytesSyncUseCase(tafseerRepository: _sl()));
    _sl.registerLazySingleton(() => TafseerSaveSelectedIdUseCase(tafseerRepository: _sl()));
    _sl.registerLazySingleton(() => TafseerGetSelectedTafseerId(tafseerRepository: _sl()));
    _sl.registerLazySingleton(() => TafseerGetTafseerDataUseCase(tafseerRepository: _sl()));

    //!Cubit
    _sl.registerFactory(
      () => TafseerCubit(
        getTafseersUseCase: _sl(),
        tafseerSaveSelectedIdUseCase: _sl(),
        tafseerGetSelectedTafseerId: _sl(),
        tafseerGetTafseerDataUseCase: _sl(),
      ),
    );
    _sl.registerFactory(
      () => TafseerDownloadCubit(
        checkTafseerIfDownloadedUseCase: _sl(),
        downloadTafseerUseCase: _sl(),
        tafseerWriteDataIntoFileAsBytesSyncUseCase: _sl(),
      ),
    );
  }
}
