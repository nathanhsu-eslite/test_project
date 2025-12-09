import 'package:equatable/equatable.dart';

sealed class GetCatImagesBlocException extends Equatable implements Exception {}

class ImagesIsEmptyBlocException extends GetCatImagesBlocException {
  @override
  List<Object?> get props => [];
}
