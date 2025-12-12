import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPublicApiClient extends Mock implements PublicApiClient {}

void main() {
  late PublicApiClient publicApiClient;
  late GetCatDetailRepo getDetail;

  setUpAll(() {
    publicApiClient = MockPublicApiClient();
    getDetail = GetCatDetailRepo(apiClient: publicApiClient);
  });
  group('GetDetail', () {
    test(
      'fetchCatDetail returns CatDetailEntity when api call is successful',
      () async {
        const id = '1';

        when(
          () => publicApiClient.fetchCatData(id),
        ).thenAnswer((_) async => _Data.imageModel);

        final result = await getDetail.get(id);
        expect(result, isA<CatDetailEntity>());
        expect(result.breedName, _Data.breedModel.name);
        expect(result, equals(_Data.catDetailEntity));
      },
    );

    test('fetchCatDetail throws exception when api call fails', () async {
      const id = '1';
      when(
        () => publicApiClient.fetchCatData(id),
      ).thenThrow(Exception('Failed to fetch cat detail'));
      expect(() => getDetail.get(id), throwsA(isA<Exception>()));
    });
  });
}

class _Data {
  static ImageModel imageModel = ImageModel(
    id: '1',
    url: '',
    urlHeight: 2,
    urlWidth: 2,
    breeds: [breedModel],
  );
  static CatDetailEntity catDetailEntity = CatDetailEntity(
    breedName: 'Abyssinian',
    temperament: 'Active, Energetic, Independent, Intelligent, Gentle',
    origin: "EG",
    description:
        'The Abyssinian is a breed of domestic short-haired cat with a distinctive "ticked" tabby coat, in which individual hairs are banded with different colors.',
    lifeSpan: '14 - 15',
  );
  static BreedModel breedModel = BreedModel(
    breedId: '1',
    name: 'Abyssinian',
    origin: 'EG',
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
}
