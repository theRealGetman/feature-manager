// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'features.dart';

// **************************************************************************
// FeatureGenerator
// **************************************************************************

class _$AppFeatures implements AppFeatures {
  factory _$AppFeatures() {
    return _instance;
  }
  static final _$AppFeatures _instance = _$AppFeatures._internal();
  _$AppFeatures._internal()
      : textFeature = TextFeature(
          key: 'dev-prefs-text-pref',
          title: 'Text pref',
          description: 'This is text preference',
          defaultValue: '',
        ),
        booleanFeature = BooleanFeature(
          key: 'dev-prefs-bool-pref',
          title: 'Toggle pref',
          description: 'This is toggle preference',
          defaultValue: null,
        ),
        doubleFeature = DoubleFeature(
          key: 'dev-prefs-double-pref',
          title: 'Number double pref',
          description: 'This is number double preference',
          defaultValue: null,
        ),
        integerFeature = IntegerFeature(
          key: 'dev-prefs-integer-pref',
          title: 'Number integer pref',
          description: 'This is number integer preference',
          defaultValue: null,
        ),
        jsonFeature = JsonFeature(
          key: 'dev-prefs-json-pref',
          title: 'Json pref',
          description: 'This is json preference',
          defaultValue: '{value: \'Json default value\'}',
        );
  @override
  final TextFeature textFeature;
  @override
  final BooleanFeature booleanFeature;
  @override
  final DoubleFeature doubleFeature;
  @override
  final IntegerFeature integerFeature;
  @override
  final JsonFeature jsonFeature;
}

extension AppFeaturesExt on AppFeatures {
  List<Feature> get values => [
        textFeature,
        booleanFeature,
        doubleFeature,
        integerFeature,
        jsonFeature,
      ];
}

extension FeatureManagerExt on FeatureManager {
  TextFeature get textFeature => _$AppFeatures().textFeature;
  BooleanFeature get booleanFeature => _$AppFeatures().booleanFeature;
  DoubleFeature get doubleFeature => _$AppFeatures().doubleFeature;
  IntegerFeature get integerFeature => _$AppFeatures().integerFeature;
  JsonFeature get jsonFeature => _$AppFeatures().jsonFeature;
}
