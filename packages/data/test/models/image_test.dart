import 'package:data/src/api/cat_api/cat_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ImageModel', () {
    const imageJson = {
      "id": "1",
      "url": "https://example.com/cat1.jpg",
      "width": 800,
      "height": 600,
    };

    final imageModel = ImageModel(
      id: "1",
      url: "https://example.com/cat1.jpg",
      urlWidth: 800,
      urlHeight: 600,
    );

    test('fromJson creates correct ImageModel', () {
      final result = ImageModel.fromJson(imageJson);
      expect(result.id, imageModel.id);
      expect(result.url, imageModel.url);
      expect(result.urlWidth, imageModel.urlWidth);
      expect(result.urlHeight, imageModel.urlHeight);
    });

    test('toJson returns correct map', () {
      final result = imageModel.toJson();
      expect(result, imageJson);
    });
  });
}
