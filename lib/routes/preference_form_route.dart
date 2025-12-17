import 'package:cats_repository/cats_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/pages/match_result_page/match_result_page.dart';
import 'package:test_3_35_7/pages/preference_form_page/preference_form_page.dart';

part 'preference_form_route.g.dart';

@TypedGoRoute<MatchRoute>(path: '/preference/match-result')
class MatchRoute extends GoRouteData with $MatchRoute {
  final UserPreference $extra;

  MatchRoute(this.$extra);
  @override
  Widget build(context, state) {
    return MatchResultPage(userPreference: $extra);
  }
}

@TypedGoRoute<PreferenceRoute>(path: '/preference')
class PreferenceRoute extends GoRouteData with $PreferenceRoute {
  @override
  Widget build(context, state) {
    return PreferenceFormPage();
  }
}
