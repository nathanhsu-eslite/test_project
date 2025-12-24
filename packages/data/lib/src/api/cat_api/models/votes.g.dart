// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'votes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteModel _$VoteModelFromJson(Map<String, dynamic> json) => VoteModel(
  id: (json['id'] as num).toInt(),
  imageId: json['image_id'] as String,
  subId: json['sub_id'] as String,
  createdAt: json['created_at'] as String,
  countryCode: json['country_code'] as String,
  value: (json['value'] as num).toInt(),
  voteImage: json['image'] == null
      ? null
      : ImageModel.fromJson(json['image'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VoteModelToJson(VoteModel instance) => <String, dynamic>{
  'id': instance.id,
  'image_id': instance.imageId,
  'sub_id': instance.subId,
  'created_at': instance.createdAt,
  'country_code': instance.countryCode,
  'value': instance.value,
  'image': instance.voteImage?.toJson(),
};
