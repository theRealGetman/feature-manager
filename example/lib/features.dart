import 'package:feature_manager/annotations.dart';
import 'package:feature_manager/feature.dart';
import 'package:feature_manager/feature_manager.dart';

part 'features.fm.dart';

@FeatureManagerInit()
class AppFeatures {
  AppFeatures({
    required this.textFeature,
    required this.booleanFeature,
    required this.doubleFeature,
    required this.integerFeature,
    required this.jsonFeature,
  });

  factory AppFeatures.instance() => _$AppFeatures();

  @FeatureOptions(
    key: 'dev-prefs-text-pref',
    title: 'Text pref',
    description: 'This is text preference',
    defaultValue: '',
    valueType: FeatureValueType.text,
  )
  final Feature textFeature;

  @FeatureOptions(
    key: 'dev-prefs-bool-pref',
    title: 'Toggle pref',
    description: 'This is toggle preference',
    defaultValue: false,
    valueType: FeatureValueType.toggle,
  )
  final Feature booleanFeature;

  @FeatureOptions(
    key: 'dev-prefs-double-pref',
    title: 'Number double pref',
    description: 'This is number double preference',
    defaultValue: null,
    valueType: FeatureValueType.doubleNumber,
  )
  final Feature doubleFeature;

  @FeatureOptions(
    key: 'dev-prefs-integer-pref',
    title: 'Number integer pref',
    description: 'This is number integer preference',
    defaultValue: null,
    valueType: FeatureValueType.integerNumber,
  )
  final Feature integerFeature;

  @FeatureOptions(
    key: 'dev-prefs-json-pref',
    title: 'Json pref',
    description: 'This is json preference',
    defaultValue: "{value: 'Json default value'}",
    valueType: FeatureValueType.json,
  )
  final Feature jsonFeature;
}
