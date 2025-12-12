import 'package:data/src/api/cat_api/cat_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeightModel', () {
    const weightJson = {"imperial": "7  -  10", "metric": "3 - 5"};

    final weightModel = Weight(imperial: "7  -  10", metric: "3 - 5");

    test('fromJson creates correct WeightModel', () {
      final result = Weight.fromJson(weightJson);
      expect(result.imperial, weightModel.imperial);
      expect(result.metric, weightModel.metric);
    });

    test('toJson returns correct map', () {
      final result = weightModel.toJson();
      expect(result, weightJson);
    });
  });
}
