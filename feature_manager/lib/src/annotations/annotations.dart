import 'package:feature_manager/src/models/feature.dart';

class FeatureManagerInit {
  const FeatureManagerInit();
}

class FeatureOptions {
  const FeatureOptions({
    required this.key,
    required this.valueType,
    required this.title,
    this.type = FeatureType.feature,
    this.description = '',
    this.remoteSourceKey = '',
    this.value,
    this.defaultValue,
  });

  final String key;
  final FeatureType type;
  final FeatureValueType valueType;
  final String title;
  final String description;
  final String remoteSourceKey;
  final Object? value;
  final Object? defaultValue;
}
