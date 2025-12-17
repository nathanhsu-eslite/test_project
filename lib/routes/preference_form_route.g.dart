// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_form_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$matchRoute, $preferenceRoute];

RouteBase get $matchRoute => GoRouteData.$route(
  path: '/preference/match-result',
  factory: $MatchRoute._fromState,
);

mixin $MatchRoute on GoRouteData {
  static MatchRoute _fromState(GoRouterState state) =>
      MatchRoute(state.extra as UserPreference);

  MatchRoute get _self => this as MatchRoute;

  @override
  String get location => GoRouteData.$location('/preference/match-result');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $preferenceRoute => GoRouteData.$route(
  path: '/preference',
  factory: $PreferenceRoute._fromState,
);

mixin $PreferenceRoute on GoRouteData {
  static PreferenceRoute _fromState(GoRouterState state) => PreferenceRoute();

  @override
  String get location => GoRouteData.$location('/preference');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
