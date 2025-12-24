import 'package:json_annotation/json_annotation.dart';

import 'breeds.dart';

part 'image.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageModel {
  final String id;
  final String url;
  @JsonKey(name: 'height')
  final int? urlHeight;
  @JsonKey(name: 'width')
  final int? urlWidth;
  final List<BreedModel>? breeds;

  ImageModel({
    required this.id,
    required this.url,
    this.urlHeight,
    this.urlWidth,
    this.breeds,
  });
  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
