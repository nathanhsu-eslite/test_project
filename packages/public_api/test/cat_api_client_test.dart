import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:public_api/src/cat_api_client.dart';
import 'package:public_api/src/models/models.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('CatApiClient', () {
    late Dio mockDio;
    late CatApiClient catApiClient;

    setUp(() {
      mockDio = MockDio();
      when(() => mockDio.options).thenReturn(BaseOptions());
      when(() => mockDio.interceptors).thenReturn(Interceptors());
      catApiClient = CatApiClient(mockDio);
    });

    group('fetchCatsImages', () {
      test('returns a list of ImageModel on success', () async {
        final responseData = [
          {
            "id": "1",
            "url": "https://example.com/cat1.jpg",
            "width": 800,

            "height": 600,
          },
        ];
        final response = Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => response);

        final result = await catApiClient.fetchCatsImages(1);

        expect(result, isA<List<ImageModel>>());
        expect(result.length, 1);
        expect(result.first.id, '1');
      });

      test('throws an exception on Dio error', () async {
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        expect(
          () async => await catApiClient.fetchCatsImages(1),
          throwsA(isA<DioException>()),
        );
      });

      test('throws an exception on parsing error', () async {
        final response = Response(
          data: 'invalid data',
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => response);

        expect(
          () async => await catApiClient.fetchCatsImages(1),
          throwsA(isA<Exception>()),
        );
      });
    });
    /////////////////////////////////////////////////////////////////////////////////////
    group('fetchCatsDetail', () {
      test('returns a BreedModel on success', () async {
        final responseData = {
          "id": 1,
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
              "reference_image_id": "CDhOtM-Ig",
            },
          ],
        };
        final response = Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => response);

        final result = await catApiClient.fetchCatData('1');

        expect(result, isA<BreedModel>());
        expect(result?.breedId, 'hima');
        expect(result?.name, 'Himalayan');
      });

      test('throws an exception on Dio error', () async {
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        expect(
          () async => await catApiClient.fetchCatData('1'),
          throwsA(isA<DioException>()),
        );
      });

      test('throws an exception on parsing error', () async {
        final response = Response(
          data: 'invalid data',
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => response);

        expect(
          () async => await catApiClient.fetchCatData('1'),
          throwsA(isA<TypeError>()),
        );
      });
    });
  });
}
