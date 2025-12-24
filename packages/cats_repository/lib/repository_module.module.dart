//@GeneratedMicroModule;CatsRepositoryPackageModule;package:cats_repository/repository_module.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:cats_repository/cats_repository.dart' as _i956;
import 'package:cats_repository/src/auth/methods/interface/login_interface.dart'
    as _i453;
import 'package:cats_repository/src/auth/methods/interface/register_interface.dart'
    as _i1012;
import 'package:cats_repository/src/auth/methods/login.dart' as _i700;
import 'package:cats_repository/src/auth/methods/register.dart' as _i703;
import 'package:cats_repository/src/get_images_repository/methods/get_images.dart'
    as _i666;
import 'package:cats_repository/src/get_images_repository/methods/get_images_interface.dart'
    as _i1009;
import 'package:cats_repository/src/votes/delete_votes/methods/delete_votes.dart'
    as _i556;
import 'package:cats_repository/src/votes/delete_votes/methods/delete_votes_interface.dart'
    as _i588;
import 'package:cats_repository/src/votes/get_votes/methods/get_votes.dart'
    as _i791;
import 'package:cats_repository/src/votes/vote_cat/methods/vote.dart' as _i820;
import 'package:cats_repository/src/votes/votes.dart' as _i144;
import 'package:data/data.dart' as _i437;
import 'package:injectable/injectable.dart' as _i526;

class CatsRepositoryPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i956.GetVotesInterface>(
        () => _i791.GetVotesRepo(publicApiClient: gh<_i437.PublicApiClient>()));
    gh.lazySingleton<_i453.LoginInterface>(
        () => _i700.LoginRepo(db: gh<_i437.AuthDBInterface>()));
    gh.lazySingleton<_i1009.GetImagesInterface>(
        () => _i666.GetImagesRepo(apiClient: gh<_i437.PublicApiClient>()));
    gh.lazySingleton<_i144.VoteInterface>(
        () => _i820.VoteRepo(publicApiClient: gh<_i437.PublicApiClient>()));
    gh.lazySingleton<_i588.DeleteVotesInterface>(
        () => _i556.DeleteVotesRepo(apiClient: gh<_i437.PublicApiClient>()));
    gh.lazySingleton<_i1012.RegisterInterface>(
        () => _i703.RegisterRepo(db: gh<_i437.AuthDBInterface>()));
  }
}
