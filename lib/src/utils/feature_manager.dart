import 'package:feature_manager/src/domain/models/feature.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeatureManager {
  Future<bool> isEnabled(Feature feature) async {
    if (feature.valueType == FeatureValueType.toggle) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getBool(feature.key) ??
          feature.defaultValue as bool? ??
          false;
    } else {
      return false;
    }
  }

  Future<Object?> getValue(Feature feature) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(feature.key) ?? feature.defaultValue;
  }
}
