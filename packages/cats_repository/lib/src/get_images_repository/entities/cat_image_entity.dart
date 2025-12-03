import 'package:equatable/equatable.dart';

class CatImageEntity extends Equatable {
  final String id;
  final String url;
  final int urlHeight;
  final int urlWidth;

  const CatImageEntity({
    required this.id,
    required this.url,
    required this.urlHeight,
    required this.urlWidth,
  });

  @override
  List<Object?> get props => [id, url, urlHeight, urlWidth];
}
