import 'package:cats_repository/src/get_cat_detail_repository/methods/get_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:public_api/public_api.dart';

class MockCatApiClient extends Mock implements CatApiClient {}

void main() {
  group('GetDetail', () {
    late CatApiClient catApiClient;
    late GetDetail getDetail;

    setUp(() {
      catApiClient = MockCatApiClient();
      getDetail = GetDetail(catApiClient: catApiClient);
    });

    test(
      'fetchCatDetail returns BreedModel when api call is successful',
      () async {
        const id = '1';
        final breedModel = BreedModel(
          breedId: '1',
          name: 'Abyssinian',
          origin: 'Egypt',
          description:
              'The Abyssinian is a breed of domestic short-haired cat with a distinctive "ticked" tabby coat, in which individual hairs are banded with different colors.',
          temperament: 'Active, Energetic, Independent, Intelligent, Gentle',
          lifeSpan: '14 - 15',
          countryCode: 'EG',
          adaptability: 5,
          affectionLevel: 5,
          childFriendly: 3,
          dogFriendly: 4,
          energyLevel: 5,
          grooming: 1,
          healthIssues: 2,
          intelligence: 5,
          sheddingLevel: 2,
          socialNeeds: 5,
          strangerFriendly: 5,
          vocalisation: 1,
          experimental: 0,
          hairless: 0,
          natural: 1,
          rare: 0,
          rex: 0,
          suppressedTail: 0,
          shortLegs: 0,
          hypoallergenic: 0,
          referenceImageId: '0XYvRd7oD',
          weight: Weight(imperial: '7  -  10', metric: '3 - 5'),
        );
        when(
          () => catApiClient.fetchCatsDetail(id),
        ).thenAnswer((_) async => breedModel);
        final result = await getDetail.fetchCatDetail(id);
        expect(result, isA<BreedModel>());
        expect(result, equals(breedModel));
      },
    );

    test('fetchCatDetail throws exception when api call fails', () async {
      const id = '1';
      when(
        () => catApiClient.fetchCatsDetail(id),
      ).thenThrow(Exception('Failed to fetch cat detail'));
      expect(() => getDetail.fetchCatDetail(id), throwsA(isA<Exception>()));
    });

    test('fetchCatDetail throws exception when api returns null', () async {
      const id = '1';
      when(
        () => catApiClient.fetchCatsDetail(id),
      ).thenAnswer((_) async => null);
      expect(() => getDetail.fetchCatDetail(id), throwsA(isA<Exception>()));
    });
  });
}
