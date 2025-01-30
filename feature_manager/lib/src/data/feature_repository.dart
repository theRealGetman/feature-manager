import 'dart:async';
import 'dart:convert';

import 'package:feature_manager/feature.dart';
import 'package:feature_manager/feature_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureRepository {
  FeatureRepository({
    required this.featuresList,
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences {
    _featuresStreamController = StreamController<List<Feature<dynamic>>>.broadcast();
  }

  final List<Feature<dynamic>> featuresList;
  final SharedPreferences _sharedPreferences;

  late StreamController<List<Feature<dynamic>>> _featuresStreamController;

  Stream<List<Feature<dynamic>>> getFeaturesStream() => _featuresStreamController.stream;

  Future<List<Feature<dynamic>>> getFeatures() async {
    _featuresStreamController.add(featuresList);
    return featuresList;
  }

  Future<void> putValue(
    Feature<dynamic> feature,
    Object? value,
  ) async {
    if (value == null) {
      await _sharedPreferences.remove(feature.key);
      await getFeatures();
      return;
    }
    if (feature.isText && value is String) {
      await _sharedPreferences.setString(feature.key, value);
    } else if (feature.isJson && value is Map<String, dynamic>) {
      await _sharedPreferences.setString(feature.key, jsonEncode(value));
    } else if (feature.isBoolean && value is bool) {
      await _sharedPreferences.setBool(feature.key, value);
    } else if (feature.isDouble && value is double) {
      await _sharedPreferences.setDouble(feature.key, value);
    } else if (feature.isInteger && value is int) {
      await _sharedPreferences.setInt(feature.key, value);
    } else {
      throw Exception('Invalid value type');
    }
    await getFeatures();
  }
}
