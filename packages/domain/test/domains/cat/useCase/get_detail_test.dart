import 'dart:convert';

import 'package:cats_repository/cats_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('GetCatDetail', () {
    late GetCatsDetailUseCase getDetailUC;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.thecatapi.com/v1'));
      dioAdapter = DioAdapter(dio: dio);
      getDetailUC = GetCatDetailUC.dio(dio: dio);
    });

    test('should get cat detail from the repository', () async {
      // arrange
      const catId = '1';
      const path = '/images/$catId';
      final catDetailJson = """{ 
        "id": "1",
        "url": "https://example.com/cat.jpg",
        "width": 800,
        "height": 600,
        "breeds": [
          {
            "weight": {"imperial": "7 - 14", "metric": "3 - 6"},
            "id": "hima",
            "name": "Himalayan",
            "vetstreet_url": "http://www.vetstreet.com/cats/himalayan",
            "vcahospitals_url":
                "https://vcahospitals.com/know-your-pet/cat-breeds/himalayan",
            "temperament": "Dependent, Gentle, Intelligent, Quiet, Social",
            "origin": "United States",
            "country_codes": "US",
            "country_code": "US",
            "description":
                "Calm and devoted, Himalayans make excellent companions, though they prefer a quieter home. They are playful in a sedate kind of way and enjoy having an assortment of toys. The Himalayan will stretch out next to you, sleep in your bed and even sit on your lap when she is in the mood.",
            "life_span": "9 - 15",
            "indoor": 0,
            "lap": 1,
            "alt_names":
                "Himalayan Persian, Colourpoint Persian, Longhaired Colourpoint, Himmy",
            "adaptability": 5,
            "affection_level": 5,
            "child_friendly": 2,
            "dog_friendly": 2,
            "energy_level": 1,
            "grooming": 5,
            "health_issues": 3,
            "intelligence": 3,
            "shedding_level": 4,
            "social_needs": 4,
            "stranger_friendly": 2,
            "vocalisation": 1,
            "experimental": 0,
            "hairless": 0,
            "natural": 0,
            "rare": 0,
            "rex": 0,
            "suppressed_tail": 0,
            "short_legs": 0,
            "wikipedia_url": "https://en.wikipedia.org/wiki/Himalayan_(cat)",
            "hypoallergenic": 0,
            "reference_image_id": "CDhOtM-Ig"
          }
        ]
      }""";

      dioAdapter.onGet(
        path,
        (server) => server.reply(200, jsonDecode(catDetailJson)),
      );

      // act
      final result = await getDetailUC.call(catId);

      // assert
      expect(result, isA<CatDetailEntity>());
      expect(result.breedName, 'Himalayan');
      expect(result.origin, 'United States');
    });
  });
}
