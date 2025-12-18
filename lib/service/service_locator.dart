import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:test_3_35_7/consts.dart';

final getIt = GetIt.instance;

void setupLocator({required Store store}) {
  getIt.registerLazySingleton<Store>(() => store);

  getIt.registerLazySingleton(
    () => Dio(BaseOptions(headers: {'x-api-key': Consts.apiKey})),
  );
  getIt.registerLazySingleton<AuthDBInterface>(
    () => AuthDB(store: getIt<Store>()),
  );
  getIt.registerLazySingleton(() => GetCatsImagesUC.dio(dio: getIt<Dio>()));

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUC.create(db: getIt<AuthDBInterface>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUC.create(db: getIt<AuthDBInterface>()),
  );
}

void setupAuthScope() {
  //當登入時才能使用的功能
  getIt.pushNewScope(
    scopeName: 'logged-in',
    init: (scope) {
      _registerFavoriteService();
      getIt.registerLazySingleton(() => GetCatDetailUC.dio(dio: getIt<Dio>()));
      getIt.registerLazySingleton(
        () => GetMatchResultUC.dio(dio: getIt<Dio>()),
      );
    },
  );
}

void _registerFavoriteService() {
  getIt.registerLazySingleton<FavoriteInterface>(
    () => FavoriteCatDB(store: getIt<Store>()),
  );
  getIt.registerFactory<GetAllFavoriteUseCase>(
    () => GetAllFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );
  getIt.registerFactory<FindFavoriteUseCase>(
    () => FindFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );
  getIt.registerFactory<DeleteFavoriteUseCase>(
    () => DeleteFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );
  getIt.registerFactory<ClearFavoriteUseCase>(
    () => ClearFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );
  getIt.registerFactory<AddFavoriteUseCase>(
    () => AddFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );
}
