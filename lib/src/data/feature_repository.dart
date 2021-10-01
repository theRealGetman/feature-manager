import 'dart:async';

import 'package:feature_manager/src/domain/models/feature.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureRepository {
  FeatureRepository(this.featuresList) {
    _featuresStreamController = StreamController<List<Feature>>.broadcast();
  }

  final List<Feature> featuresList;

  late StreamController<List<Feature>> _featuresStreamController;

  Stream<List<Feature>> getFeaturesStream() => _featuresStreamController.stream;

  Future<List<Feature>> getFeatures() async {
    final List<Feature> updatedFeatures = [];
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    for (final Feature feature in featuresList) {
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
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    switch (feature.valueType) {
      case FeatureValueType.toggle:
        await sharedPreferences.setBool(feature.key, value as bool);
        break;
      case FeatureValueType.doubleNumber:
        await sharedPreferences.setDouble(feature.key, value as double);
        break;
      case FeatureValueType.integerNumber:
        await sharedPreferences.setInt(feature.key, value as int);
        break;
      case FeatureValueType.text:
        await sharedPreferences.setString(feature.key, value as String);
        break;
    }

    getFeatures();
  }

  Object? _getValue(SharedPreferences sharedPreferences, Feature feature) =>
      sharedPreferences.get(feature.key) ?? feature.defaultValue;
}
