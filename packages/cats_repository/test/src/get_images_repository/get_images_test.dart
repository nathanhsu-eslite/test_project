import 'package:cats_repository/cats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:public_api/public_api.dart';

class MockPublicApiClient extends Mock implements PublicApiClient {}

void main() {
  late PublicApiClient publicApiClient;
  late GetImagesRepo getImages;

  setUpAll(() {
    publicApiClient = MockPublicApiClient();
    getImages = GetImagesRepo(apiClient: publicApiClient);
  });

  group('GetImages', () {
    test(
      'fetchCatImages returns List<CatImageEntity> when api call is successful',
      () async {
        when(
          () => publicApiClient.fetchCatsImages(2),
        ).thenAnswer((_) async => _Data.imageModels);
        final result = await getImages.get(2);
        expect(result, isA<List<CatImageEntity>>());
        expect(result.length, equals(2));
        expect(result, equals(_Data.catImageEntity));
        expect(result[0].url, _Data.catImageEntity[0].url);
      },
    );

    test('fetchCatImages throws exception when api call fails', () async {
      when(
        () => publicApiClient.fetchCatsImages(2),
      ).thenThrow(Exception('API Error'));
      expect(() async => await getImages.get(2), throwsA(isA<Exception>()));
    });
    test('fetchCatImages throws exception when list is empty', () async {
      when(
        () => publicApiClient.fetchCatsImages(2),
      ).thenAnswer((_) async => []);
      expect(() async => await getImages.get(2), throwsA(isA<Exception>()));
    });
  });
}

class _Data {
  static List<ImageModel> imageModels = [
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

  static List<CatImageEntity> catImageEntity = [
    CatImageEntity(
      id: '1',
      url: 'https://example.com/cat1.jpg',
      urlHeight: 800,
      urlWidth: 600,
    ),
    CatImageEntity(
      id: '2',
      url: 'https://example.com/cat2.jpg',
      urlWidth: 1024,
      urlHeight: 768,
    ),
  ];
}
