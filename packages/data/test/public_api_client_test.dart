import 'dart:convert';

import 'package:data/src/api/cat_api/cat_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('PublicApiClient', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late PublicApiClient publicApiClient;
    const baseUrl = 'https://api.thecatapi.com/v1';

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: baseUrl));
      dioAdapter = DioAdapter(dio: dio);
      publicApiClient = PublicApiClient(dio);
    });

    group('fetchCatsImages', () {
      test('returns a list of ImageModel on successful fetch', () async {
        const path = '/images/search';
        final responseData = r'''
          [
            {
              "id": "1",
              "url": "http://some.url/cat.jpg",
              "width": 100,
              "height": 100
            },
            {
              "id": "2",
              "url": "http://some.url/cat.jpg",
              "width": 100,
              "height": 100
            }
          ]
        ''';

        dioAdapter.onGet(
          path,
          (server) => server.reply(200, jsonDecode(responseData)),
        );

        final result = await publicApiClient.fetchCatsImages(1);

        expect(result, isA<List<ImageModel>>());
        expect(result.length, 2);
        expect(result.first.url, 'http://some.url/cat.jpg');
      });

      test('throws an exception on failed fetch', () async {
        const path = '/images/search';
        dioAdapter.onGet(
          path,
          (server) => server.throws(
            500,
            DioException(requestOptions: RequestOptions(path: '')),
          ),
          queryParameters: {'limit': 1, 'has_breeds': true},
        );

        expect(
          () => publicApiClient.fetchCatsImages(1),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('fetchCatData', () {
      test('returns an ImageModel on successful fetch', () async {
        const id = 'testId';
        const path = '/images/$id';
        final responseData = r'''
          {
            "id": "testId",
            "url": "http://some.url/cat.jpg",
            "width": 100,
            "height": 100,
            "breeds": [
              {
                "weight": {"imperial": "7 - 14", "metric": "3 - 6"},
                "id": "beng",
                "name": "Bengal",
                "temperament": "Alert, Agile, Energetic, Demanding, Intelligent",
                "origin": "United States",
                "country_codes": "US",
                "country_code": "US",
                "description": "Bengals are a lot of fun to live with, but they're definitely not for everyone, or for first-time cat owners. Extremely intelligent, curious and active, they demand a lot of interaction and will make their presence known. They're happiest with a companion who can spend a lot of time with them and provide plenty of playthings or other outlets for their energy.",
                "life_span": "12 - 15",
                "indoor": 0,
                "lap": 0,
                "alt_names": "",
                "adaptability": 5,
                "affection_level": 5,
                "child_friendly": 4,
                "dog_friendly": 5,
                "energy_level": 5,
                "grooming": 1,
                "health_issues": 3,
                "intelligence": 5,
                "shedding_level": 3,
                "social_needs": 5,
                "stranger_friendly": 3,
                "vocalisation": 5,
                "experimental": 1,
                "hairless": 0,
                "natural": 0,
                "rare": 0,
                "rex": 0,
                "suppressed_tail": 0,
                "short_legs": 0,
                "wikipedia_url": "https://en.wikipedia.org/wiki/Bengal_(cat)",
                "hypoallergenic": 1
              }
            ]
          }
        ''';

        dioAdapter.onGet(
          path,
          (server) => server.reply(200, jsonDecode(responseData)),
        );

        final result = await publicApiClient.fetchCatData(id);
        final breedModel = result.breeds!.first;

        expect(breedModel, isA<BreedModel>());
        expect(breedModel.origin, 'United States');
        expect(breedModel.name, 'Bengal');
      });

      test('throws an exception on failed fetch', () async {
        const id = 'testId';
        const path = '/images/$id';
        dioAdapter.onGet(
          path,
          (server) => server.throws(
            500,
            DioException(requestOptions: RequestOptions(path: '')),
          ),
        );

        expect(
          () => publicApiClient.fetchCatData(id),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('voteCat', () {
      test('completes successfully on valid vote', () async {
        const path = '/votes';
        final data = {'image_id': 'testId', 'value': 1};
        final responseData = <String, dynamic>{
          'id': 123,
          'image_id': 'testId',
          'sub_id': 'subId1',
          'created_at': '2024-01-01T00:00:00.000Z',
          'country_code': 'US',
          'value': 1,
        };

        dioAdapter.onPost(
          path,
          (server) => server.reply(200, responseData),
          data: data,
        );

        final result = await publicApiClient.voteCat(data);

        expect(result, isA<VoteModel>());
        expect(result.id, 123);
        expect(result.imageId, 'testId');
        expect(result.value, 1);
      });

      test('throws an exception on failed vote', () async {
        const path = '/votes';
        final data = {'image_id': 'testId', 'value': 1};
        dioAdapter.onPost(
          path,
          (server) => server.throws(
            500,
            DioException(requestOptions: RequestOptions(path: '')),
          ),
          data: data,
        );

        expect(
          () => publicApiClient.voteCat(data),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('fetchVotes', () {
      test('returns a list of VoteModel on successful fetch', () async {
        const path = '/votes';
        final responseData = r'''
          [
            {
              "id": 1,
              "image_id": "imageId1",
              "sub_id": "subId1",
              "created_at": "2024-01-01T00:00:00.000Z",
              "country_code": "US",
              "value": 1,
              "voteImage": {
                "id": "imageId1",
                "url": "http://some.url/cat1.jpg"
              }
            }
          ]
        ''';

        dioAdapter.onGet(
          path,
          (server) => server.reply(200, jsonDecode(responseData)),
        );

        final result = await publicApiClient.fetchVotes();

        expect(result, isA<List<VoteModel>>());
        expect(result.length, 1);
        expect(result.first.id, 1);
        expect(result.first.voteImage, isA<VoteImage>());
      });

      test('throws an exception on failed fetch', () async {
        const path = '/votes';
        dioAdapter.onGet(
          path,
          (server) => server.throws(
            500,
            DioException(requestOptions: RequestOptions(path: '')),
          ),
        );

        expect(
          () => publicApiClient.fetchVotes(),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('deleteVote', () {
      test('completes successfully on valid delete', () async {
        const voteId = 123;
        const path = '/votes/$voteId';
        dioAdapter.onDelete(path, (server) => server.reply(200, {}));

        await publicApiClient.deleteVote(voteId);
      });

      test('throws an exception on failed delete', () async {
        const voteId = 123;
        const path = '/votes/$voteId';
        dioAdapter.onDelete(
          path,
          (server) => server.throws(
            500,
            DioException(requestOptions: RequestOptions(path: '')),
          ),
        );

        expect(
          () => publicApiClient.deleteVote(voteId),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}
