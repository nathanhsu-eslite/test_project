import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class CatImage {
  final String id;
  final String url;
  @JsonKey(name: 'height')
  final int urlHeight;
  @JsonKey(name: 'width')
  final int urlWidth;

  CatImage({
    required this.id,
    required this.url,
    required this.urlHeight,
    required this.urlWidth,
  });
  factory CatImage.fromJson(Map<String, dynamic> json) =>
      _$CatImageFromJson(json);
  Map<String, dynamic> toJson() => _$CatImageToJson(this);
}
