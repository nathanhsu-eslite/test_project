import 'package:equatable/equatable.dart';

class VotesDataEntity extends Equatable {
  final int id;
  final String imageId;
  final String subId;
  final int value;
  final String? url;

  const VotesDataEntity({
    required this.id,
    required this.imageId,
    required this.subId,
    required this.value,
    this.url,
  });

  @override
  List<Object?> get props => [id, imageId, subId, value, url];
}
