import 'package:cats_repository/cats_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/breeds_matcher/bloc/breeds_matcher_bloc.dart';
import 'package:test_3_35_7/pages/match_result_page/match_result_page.dart';
import 'package:test_3_35_7/pages/preference_form_page/preference_form_page.dart';
import 'package:test_3_35_7/routes/home_route.dart';

part 'preference_form_route.g.dart';

const preferencePath = '/preference';

@TypedGoRoute<PreferenceRoute>(path: preferencePath)
class PreferenceRoute extends GoRouteData with $PreferenceRoute {
  @override
  Widget build(context, state) {
    return PreferenceFormPage();
  }
}

const matchPath = 'match-result';

class MatchRoute extends GoRouteData with $MatchRoute {
  final UserPreference $extra;

  MatchRoute(this.$extra);
  @override
  Widget build(context, state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BreedsMatcherBloc(
            getMatchResultUC: GetIt.I.get<GetMatchResultUC>(),
          )..add(BreedsMatcherStarted(userPreference: $extra)),
        ),
      ],
      child: MatchResultPage(),
    );
  }
}
