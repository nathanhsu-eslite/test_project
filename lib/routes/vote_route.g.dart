// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$voteRoute, $votedCatsRoute];

RouteBase get $voteRoute =>
    GoRouteData.$route(path: '/vote', factory: $VoteRoute._fromState);

mixin $VoteRoute on GoRouteData {
  static VoteRoute _fromState(GoRouterState state) =>
      VoteRoute(state.extra as UserEntity?);

  VoteRoute get _self => this as VoteRoute;

  @override
  String get location => GoRouteData.$location('/vote');

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
