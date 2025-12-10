import 'package:equatable/equatable.dart';

class Cat extends Equatable {
  final String breedName;
  final String temperament;
  final String origin;
  final String description;

  const Cat({
    required this.breedName,
    required this.temperament,
    required this.origin,
    required this.description,
  });

  @override
  List<Object?> get props => [breedName, temperament, origin, description];
}
