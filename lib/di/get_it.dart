import 'package:get_it/get_it.dart';
import 'package:test_ads_pratice/features/ads_show/presentation/cubit/ads_show_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  // getItInstance.registerLazySingleton<Client>(() => Client());
  // getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  // Analytics Property
  // getItInstance.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  //Data source Dependency
  // getItInstance.registerLazySingleton<DmtRemoteDataSource>(() => DmtRemoteDataSourceImpl(client: getItInstance()));

  //Data Repository Dependency
  // getItInstance
  // .registerLazySingleton<DMTRemoteRepository>(() => DMTRemoteRepositoryImpl(dmtRemoteDataSource: getItInstance()));

  //Usecase Dependency
  // getItInstance.registerLazySingleton<GetMusicCategoriesData>(() => GetMusicCategoriesData(
  //       musicRemoteDataSource: getItInstance(),
  //     ));

  //Bloc Dependency
  // getItInstance.registerFactory(() => VideoCategoryBloc());

  //Cubit Dependency
  // getItInstance
  //     .registerFactory(() => UserLanguageCubit(loadingCubit: getItInstance(), getUserLanguageList: getItInstance()));
  getItInstance.registerFactory(() => AdsShowCubit());

  //Theme Dependency
  // getItInstance.registerFactory(() => BottomNavigationCubit());
}
