import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class ImageModel {
  final String id;
  final String url;
  @JsonKey(name: 'height')
  final int urlHeight;
  @JsonKey(name: 'width')
  final int urlWidth;

  ImageModel({
    required this.id,
    required this.url,
    required this.urlHeight,
    required this.urlWidth,
  });
  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
