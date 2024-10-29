import 'package:feature_manager/feature_manager.dart';
import 'package:flutter/foundation.dart';

@immutable
class FeatureManagerInit {
  const FeatureManagerInit();
}

@immutable
class FeatureManagerBuilder {
  const FeatureManagerBuilder();
}

@immutable
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
