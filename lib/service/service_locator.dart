import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => GetCatsImagesUC.dio(dio: getIt<Dio>()));
}
