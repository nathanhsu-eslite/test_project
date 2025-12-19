import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:test_3_35_7/consts.dart';
import 'package:test_3_35_7/service/service_locator.dart';
import 'injectable.config.dart';

//初始化
@InjectableInit(
  initializerName: 'init',
  asExtension: false,
  externalPackageModulesBefore: [ExternalModule(DomainPackageModule)],
)
Future<void> configureDependencies() => init(getIt);

// 第三方套件
@module
abstract class AppModule {
  @lazySingleton
  Dio dio() => Dio(BaseOptions(headers: {'x-api-key': Consts.apiKey}));
}
