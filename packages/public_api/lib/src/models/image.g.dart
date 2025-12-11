// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
  id: json['id'] as String,
  url: json['url'] as String,
  urlHeight: (json['height'] as num).toInt(),
  urlWidth: (json['width'] as num).toInt(),
  breeds: (json['breeds'] as List<dynamic>?)
      ?.map((e) => BreedModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'height': instance.urlHeight,
      'width': instance.urlWidth,
      'breeds': instance.breeds?.map((e) => e.toJson()).toList(),
    };
