import 'package:equatable/equatable.dart';

class Cat extends Equatable {
  final String breedName;
  final String temperament;
  final String origin;
  final String description;
  final String lifeSpan;

  const Cat({
    required this.breedName,
    required this.temperament,
    required this.origin,
    required this.description,
    required this.lifeSpan,
  });

  @override
  List<Object?> get props => [
    breedName,
    temperament,
    origin,
    description,
    lifeSpan,
  ];
}
