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
          defaultValue: 'Some default text',
        ),
        booleanFeature = BooleanFeature(
          key: 'dev-prefs-bool-pref',
          title: 'Toggle pref',
          description: 'This is toggle preference',
          defaultValue: false,
        ),
        doubleFeature = DoubleFeature(
          key: 'dev-prefs-double-pref',
          title: 'Number double pref',
          description: 'This is number double preference',
          defaultValue: 2.2,
        ),
        integerFeature = IntegerFeature(
          key: 'dev-prefs-integer-pref',
          title: 'Number integer pref',
          description: 'This is number integer preference',
          defaultValue: 1,
        ),
        jsonFeature = JsonFeature(
          key: 'dev-prefs-json-pref',
          title: 'Json pref',
          description: 'This is json preference',
          defaultValue: '{value: \'Json default value\'}',
        ),
        nullableTextFeature = TextFeature(
          key: 'dev-prefs-text-pref',
          title: 'Text pref',
          description: 'This is text preference',
          defaultValue: null,
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
  @override
  final TextFeature nullableTextFeature;
}

extension AppFeaturesExt on AppFeatures {
  List<Feature> get values => [
        textFeature,
        booleanFeature,
        doubleFeature,
        integerFeature,
        jsonFeature,
        nullableTextFeature,
      ];
}

extension FeatureManagerExt on FeatureManager {
  TextFeature get textFeature => _$AppFeatures().textFeature;
  BooleanFeature get booleanFeature => _$AppFeatures().booleanFeature;
  DoubleFeature get doubleFeature => _$AppFeatures().doubleFeature;
  IntegerFeature get integerFeature => _$AppFeatures().integerFeature;
  JsonFeature get jsonFeature => _$AppFeatures().jsonFeature;
  TextFeature get nullableTextFeature => _$AppFeatures().nullableTextFeature;
}
