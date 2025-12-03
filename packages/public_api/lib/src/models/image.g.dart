// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatImage _$CatImageFromJson(Map<String, dynamic> json) => CatImage(
  id: json['id'] as String,
  url: json['url'] as String,
  urlHeight: (json['height'] as num).toInt(),
  urlWidth: (json['width'] as num).toInt(),
);

Map<String, dynamic> _$CatImageToJson(CatImage instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'height': instance.urlHeight,
  'width': instance.urlWidth,
};
