//@GeneratedMicroModule;DomainPackageModule;package:domain/src/domains/domain_module.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:cats_repository/cats_repository.dart' as _i956;
import 'package:domain/src/domains/auth/auth.dart' as _i121;
import 'package:domain/src/domains/auth/domain.dart' as _i625;
import 'package:domain/src/domains/auth/useCase/login.dart' as _i1016;
import 'package:domain/src/domains/auth/useCase/register.dart' as _i925;
import 'package:domain/src/domains/cat/domain.dart' as _i331;
import 'package:domain/src/domains/cat/useCase/get_images.dart' as _i506;
import 'package:domain/src/domains/votes/domain.dart' as _i395;
import 'package:domain/src/domains/votes/useCase/delete_votes.dart' as _i394;
import 'package:domain/src/domains/votes/useCase/get_votes.dart' as _i348;
import 'package:domain/src/domains/votes/useCase/vote_cat.dart' as _i102;
import 'package:injectable/injectable.dart' as _i526;

class DomainPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i395.GetVotesUseCase>(
        () => _i348.GetVotesUC(repo: gh<_i956.GetVotesInterface>()));
    gh.factory<_i395.VoteCatUseCase>(
        () => _i102.VoteCatUC(repo: gh<_i956.VoteInterface>()));
    gh.factory<_i331.GetCatsImagesUseCase>(
        () => _i506.GetCatsImagesUC(getImages: gh<_i956.GetImagesInterface>()));
    gh.factory<_i395.DeleteVotesUseCase>(
        () => _i394.DeleteVotesUC(repo: gh<_i956.DeleteVotesInterface>()));
    gh.factory<_i121.RegisterUseCase>(
        () => _i925.RegisterUC(repo: gh<_i956.RegisterInterface>()));
    gh.factory<_i625.LoginUseCase>(
        () => _i1016.LoginUC(repo: gh<_i956.LoginInterface>()));
  }
}
