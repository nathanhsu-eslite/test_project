// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cats_repository/repository_module.module.dart' as _i1070;
import 'package:data/src/injectable/data_module.module.dart' as _i671;
import 'package:dio/dio.dart' as _i361;
import 'package:domain/domain.dart' as _i494;
import 'package:domain/src/domains/domain_module.module.dart' as _i139;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:test_3_35_7/features/auth/blocs/login_bloc/login_bloc.dart'
    as _i212;
import 'package:test_3_35_7/features/auth/blocs/register_bloc/register_bloc.dart'
    as _i1061;
import 'package:test_3_35_7/features/get_cat_images/bloc/get_cat_images_bloc.dart'
    as _i838;
import 'package:test_3_35_7/features/votes/blocs/delete_vote/delete_votes_bloc.dart'
    as _i227;
import 'package:test_3_35_7/features/votes/blocs/get_votes/get_votes_bloc.dart'
    as _i404;
import 'package:test_3_35_7/features/votes/blocs/vote_cat/vote_cat_bloc.dart'
    as _i899;
import 'package:test_3_35_7/service/injectable.dart' as _i913;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  await _i1070.CatsRepositoryPackageModule().init(gh);
  await _i671.DataPackageModule().init(gh);
  await _i139.DomainPackageModule().init(gh);
  final appModule = _$AppModule();
  gh.lazySingleton<_i361.Dio>(() => appModule.dio());
  gh.factory<_i1061.RegisterBloc>(
    () => _i1061.RegisterBloc(registerUseCase: gh<_i494.RegisterUseCase>()),
  );
  gh.factory<_i212.LoginBloc>(
    () => _i212.LoginBloc(loginUseCase: gh<_i494.LoginUseCase>()),
  );
  gh.factory<_i838.GetCatImagesBloc>(
    () => _i838.GetCatImagesBloc(
      getCatsImagesUseCase: gh<_i494.GetCatsImagesUseCase>(),
    ),
  );
  gh.factory<_i899.VoteCatBloc>(
    () => _i899.VoteCatBloc(voteCatUseCase: gh<_i494.VoteCatUseCase>()),
  );
  gh.factory<_i227.DeleteVotesBloc>(
    () => _i227.DeleteVotesBloc(
      deleteVotesUseCase: gh<_i494.DeleteVotesUseCase>(),
    ),
  );
  gh.factory<_i404.GetVotesBloc>(
    () => _i404.GetVotesBloc(getVotesUseCase: gh<_i494.GetVotesUseCase>()),
  );
  return getIt;
}

class _$AppModule extends _i913.AppModule {}
