import 'package:equatable/equatable.dart';

class CatDetailEntity extends Equatable {
  final String breedName;
  final String temperament;
  final String origin;
  final String description;
  final String lifeSpan;

  const CatDetailEntity({
    required this.lifeSpan,
    required this.breedName,
    required this.temperament,
    required this.origin,
    required this.description,
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
