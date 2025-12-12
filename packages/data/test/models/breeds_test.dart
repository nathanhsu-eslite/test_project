import 'package:data/src/api/cat_api/cat_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BreedModel', () {
    const breedJson = {
      "weight": {"imperial": "7  -  10", "metric": "3 - 5"},
      "id": "abys",
      "name": "Abyssinian",
      "cfa_url": "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
      "vetstreet_url": "http://www.vetstreet.com/cats/abyssinian",
      "vcahospitals_url":
          "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
      "temperament": "Active, Energetic, Independent, Intelligent, Gentle",
      "origin": "Egypt",
      "country_code": "EG",
      "description":
          "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
      "life_span": "14 - 15",
      "indoor": 0,
      "lap": 1,
      "alt_names": "",
      "adaptability": 5,
      "affection_level": 5,
      "child_friendly": 3,
      "dog_friendly": 4,
      "energy_level": 5,
      "grooming": 1,
      "health_issues": 2,
      "intelligence": 5,
      "shedding_level": 2,
      "social_needs": 5,
      "stranger_friendly": 5,
      "vocalisation": 1,
      "experimental": 0,
      "hairless": 0,
      "natural": 1,
      "rare": 0,
      "rex": 0,
      "suppressed_tail": 0,
      "short_legs": 0,
      "wikipedia_url": "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
      "hypoallergenic": 0,
      "reference_image_id": "0XYvRd7oD",
    };

    final breedModel = BreedModel(
      breedId: "abys",
      name: "Abyssinian",
      cfaUrl: "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
      vetStreetUrl: "http://www.vetstreet.com/cats/abyssinian",
      vcaHospitalsUrl:
          "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
      temperament: "Active, Energetic, Independent, Intelligent, Gentle",
      origin: "Egypt",
      countryCode: "EG",
      description:
          "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
      lifeSpan: "14 - 15",
      indoor: 0,
      lap: 1,
      altNames: "",
      adaptability: 5,
      affectionLevel: 5,
      childFriendly: 3,
      dogFriendly: 4,
      energyLevel: 5,
      grooming: 1,
      healthIssues: 2,
      intelligence: 5,
      sheddingLevel: 2,
      socialNeeds: 5,
      strangerFriendly: 5,
      vocalisation: 1,
      experimental: 0,
      hairless: 0,
      natural: 1,
      rare: 0,
      rex: 0,
      suppressedTail: 0,
      shortLegs: 0,
      wikipediaUrl: "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
      hypoallergenic: 0,
      referenceImageId: "0XYvRd7oD",
      weight: Weight(imperial: "7  -  10", metric: "3 - 5"),
    );

    test('fromJson creates a BreedModel from a map', () {
      final result = BreedModel.fromJson(breedJson);
      expect(result.breedId, breedModel.breedId);
      expect(result.name, breedModel.name);
      expect(result.cfaUrl, breedModel.cfaUrl);
      expect(result.vetStreetUrl, breedModel.vetStreetUrl);
      expect(result.vcaHospitalsUrl, breedModel.vcaHospitalsUrl);
      expect(result.temperament, breedModel.temperament);
      expect(result.origin, breedModel.origin);
      expect(result.countryCode, breedModel.countryCode);
      expect(result.description, breedModel.description);
      expect(result.lifeSpan, breedModel.lifeSpan);
      expect(result.indoor, breedModel.indoor);
      expect(result.lap, breedModel.lap);
      expect(result.altNames, breedModel.altNames);
      expect(result.adaptability, breedModel.adaptability);
      expect(result.affectionLevel, breedModel.affectionLevel);
      expect(result.childFriendly, breedModel.childFriendly);
      expect(result.dogFriendly, breedModel.dogFriendly);
      expect(result.energyLevel, breedModel.energyLevel);
      expect(result.grooming, breedModel.grooming);
      expect(result.healthIssues, breedModel.healthIssues);
      expect(result.intelligence, breedModel.intelligence);
      expect(result.sheddingLevel, breedModel.sheddingLevel);
      expect(result.socialNeeds, breedModel.socialNeeds);
      expect(result.strangerFriendly, breedModel.strangerFriendly);
      expect(result.vocalisation, breedModel.vocalisation);
      expect(result.experimental, breedModel.experimental);
      expect(result.hairless, breedModel.hairless);
      expect(result.natural, breedModel.natural);
      expect(result.rare, breedModel.rare);
      expect(result.rex, breedModel.rex);
      expect(result.suppressedTail, breedModel.suppressedTail);
      expect(result.shortLegs, breedModel.shortLegs);
      expect(result.wikipediaUrl, breedModel.wikipediaUrl);
      expect(result.hypoallergenic, breedModel.hypoallergenic);
      expect(result.referenceImageId, breedModel.referenceImageId);
      expect(result.weight?.imperial, breedModel.weight?.imperial);
      expect(result.weight?.metric, breedModel.weight?.metric);
    });

    test('toJson creates a map from a BreedModel', () {
      final result = breedModel.toJson();
      final Weight weight = breedModel.weight!;
      final Map<String, dynamic> weightResult = weight.toJson();
      result['weight'] = weightResult;
      expect(result, breedJson);
    });
  });
}
