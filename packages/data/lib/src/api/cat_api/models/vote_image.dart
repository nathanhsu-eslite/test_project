import 'package:json_annotation/json_annotation.dart';

part 'vote_image.g.dart';

@JsonSerializable(explicitToJson: true)
class VoteImage {
  final String id;
  final String url;

  VoteImage({required this.id, required this.url});
  factory VoteImage.fromJson(Map<String, dynamic> json) =>
      _$VoteImageFromJson(json);
  Map<String, dynamic> toJson() => _$VoteImageToJson(this);
}
