// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voted_cats_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$votedCatsRoute];

RouteBase get $votedCatsRoute => GoRouteData.$route(
  path: '/vote/voted-cats',
  factory: $VotedCatsRoute._fromState,
);

mixin $VotedCatsRoute on GoRouteData {
  static VotedCatsRoute _fromState(GoRouterState state) =>
      const VotedCatsRoute();

  @override
  String get location => GoRouteData.$location('/vote/voted-cats');

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
