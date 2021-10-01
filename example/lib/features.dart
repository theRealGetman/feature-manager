import 'package:feature_manager/feature_manager.dart';

class Features {
  static const Feature textFeature = Feature(
    key: 'dev-prefs-text-pref',
    title: 'Text pref',
    description: 'This is text preference',
    defaultValue: '',
    type: FeatureType.feature,
    valueType: FeatureValueType.text,
  );

  static const Feature booleanFeature = Feature(
    key: 'dev-prefs-bool-pref',
    title: 'Toggle pref',
    description: 'This is toggle preference',
    defaultValue: false,
    type: FeatureType.feature,
    valueType: FeatureValueType.toggle,
  );

  static const Feature doubleFeature = Feature(
    key: 'dev-prefs-double-pref',
    title: 'Number double pref',
    description: 'This is number double preference',
    defaultValue: 0.0,
    type: FeatureType.feature,
    valueType: FeatureValueType.doubleNumber,
  );
  static const Feature integerFeature = Feature(
    key: 'dev-prefs-integer-pref',
    title: 'Number integer pref',
    description: 'This is number integer preference',
    defaultValue: 0,
    type: FeatureType.feature,
    valueType: FeatureValueType.integerNumber,
  );

  static const List<Feature> values = <Feature>[
    Features.textFeature,
    Features.booleanFeature,
    Features.doubleFeature,
    Features.integerFeature,
  ];
}
