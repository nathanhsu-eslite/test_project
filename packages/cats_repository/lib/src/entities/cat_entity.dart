import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:public_api/public_api.dart';

part 'cat_entity.g.dart';

@JsonSerializable()
class CatModel extends Equatable {
  final CatImage catImage;
  @JsonKey(includeIfNull: true)
  final BreedModel? breedModel;

  const CatModel({required this.catImage, this.breedModel});

  factory CatModel.fromJson(Map<String, dynamic> json) =>
      _$CatModelFromJson(json);
  Map<String, dynamic> toJson() => _$CatModelToJson(this);

  @override
  List<Object?> get props => [catImage, breedModel];
}
