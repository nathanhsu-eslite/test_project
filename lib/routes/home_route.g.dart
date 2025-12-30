// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homeShellRouteData];

RouteBase get $homeShellRouteData => StatefulShellRouteData.$route(
  factory: $HomeShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/images', factory: $ImagesRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/preference',
          factory: $PreferenceRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'match-result',
              factory: $MatchRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/vote',
          factory: $VoteRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'voted-cats',
              factory: $VotedCatsRoute._fromState,
            ),
          ],
        ),
      ],
    ),
  ],
);

extension $HomeShellRouteDataExtension on HomeShellRouteData {
  static HomeShellRouteData _fromState(GoRouterState state) =>
      HomeShellRouteData();
}

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
