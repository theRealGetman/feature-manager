import 'dart:async';

import 'package:feature_manager/feature.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureRepository {
  FeatureRepository({
    required this.featuresList,
    required this.sharedPreferences,
  }) {
    _featuresStreamController = StreamController<List<Feature>>.broadcast();
  }

  final List<Feature> featuresList;
  final SharedPreferences sharedPreferences;

  late StreamController<List<Feature>> _featuresStreamController;

  Stream<List<Feature>> getFeaturesStream() => _featuresStreamController.stream;

  Future<List<Feature>> getFeatures() async {
    final updatedFeatures = <Feature>[];
    await sharedPreferences.reload();

    for (final feature in featuresList) {
      updatedFeatures.add(
        feature.copyWith(
          value: _getValue(sharedPreferences, feature),
        ),
      );
    }

    _featuresStreamController.add(updatedFeatures);

    return updatedFeatures;
  }

  Future<void> putValue(
    Feature feature,
    Object? value,
  ) async {
    switch (feature.valueType) {
      case FeatureValueType.toggle:
        await sharedPreferences.setBool(feature.key, value as bool);
      case FeatureValueType.doubleNumber:
        await sharedPreferences.setDouble(feature.key, value as double);
      case FeatureValueType.integerNumber:
        await sharedPreferences.setInt(feature.key, value as int);
      case FeatureValueType.text:
      case FeatureValueType.json:
        await sharedPreferences.setString(feature.key, value as String);
    }

    await getFeatures();
  }

  Object? _getValue(SharedPreferences sharedPreferences, Feature feature) =>
      sharedPreferences.get(feature.key) ?? feature.defaultValue;
}
