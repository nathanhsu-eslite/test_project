import 'dart:io';

import 'package:data/data.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return Directory.systemTemp.path;
  }
}

class Data {
  static Favorite mockFavorite = Favorite(
    url: 'http://1',
    urlHeight: 100,
    urlWidth: 100,
    imageId: '1',
    breedName: 'Siamese',
  );
  static Favorite mockFavorite2 = Favorite(
    url: 'http://2',
    urlHeight: 100,
    urlWidth: 100,
    imageId: '2',
    breedName: 'Siamese2',
  );
}
