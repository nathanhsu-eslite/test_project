// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatModel _$CatModelFromJson(Map<String, dynamic> json) => CatModel(
  catImage: CatImage.fromJson(json['catImage'] as Map<String, dynamic>),
  breedModel: json['breedModel'] == null
      ? null
      : BreedModel.fromJson(json['breedModel'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CatModelToJson(CatModel instance) => <String, dynamic>{
  'catImage': instance.catImage,
  'breedModel': instance.breedModel,
};
