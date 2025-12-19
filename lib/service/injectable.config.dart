// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cats_repository/src/auth/auth_module.module.dart' as _i200;
import 'package:data/src/db/injectable/db_module.module.dart' as _i70;
import 'package:dio/dio.dart' as _i361;
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/auth/blocs/login_bloc/login_bloc.dart' as _i121;
import 'injectable.dart' as _i1027;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  await _i494.DomainPackageModule().init(gh);
  await _i200.CatsRepositoryPackageModule().init(gh);
  await _i70.DataPackageModule().init(gh);
  final appModule = _$AppModule();
  gh.lazySingleton<_i361.Dio>(() => appModule.dio());
  gh.factory<_i121.LoginBloc>(
    () => _i121.LoginBloc(loginUseCase: gh<_i494.LoginUseCase>()),
  );
  return getIt;
}

class _$AppModule extends _i1027.AppModule {}
