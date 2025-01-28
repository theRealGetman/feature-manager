// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

class BooleanFeature extends Feature<bool> {
  BooleanFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    super.defaultValue,
    super.type,
  });
}

class TextFeature extends Feature<String> {
  TextFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    super.defaultValue,
    super.type,
  });
}

class DoubleFeature extends Feature<double> {
  DoubleFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    super.defaultValue,
    super.type,
  });
}

class IntegerFeature extends Feature<int> {
  IntegerFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    super.defaultValue,
    super.type,
  });
}

class JsonFeature extends Feature<Object> {
  JsonFeature({
    required super.key,
    required super.title,
    super.description,
    super.remoteSourceKey,
    super.defaultValue,
    super.type,
  });
}

class Feature<T> {
  const Feature({
    required this.key,
    required this.title,
    this.type = FeatureType.feature,
    this.description = '',
    this.remoteSourceKey = '',
    this.defaultValue,
  });

  final String key;
  final FeatureType type;
  final String title;
  final String description;
  final String remoteSourceKey;
  final T? defaultValue;

  Feature<T> copyWith({
    String? key,
    FeatureType? type,
    String? title,
    String? description,
    String? remoteSourceKey,
    T? defaultValue,
  }) {
    return Feature(
      key: key ?? this.key,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      remoteSourceKey: remoteSourceKey ?? this.remoteSourceKey,
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
          title == other.title &&
          description == other.description &&
          remoteSourceKey == other.remoteSourceKey &&
          defaultValue == other.defaultValue;

  @override
  int get hashCode =>
      key.hashCode ^
      type.hashCode ^
      title.hashCode ^
      description.hashCode ^
      remoteSourceKey.hashCode ^
      defaultValue.hashCode;

  @override
  String toString() {
    return 'Feature{key: $key, type: $type, title: $title, description: $description, remoteSourceKey: $remoteSourceKey, defaultValue: $defaultValue}';
  }
}

enum FeatureType { feature, experiment }
