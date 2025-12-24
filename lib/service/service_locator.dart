import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';

import 'dart:developer' as dev;

final getIt = GetIt.instance;

void setupLocator() {}

void setupAuthScope() {
  //當登入時才能使用的功能
  getIt.pushNewScope(
    scopeName: 'logged-in',
    init: (scope) {
      dev.log('setupAuthScope');

      _registerMatchService();
      getIt.registerLazySingleton(() => GetCatDetailUC.dio(dio: getIt<Dio>()));
    },
  );
  getIt.pushNewScope(
    scopeName: 'favorite',
    init: (scope) {
      dev.log('setupFavoriteScope');
      _registerFavoriteService();
    },
  );
}

void _registerMatchService() {
  getIt.registerFactory(() => GetMatchResultUC.dio(dio: getIt<Dio>()));
}

//favorite feature
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
