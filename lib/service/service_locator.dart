import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';

import 'dart:developer' as dev;

void setupAuthScope() {
  //當登入時才能使用的功能
  GetIt.I.pushNewScope(
    scopeName: 'logged-in',
    init: (scope) {
      dev.log('setupAuthScope');

      _registerMatchService();
      GetIt.I.registerLazySingleton(
        () => GetCatDetailUC.dio(dio: GetIt.I<Dio>()),
      );
    },
  );
  GetIt.I.pushNewScope(
    scopeName: 'favorite',
    init: (scope) {
      dev.log('setupFavoriteScope');
      _registerFavoriteService();
    },
  );
}

void _registerMatchService() {
  GetIt.I.registerFactory(() => GetMatchResultUC.dio(dio: GetIt.I<Dio>()));
}

//favorite feature
void _registerFavoriteService() {
  GetIt.I.registerLazySingleton<FavoriteInterface>(
    () => FavoriteCatDB(store: GetIt.I<Store>()),
  );
  GetIt.I.registerFactory<GetAllFavoriteUseCase>(
    () => GetAllFavoriteUC.create(db: GetIt.I<FavoriteInterface>()),
  );
  GetIt.I.registerFactory<FindFavoriteUseCase>(
    () => FindFavoriteUC.create(db: GetIt.I<FavoriteInterface>()),
  );
  GetIt.I.registerFactory<DeleteFavoriteUseCase>(
    () => DeleteFavoriteUC.create(db: GetIt.I<FavoriteInterface>()),
  );
  GetIt.I.registerFactory<ClearFavoriteUseCase>(
    () => ClearFavoriteUC.create(db: GetIt.I<FavoriteInterface>()),
  );
  GetIt.I.registerFactory<AddFavoriteUseCase>(
    () => AddFavoriteUC.create(db: GetIt.I<FavoriteInterface>()),
  );
}
