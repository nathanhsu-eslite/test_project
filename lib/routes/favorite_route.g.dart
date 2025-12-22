// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$favoriteRoute];

RouteBase get $favoriteRoute =>
    GoRouteData.$route(path: '/favorite', factory: $FavoriteRoute._fromState);

mixin $FavoriteRoute on GoRouteData {
  static FavoriteRoute _fromState(GoRouterState state) => FavoriteRoute();

  @override
  String get location => GoRouteData.$location('/favorite');

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
