// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_form_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$preferenceRoute];

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
