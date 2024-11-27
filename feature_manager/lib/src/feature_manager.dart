import 'dart:convert';

import 'package:feature_manager/src/models/feature.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureManager {
  FeatureManager._(this._sharedPreferences);

  static FeatureManager? _instance;

  final SharedPreferences _sharedPreferences;

  /// Retrieves the instance of the FeatureManager class.
  ///
  /// This method checks if the instance has already been created. If not, it initializes it by
  /// retrieving the shared preferences and creating a new instance of the FeatureManager class.
  ///
  /// Returns a `Future` that resolves to the instance of the FeatureManager class.
  static Future<FeatureManager> getInstance() async {
    if (_instance == null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      _instance = FeatureManager._(sharedPreferences);
    }
    return _instance!;
  }

  /// Returns the singleton instance of [FeatureManager].
  /// 
  /// Throws an [Exception] if the instance is not initialized.
  /// Ensure to call `getInstance()` before accessing this property.
  static FeatureManager get instance {
    if (_instance == null) {
      throw Exception('FeatureManager instance is not initialized. Call getInstance() first.');
    }
    return _instance!;
  }

  /// Disposes the instance of the class.
  ///
  /// This function sets the `_instance` variable to `null`, effectively disposing of the instance.
  static void dispose() {
    _instance = null;
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
      return _sharedPreferences.getBool(feature.key) ?? feature.defaultValue as bool? ?? false;
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
    return _sharedPreferences.get(feature.key) ?? feature.defaultValue;
  }

  /// Retrieves a string value from the shared preferences based on the provided [feature] key.
  ///
  /// The [feature] parameter specifies the feature for which the string value is retrieved.
  ///
  /// Returns the string value associated with the [feature] key, or `null` if the key does not exist.
  String? getString(Feature feature) {
    return _sharedPreferences.getString(feature.key);
  }

  /// Retrieves an integer value associated with the given [feature] from the shared preferences.
  ///
  /// The [feature] parameter specifies the feature for which the integer value is to be retrieved.
  ///
  /// Returns the integer value associated with the [feature] key in the shared preferences, or null if the key is not found.
  int? getInt(Feature feature) {
    return _sharedPreferences.getInt(feature.key);
  }

  /// Retrieves a double value associated with the given [feature].
  ///
  /// The [feature] parameter specifies the feature for which the double value is
  /// to be retrieved.
  ///
  /// Returns the double value associated with the given [feature], or null if
  /// no value is found.
  double? getDouble(Feature feature) {
    return _sharedPreferences.getDouble(feature.key);
  }

  /// Retrieves and decodes a JSON string from the provided Feature object, returning the decoded Map<String, dynamic> or null if the string is empty or null.
  ///
  /// The [feature] parameter specifies the feature for which the double value is
  /// to be retrieved.
  ///
  /// Returns the decoded Map<String, dynamic> if the JSON string is not empty or null; otherwise, returns null.
  Map<String, dynamic>? getJson(Feature feature) {
    final value = getString(feature);
    if (value == null || value.isEmpty) {
      return null;
    }
    final decodedMap = jsonDecode(value) as Map<String, dynamic>;
    return decodedMap;
  }
}
