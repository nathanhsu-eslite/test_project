import 'package:json_annotation/json_annotation.dart';
import 'weight.dart';

part 'breeds.g.dart';

@JsonSerializable()
class BreedModel {
  @JsonKey(name: 'id')
  final String breedId;
  final String name;
  final String description;
  final String temperament;
  final String origin;
  @JsonKey(name: 'life_span')
  final String lifeSpan;
  @JsonKey(name: 'alt_names')
  final String? altNames;
  @JsonKey(name: 'wikipedia_url')
  final String? wikipediaUrl;
  @JsonKey(name: 'cfa_url')
  final String? cfaUrl;
  @JsonKey(name: 'vetstreet_url')
  final String? vetStreetUrl;
  @JsonKey(name: 'vcahospitals_url')
  final String? vcaHospitalsUrl;
  @JsonKey(name: 'country_code')
  final String countryCode;

  // 數值屬性 (1-5)
  final int adaptability;
  @JsonKey(name: 'affection_level')
  final int affectionLevel;
  @JsonKey(name: 'child_friendly')
  final int childFriendly;
  @JsonKey(name: 'dog_friendly')
  final int dogFriendly;
  @JsonKey(name: 'energy_level')
  final int energyLevel;
  final int grooming;
  @JsonKey(name: 'health_issues')
  final int healthIssues;
  final int intelligence;
  @JsonKey(name: 'shedding_level')
  final int sheddingLevel;
  @JsonKey(name: 'social_needs')
  final int socialNeeds;
  @JsonKey(name: 'stranger_friendly')
  final int strangerFriendly;
  final int vocalisation;

  // 布林屬性 (0 或 1)
  final int experimental;
  final int hairless;
  final int natural;
  final int rare;
  final int rex;
  @JsonKey(name: 'suppressed_tail')
  final int suppressedTail;
  @JsonKey(name: 'short_legs')
  final int shortLegs;
  final int hypoallergenic;
  final int? indoor;
  final int? lap;
  @JsonKey(name: 'reference_image_id')
  final String? referenceImageId;
  final Weight? weight;

  BreedModel({
    required this.breedId,
    required this.name,
    required this.description,
    required this.temperament,
    required this.origin,
    required this.lifeSpan,
    this.altNames,
    this.wikipediaUrl,
    this.cfaUrl,
    this.vetStreetUrl,
    this.vcaHospitalsUrl,
    required this.countryCode,
    required this.adaptability,
    required this.affectionLevel,
    required this.childFriendly,
    required this.dogFriendly,
    required this.energyLevel,
    required this.grooming,
    required this.healthIssues,
    required this.intelligence,
    required this.sheddingLevel,
    required this.socialNeeds,
    required this.strangerFriendly,
    required this.vocalisation,
    required this.experimental,
    required this.hairless,
    required this.natural,
    required this.rare,
    required this.rex,
    required this.suppressedTail,
    required this.shortLegs,
    required this.hypoallergenic,
    this.indoor,
    this.lap,
    this.referenceImageId,
    this.weight,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) =>
      _$BreedModelFromJson(json);
  Map<String, dynamic> toJson() => _$BreedModelToJson(this);
}
