import 'package:equatable/equatable.dart';

class FavoriteCat extends Equatable {
  final int id;
  final String imageId;
  final String url;
  final int urlHeight;
  final int urlWidth;
  final String breedName;

  const FavoriteCat({
    required this.id,
    required this.imageId,
    required this.url,
    required this.urlHeight,
    required this.urlWidth,
    required this.breedName,
  });

  @override
  List<Object?> get props => [id, imageId, url, urlHeight, urlWidth, breedName];
}
