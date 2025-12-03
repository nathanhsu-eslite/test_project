import 'package:flutter_test/flutter_test.dart';
import 'package:public_api/public_api.dart';

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
