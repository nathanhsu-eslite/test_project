import 'package:data/src/api/cat_api/models/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'votes.g.dart';

@JsonSerializable(explicitToJson: true)
class VoteModel {
  final int id;
  @JsonKey(name: 'image_id')
  final String imageId;
  @JsonKey(name: 'sub_id')
  final String subId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'country_code')
  final String countryCode;
  final int value;
  @JsonKey(name: 'image')
  final ImageModel? voteImage;

  factory VoteModel.fromJson(Map<String, dynamic> json) =>
      _$VoteModelFromJson(json);

  VoteModel({
    required this.id,
    required this.imageId,
    required this.subId,
    required this.createdAt,
    required this.countryCode,
    required this.value,
    this.voteImage,
  });
  Map<String, dynamic> toJson() => _$VoteModelToJson(this);
}
