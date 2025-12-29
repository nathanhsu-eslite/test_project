import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:test_3_35_7/consts.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;
//初始化
@InjectableInit(initializerName: 'init', asExtension: false)
Future<void> configureDependencies() => init(getIt);

// 第三方套件
@module
abstract class AppModule {
  @lazySingleton
  Dio dio() => Dio(BaseOptions(headers: {'x-api-key': Consts.apiKey}));
}
