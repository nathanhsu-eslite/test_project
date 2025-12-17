import 'dart:convert';

import 'package:cats_repository/cats_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/src/domains/breed_match/breed_match.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late GetMatchResultUseCase getMatchResultUC;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.thecatapi.com/v1'));
    dioAdapter = DioAdapter(dio: dio);
    getMatchResultUC = GetMatchResultUC.dio(dio: dio);
  });

  test('should get match result from the repository', () async {
    final userPreference = UserPreference(
      desiredEnergyLevel: 3,
      desiredAffectionLevel: 3,
      desiredChildFriendly: 3,
      desiredGrooming: 3,
      desiredDogFriendly: 3,
      desiredStrangerFriendly: 3,
      desiredSocialNeeds: 3,
    );

    const path = '/images/search';

    dioAdapter.onGet(
      path,
      (server) => server.reply(200, jsonDecode(testRsp)),
      queryParameters: {'limit': 3},
    );

    // act
    final result = await getMatchResultUC.call(pref: userPreference, limit: 3);

    // assert
    expect(result, isA<List<BreedMatchResult>>());
    expect(result.length, 3);
    expect(result[0].catModel.breeds!.first.name, 'Snowshoe');
    expect(result[1].score, 67.86);
  });
}

final String testRsp = r'''[
  {
    "breeds": [
      {
        "weight": {
          "imperial": "6 - 11",
          "metric": "3 - 5"
        },
        "id": "bomb",
        "name": "Bombay",
        "cfa_url": "http://cfa.org/Breeds/BreedsAB/Bombay.aspx",
        "vetstreet_url": "http://www.vetstreet.com/cats/bombay",
        "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/bombay",
        "temperament": "Affectionate, Dependent, Gentle, Intelligent, Playful",
        "origin": "United States",
        "country_codes": "US",
        "country_code": "US",
        "description": "The the golden eyes and the shiny black coa of the Bopmbay is absolutely striking. Likely to bond most with one family member, the Bombay will follow you from room to room and will almost always have something to say about what you are doing, loving attention and to be carried around, often on his caregiver's shoulder.",
        "life_span": "12 - 16",
        "indoor": 0,
        "lap": 1,
        "alt_names": "Small black Panther",
        "adaptability": 5,
        "affection_level": 5,
        "child_friendly": 4,
        "dog_friendly": 5,
        "energy_level": 3,
        "grooming": 1,
        "health_issues": 3,
        "intelligence": 5,
        "shedding_level": 3,
        "social_needs": 4,
        "stranger_friendly": 4,
        "vocalisation": 5,
        "experimental": 0,
        "hairless": 0,
        "natural": 0,
        "rare": 0,
        "rex": 0,
        "suppressed_tail": 0,
        "short_legs": 0,
        "wikipedia_url": "https://en.wikipedia.org/wiki/Bombay_(cat)",
        "hypoallergenic": 0,
        "reference_image_id": "5iYq9NmT1"
      }
    ],
    "id": "Z6mrcccZv",
    "url": "https://cdn2.thecatapi.com/images/Z6mrcccZv.jpg",
    "width": 1188,
    "height": 792
  },
  {
    "breeds": [
      {
        "weight": {
          "imperial": "7 - 12",
          "metric": "3 - 5"
        },
        "id": "snow",
        "name": "Snowshoe",
        "temperament": "Affectionate, Social, Intelligent, Sweet-tempered",
        "origin": "United States",
        "country_codes": "US",
        "country_code": "US",
        "description": "The Snowshoe is a vibrant, energetic, affectionate and intelligent cat. They love being around people which makes them ideal for families, and becomes unhappy when left alone for long periods of time. Usually attaching themselves to one person, they do whatever they can to get your attention.",
        "life_span": "14 - 19",
        "indoor": 0,
        "lap": 1,
        "alt_names": "",
        "adaptability": 5,
        "affection_level": 5,
        "child_friendly": 4,
        "dog_friendly": 5,
        "energy_level": 4,
        "grooming": 3,
        "health_issues": 1,
        "intelligence": 5,
        "shedding_level": 3,
        "social_needs": 4,
        "stranger_friendly": 4,
        "vocalisation": 5,
        "experimental": 0,
        "hairless": 0,
        "natural": 0,
        "rare": 0,
        "rex": 0,
        "suppressed_tail": 0,
        "short_legs": 0,
        "wikipedia_url": "https://en.wikipedia.org/wiki/Snowshoe_(cat)",
        "hypoallergenic": 0,
        "reference_image_id": "MK-sYESvO"
      }
    ],
    "id": "BB18hZT2z",
    "url": "https://cdn2.thecatapi.com/images/BB18hZT2z.jpg",
    "width": 2909,
    "height": 2126
  },
  {
    "breeds": [
      {
        "weight": {
          "imperial": "8 - 16",
          "metric": "4 - 7"
        },
        "id": "sibe",
        "name": "Siberian",
        "cfa_url": "http://cfa.org/Breeds/BreedsSthruT/Siberian.aspx",
        "vetstreet_url": "http://www.vetstreet.com/cats/siberian",
        "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/siberian",
        "temperament": "Curious, Intelligent, Loyal, Sweet, Agile, Playful, Affectionate",
        "origin": "Russia",
        "country_codes": "RU",
        "country_code": "RU",
        "description": "The Siberians dog like temperament and affection makes the ideal lap cat and will live quite happily indoors. Very agile and powerful, the Siberian cat can easily leap and reach high places, including the tops of refrigerators and even doors. ",
        "life_span": "12 - 15",
        "indoor": 0,
        "lap": 1,
        "alt_names": "Moscow Semi-longhair, HairSiberian Forest Cat",
        "adaptability": 5,
        "affection_level": 5,
        "child_friendly": 4,
        "dog_friendly": 5,
        "energy_level": 5,
        "grooming": 2,
        "health_issues": 2,
        "intelligence": 5,
        "shedding_level": 3,
        "social_needs": 4,
        "stranger_friendly": 3,
        "vocalisation": 1,
        "experimental": 0,
        "hairless": 0,
        "natural": 1,
        "rare": 0,
        "rex": 0,
        "suppressed_tail": 0,
        "short_legs": 0,
        "wikipedia_url": "https://en.wikipedia.org/wiki/Siberian_(cat)",
        "hypoallergenic": 1,
        "reference_image_id": "3bkZAjRh1"
      }
    ],
    "id": "mcHWg83Yj",
    "url": "https://cdn2.thecatapi.com/images/mcHWg83Yj.jpg",
    "width": 1248,
    "height": 938
  }
]''';
