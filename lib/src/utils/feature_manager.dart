import 'dart:convert';

import 'package:feature_manager/src/domain/models/feature.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureManager {
  final SharedPreferences sharedPreferences;

  FeatureManager({
    required this.sharedPreferences,
  });

  bool isEnabled(Feature feature) {
    if (feature.valueType == FeatureValueType.toggle) {
      return sharedPreferences.getBool(feature.key) ??
          feature.defaultValue as bool? ??
          false;
    } else {
      return false;
    }
  }

  Object? getValue(Feature feature) {
    return sharedPreferences.get(feature.key) ?? feature.defaultValue;
  }

  String? getString(Feature feature) {
    return sharedPreferences.getString(feature.key);
  }

  int? getInt(Feature feature) {
    return sharedPreferences.getInt(feature.key);
  }

  double? getDouble(Feature feature) {
    return sharedPreferences.getDouble(feature.key);
  }

  Map<String, dynamic>? getJson(Feature feature) {
    final String? value = getString(feature);
    if (value == null || value.isEmpty) {
      return null;
    }
    final Map<String, dynamic> decodedMap =
        jsonDecode(value) as Map<String, dynamic>;
    return decodedMap;
  }
}
