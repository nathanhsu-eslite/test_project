import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:public_api/public_api.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => Dio());
  // getIt.registerLazySingleton(() => DioClient(getIt<Dio>()));
  getIt.registerLazySingleton(() => CatApiClient(getIt<Dio>()));
}
