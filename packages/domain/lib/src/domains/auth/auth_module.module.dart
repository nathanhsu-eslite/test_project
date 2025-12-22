//@GeneratedMicroModule;DomainPackageModule;package:domain/src/domains/auth/auth_module.module.dart
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
import 'package:injectable/injectable.dart' as _i526;

class DomainPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i121.RegisterUseCase>(
        () => _i925.RegisterUC(repo: gh<_i956.RegisterInterface>()));
    gh.factory<_i625.LoginUseCase>(
        () => _i1016.LoginUC(repo: gh<_i956.LoginInterface>()));
  }
}
