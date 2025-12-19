//@GeneratedMicroModule;DataPackageModule;package:data/src/db/injectable/db_module.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:data/objectbox.g.dart' as _i337;
import 'package:data/src/db/auth/auth_src.dart' as _i60;
import 'package:data/src/db/injectable/store.dart' as _i454;
import 'package:injectable/injectable.dart' as _i526;

class DataPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i337.Store>(
      () => registerModule.store,
      preResolve: true,
    );
    gh.factory<_i60.AuthDBInterface>(
        () => _i60.AuthDB(store: gh<_i337.Store>()));
  }
}

class _$RegisterModule extends _i454.RegisterModule {}
