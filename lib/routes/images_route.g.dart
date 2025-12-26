// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$imagesRoute];

RouteBase get $imagesRoute =>
    GoRouteData.$route(path: '/images', factory: $ImagesRoute._fromState);

mixin $ImagesRoute on GoRouteData {
  static ImagesRoute _fromState(GoRouterState state) => ImagesRoute();

  @override
  String get location => GoRouteData.$location('/images');

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
