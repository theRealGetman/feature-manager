import 'dart:convert';

import 'package:feature_manager/src/domain/models/feature.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureManager {
  FeatureManager._();

  static final FeatureManager _instance = FeatureManager._();

  static FeatureManager get instance => _instance;

  late SharedPreferences sharedPreferences;

  /// Initializes the object with the provided [sharedPreferences].
  /// MUST be called before using the object.
  ///
  /// The [sharedPreferences] parameter is an instance of [SharedPreferences]
  /// that will be used by the object to store and retrieve data.
  ///
  /// This function does not return anything.
  void initialize(SharedPreferences sharedPreferences) {
    this.sharedPreferences = sharedPreferences;
  }

  /// Determines if the given [feature] is enabled.
  ///
  /// The function checks if the [feature]'s value type is [FeatureValueType.toggle].
  /// If it is, the function retrieves the boolean value associated with the [feature]'s key
  /// from the shared preferences. If the value is not found, it returns the default value
  /// of the [feature] if it is of type bool. If the default value is not available, it returns false.
  /// If the [feature]'s value type is not [FeatureValueType.toggle], the function returns false.
  ///
  /// Parameters:
  /// - `feature`: The [Feature] object to check.
  ///
  /// Returns:
  /// - `bool`: `true` if the [feature] is enabled, `false` otherwise.
  bool isEnabled(Feature feature) {
    if (feature.valueType == FeatureValueType.toggle) {
      return sharedPreferences.getBool(feature.key) ??
          feature.defaultValue as bool? ??
          false;
    } else {
      return false;
    }
  }

  /// Retrieves the value associated with the given [feature] from the shared preferences.
  ///
  /// The function first checks if there is a value stored for the given [feature] key in the shared preferences.
  /// If a value is found, it is returned. Otherwise, the default value of the [feature] is returned.
  ///
  /// Parameters:
  ///   - `feature`: The [Feature] object for which the value needs to be retrieved.
  ///
  /// Returns:
  ///   - The value associated with the [feature] key in the shared preferences, or the default value of the [feature] if no value is found.
  Object? getValue(Feature feature) {
    return sharedPreferences.get(feature.key) ?? feature.defaultValue;
  }

  /// Retrieves a string value from the shared preferences based on the provided [feature] key.
  ///
  /// The [feature] parameter specifies the feature for which the string value is retrieved.
  ///
  /// Returns the string value associated with the [feature] key, or `null` if the key does not exist.
  String? getString(Feature feature) {
    return sharedPreferences.getString(feature.key);
  }

  /// Retrieves an integer value associated with the given [feature] from the shared preferences.
  ///
  /// The [feature] parameter specifies the feature for which the integer value is to be retrieved.
  ///
  /// Returns the integer value associated with the [feature] key in the shared preferences, or null if the key is not found.
  int? getInt(Feature feature) {
    return sharedPreferences.getInt(feature.key);
  }

  /// Retrieves a double value associated with the given [feature].
  ///
  /// The [feature] parameter specifies the feature for which the double value is
  /// to be retrieved.
  ///
  /// Returns the double value associated with the given [feature], or null if
  /// no value is found.
  double? getDouble(Feature feature) {
    return sharedPreferences.getDouble(feature.key);
  }

  /// Retrieves and decodes a JSON string from the provided Feature object, returning the decoded Map<String, dynamic> or null if the string is empty or null.
  Map<String, dynamic>? getJson(Feature feature) {
    final value = getString(feature);
    if (value == null || value.isEmpty) {
      return null;
    }
    final decodedMap = jsonDecode(value) as Map<String, dynamic>;
    return decodedMap;
  }
}
