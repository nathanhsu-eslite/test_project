import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/routes/detail_route.dart' as detail;
import 'package:test_3_35_7/routes/favorite_route.dart' as favorite;
import 'package:test_3_35_7/routes/home_route.dart' as home;
import 'package:test_3_35_7/routes/preference_form_route.dart' as preference;

List<RouteBase> routes = [
  ...home.$appRoutes,
  ...detail.$appRoutes,
  ...favorite.$appRoutes,
  ...preference.$appRoutes,
];
