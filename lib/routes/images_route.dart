import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_3_35_7/pages/images_page/images_page.dart';

part 'images_route.g.dart';

const imagesPath = '/images';

@TypedGoRoute<ImagesRoute>(path: imagesPath)
class ImagesRoute extends GoRouteData with $ImagesRoute {
  ImagesRoute();

  @override
  Widget build(context, state) {
    return ImagesPage();
  }
}
