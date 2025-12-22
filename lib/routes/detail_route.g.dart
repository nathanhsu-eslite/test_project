// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$detailRoute];

RouteBase get $detailRoute =>
    GoRouteData.$route(path: '/detail', factory: $DetailRoute._fromState);

mixin $DetailRoute on GoRouteData {
  static DetailRoute _fromState(GoRouterState state) =>
      DetailRoute(state.extra as MyImage);

  DetailRoute get _self => this as DetailRoute;

  @override
  String get location => GoRouteData.$location('/detail');

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
