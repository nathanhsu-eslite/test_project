import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:test_3_35_7/consts.dart';

final getIt = GetIt.instance;

void setupLocator({required Store store}) {
  getIt.registerLazySingleton<Store>(() => store);
  getIt.registerLazySingleton<FavoriteInterface>(
    () => FavoriteCatDB(store: getIt<Store>()),
  );
  getIt.registerLazySingleton<GetAllFavoriteUseCase>(
    () => GetAllFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );
  getIt.registerLazySingleton<FindFavoriteUseCase>(
    () => FindFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );
  getIt.registerLazySingleton<DeleteFavoriteUseCase>(
    () => DeleteFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );
  getIt.registerLazySingleton<ClearFavoriteUseCase>(
    () => ClearFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );
  getIt.registerLazySingleton<AddFavoriteUseCase>(
    () => AddFavoriteUC.create(db: getIt<FavoriteInterface>()),
  );

  getIt.registerLazySingleton(
    () => Dio(BaseOptions(headers: {'x-api-key': Consts.apiKey})),
  );
  getIt.registerLazySingleton(() => GetCatsImagesUC.dio(dio: getIt<Dio>()));
  getIt.registerLazySingleton(() => GetCatDetailUC.dio(dio: getIt<Dio>()));
  getIt.registerLazySingleton(() => GetMatchResultUC.dio(dio: getIt<Dio>()));
}
