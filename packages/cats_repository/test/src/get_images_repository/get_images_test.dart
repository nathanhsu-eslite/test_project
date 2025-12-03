import 'package:cats_repository/cats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:public_api/public_api.dart';

class MockCatApiClient extends Mock implements CatApiClient {}

void main() {
  group('GetImages', () {
    late CatApiClient catApiClient;
    late GetImages getImages;

    setUp(() {
      catApiClient = MockCatApiClient();
      getImages = GetImages(catApiClient: catApiClient);
    });

    test(
      'fetchCatImages returns List<ImageModel> when api call is successful',
      () async {
        final imageModels = [
          ImageModel(
            id: '1',
            url: 'https://example.com/cat1.jpg',
            urlHeight: 800,
            urlWidth: 600,
          ),
          ImageModel(
            id: '2',
            url: 'https://example.com/cat2.jpg',
            urlWidth: 1024,
            urlHeight: 768,
          ),
        ];
        when(
          () => catApiClient.fetchCatsImages(2),
        ).thenAnswer((_) async => imageModels);
        final result = await getImages.fetchCatsImages(2);
        expect(result, isA<List<ImageModel>>());
        expect(result.length, equals(2));
        expect(result, equals(imageModels));
        expect(result[0].url, imageModels[0].url);
      },
    );

    test('fetchCatImages throws exception when api call fails', () async {
      when(
        () => catApiClient.fetchCatsImages(2),
      ).thenThrow(Exception('API Error'));
      expect(
        () async => await getImages.fetchCatsImages(2),
        throwsA(isA<Exception>()),
      );
    });
  });
}
