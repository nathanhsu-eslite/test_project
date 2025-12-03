import 'package:equatable/equatable.dart';

class CatDetailEntity extends Equatable {
  final String name;
  final String temperament;
  final String origin;
  final String description;

  const CatDetailEntity({
    required this.name,
    required this.temperament,
    required this.origin,
    required this.description,
  });

  @override
  List<Object?> get props => [name, temperament, origin, description];
}
