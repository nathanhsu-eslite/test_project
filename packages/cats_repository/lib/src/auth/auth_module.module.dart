//@GeneratedMicroModule;CatsRepositoryPackageModule;package:cats_repository/src/auth/auth_module.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:cats_repository/src/auth/methods/interface/login_interface.dart'
    as _i453;
import 'package:cats_repository/src/auth/methods/interface/register_interface.dart'
    as _i1012;
import 'package:cats_repository/src/auth/methods/login.dart' as _i700;
import 'package:cats_repository/src/auth/methods/register.dart' as _i703;
import 'package:data/data.dart' as _i437;
import 'package:injectable/injectable.dart' as _i526;

class CatsRepositoryPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i453.LoginInterface>(
        () => _i700.LoginRepo(db: gh<_i437.AuthDBInterface>()));
    gh.factory<_i1012.RegisterInterface>(
        () => _i703.RegisterRepo(db: gh<_i437.AuthDBInterface>()));
  }
}
