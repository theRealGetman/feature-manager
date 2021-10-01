class Feature {
  const Feature({
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

  Feature copyWith({
    String? key,
    FeatureType? type,
    FeatureValueType? valueType,
    String? title,
    String? description,
    String? remoteSourceKey,
    Object? value,
    Object? defaultValue,
  }) {
    return Feature(
      key: key ?? this.key,
      type: type ?? this.type,
      valueType: valueType ?? this.valueType,
      title: title ?? this.title,
      description: description ?? this.description,
      remoteSourceKey: remoteSourceKey ?? this.remoteSourceKey,
      value: value ?? this.value,
      defaultValue: defaultValue ?? this.defaultValue,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Feature &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          type == other.type &&
          valueType == other.valueType &&
          title == other.title &&
          description == other.description &&
          remoteSourceKey == other.remoteSourceKey &&
          value == other.value &&
          defaultValue == other.defaultValue;

  @override
  int get hashCode =>
      key.hashCode ^
      type.hashCode ^
      valueType.hashCode ^
      title.hashCode ^
      description.hashCode ^
      remoteSourceKey.hashCode ^
      value.hashCode ^
      defaultValue.hashCode;

  @override
  String toString() {
    return 'Feature{key: $key, type: $type, valueType: $valueType, title: $title, description: $description, remoteSourceKey: $remoteSourceKey, value: $value, defaultValue: $defaultValue}';
  }
}

enum FeatureType { feature, experiment }
enum FeatureValueType { text, toggle, doubleNumber, integerNumber }
