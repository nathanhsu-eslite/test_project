import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';
import 'package:test_3_35_7/pages/detail_page/detail_page.dart';

part 'detail_route.g.dart';

@TypedGoRoute<DetailRoute>(path: '/detail')
class DetailRoute extends GoRouteData with $DetailRoute {
  final MyImage $extra;

  DetailRoute(this.$extra);
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CatDetailPage(image: $extra);
  }
}
