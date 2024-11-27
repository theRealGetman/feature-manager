import 'package:feature_manager/feature.dart';
import 'package:feature_manager/feature_manager.dart';

/// Extension on `BooleanFeature` to check if the feature is enabled.
extension BooleanFeatureExt on BooleanFeature {
  /// Returns `true` if the feature is enabled, otherwise `false`.
  bool get isEnabled => FeatureManager.instance.isEnabled(this);
}

/// Extension on `DoubleFeature` to get the feature's value.
extension DoubleFeatureExt on DoubleFeature {
  /// Returns the value of the feature as a `double`, or `null` if not set.
  double? get value => FeatureManager.instance.getDouble(this);
}

/// Extension on `IntegerFeature` to get the feature's value.
extension IntegerFeatureExt on IntegerFeature {
  /// Returns the value of the feature as an `int`, or `null` if not set.
  int? get value => FeatureManager.instance.getInt(this);
}

/// Extension on `TextFeature` to get the feature's value.
extension TextFeatureExt on TextFeature {
  /// Returns the value of the feature as a `String`, or `null` if not set.
  String? get value => FeatureManager.instance.getString(this);
}

/// Extension on `Feature` to get the feature's value.
extension FeatureExt on Feature {
  /// Returns the value of the feature as an `Object`, or `null` if not set.
  Object? get value => FeatureManager.instance.getValue(this);
}
