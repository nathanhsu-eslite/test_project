import 'package:bloc_test/bloc_test.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/favorite/blocs/add_favorite/add_favorite_bloc.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart'; // User wants to keep this import
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

class MockAddFavoriteUseCase extends Mock implements AddFavoriteUseCase {}

void main() {
  group('AddFavoriteBloc', () {
    late MockAddFavoriteUseCase mockAddFavoriteUseCase;
    late AddFavoriteBloc addFavoriteBloc;

    setUpAll(() {
      registerFallbackValue(
        Favorite(
          imageId: '1',
          url: 'test_url',
          urlHeight: 100,
          urlWidth: 100,
          breedName: 'test_breed',
        ),
      );
    });

    setUp(() {
      mockAddFavoriteUseCase = MockAddFavoriteUseCase();
      addFavoriteBloc = AddFavoriteBloc(
        addFavoriteUseCase: mockAddFavoriteUseCase,
      );
    });

    final tCatDetail = Cat(
      // User wants to use Cat
      lifeSpan: '',
      breedName: 'test_breed',
      temperament: '',
      origin: '',
      description: '',
    );

    final tMyImage = MyImage(id: '1', url: 'test_url', height: 100, width: 100);

    test('initial state is correct', () {
      expect(addFavoriteBloc.state, AddFavoriteInitial());
    });

    blocTest<AddFavoriteBloc, AddFavoriteState>(
      'emits [loading, success] when add favorite is successful',
      build: () {
        when(
          () => mockAddFavoriteUseCase.call(any()),
        ).thenAnswer((_) => Future.value());
        return addFavoriteBloc;
      },
      act: (bloc) => bloc.add(AddFavorite(tCatDetail, tMyImage)),
      expect: () => [AddFavoriteLoading(), AddFavoriteSuccess()],
    );

    blocTest<AddFavoriteBloc, AddFavoriteState>(
      'emits [loading, failure] when add favorite is unsuccessful',
      build: () {
        when(
          () => mockAddFavoriteUseCase.call(any()),
        ).thenAnswer((_) async => throw Exception('usecase error'));
        return addFavoriteBloc;
      },
      act: (bloc) => bloc.add(AddFavorite(tCatDetail, tMyImage)),
      expect: () => [
        AddFavoriteLoading(),
        const AddFavoriteFailure('Exception: usecase error'),
      ],
    );
  });
}
