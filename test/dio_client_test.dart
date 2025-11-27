
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_3_35_7/cat.dart';
import 'package:test_3_35_7/dio_client.dart';

import 'dio_client_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late DioClient dioClient;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    when(mockDio.options).thenReturn(BaseOptions());
    dioClient = DioClient(mockDio);
  });

  group('DioClient', () {
    test('get returns CatImage on successful request', () async {
      final catData = [
        {'id': '1', 'url': 'https://example.com/cat.jpg', 'width': 200, 'height': 300}
      ];


      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/images/search'),
                data: catData,
                statusCode: 200,
              ));


      final result = await dioClient.get(
        '/images/search',
        parser: (data) => CatImage.fromJson(data[0] as Map<String, dynamic>),
      );


      expect(result, isA<CatImage>());
      expect(result.id, '1');
      expect(result.url, 'https://example.com/cat.jpg');
      verify(mockDio.get('/images/search', queryParameters: null)).called(1);
    });

    test('get throws DioException on failed request', () async {

      final dioException = DioException(
        requestOptions: RequestOptions(path: '/images/search'),
        response: Response(
          requestOptions: RequestOptions(path: '/images/search'),
          statusCode: 404,
        ),
      );
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenThrow(dioException);


      expect(
        () => dioClient.get(
          '/images/search',
          parser: (data) => CatImage.fromJson(data[0] as Map<String, dynamic>),
        ),
        throwsA(isA<DioException>()),
      );
    });
  });
}
