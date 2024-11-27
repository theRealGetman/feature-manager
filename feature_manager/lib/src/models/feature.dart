// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

class BooleanFeature extends Feature {
  BooleanFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    bool? super.value,
    bool? super.defaultValue,
  }) : super(
          valueType: FeatureValueType.toggle,
        );
}

class TextFeature extends Feature {
  TextFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    String? super.value,
    String? super.defaultValue,
  }) : super(
          valueType: FeatureValueType.text,
        );
}

class DoubleFeature extends Feature {
  DoubleFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    double? super.value,
    double? super.defaultValue,
  }) : super(
          valueType: FeatureValueType.doubleNumber,
        );
}

class IntegerFeature extends Feature {
  IntegerFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    int? super.value,
    int? super.defaultValue,
  }) : super(
          valueType: FeatureValueType.integerNumber,
        );
}

class JsonFeature extends Feature {
  JsonFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    super.value,
    super.defaultValue,
  }) : super(
          valueType: FeatureValueType.json,
        );
}

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

enum FeatureValueType { text, toggle, doubleNumber, integerNumber, json }
