import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:feature_manager/annotations.dart';
import 'package:feature_manager/feature.dart';
import 'package:source_gen/source_gen.dart';

class FeatureGenerator extends GeneratorForAnnotation<FeatureManagerInit> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '`@FeatureManagerInit` can only be used on classes.',
        element: element,
      );
    }

    final classElement = element;
    final buffer = StringBuffer();
    final featureFieldNames = <String>[];

    buffer.writeln('class _\$${classElement.name} implements ${classElement.name} {');
    buffer.writeln('''
    factory  _\$${classElement.name}() {
      return _instance;
    }''');

    buffer.writeln(
      ' static final _\$${classElement.name} _instance = _\$${classElement.name}._internal();',
    );

    // Start the constructor with initializer list
    buffer.writeln('  _\$${classElement.name}._internal()');

    final initializers = <String>[];
    final fieldDeclarations = <String>[];

    for (final field in classElement.fields) {
      final featureOptions = _getFeatureOptions(field);
      if (featureOptions == null) {
        log.warning('Field ${field.name} does not have a valid FeatureOptions annotation.');
        continue;
      }

      final featureType = _getFeatureType(featureOptions.valueType);
      final initializer = _generateFeatureInitializer(field.name, featureType, featureOptions);
      initializers.add(initializer);

      // Collect the feature field names
      featureFieldNames.add(field.name);

      // Generate the field declaration
      fieldDeclarations.add('  @override\n  final $featureType ${field.name};');
    }

    // Add initializers to the constructor
    if (initializers.isNotEmpty) {
      buffer.writeln('      : ${initializers.join(',\n        ')};');
    } else {
      buffer.writeln('      ;');
    }

    // Add field declarations
    fieldDeclarations.forEach(buffer.writeln);

    buffer.writeln('}');

    buffer.writeln('extension ${classElement.name}Ext on ${classElement.name} {');
    buffer.writeln('  List<Feature> get values => [');
    for (final fieldName in featureFieldNames) {
      buffer.writeln('        $fieldName,');
    }
    buffer.writeln('      ];');
    buffer.writeln('}');

    // Generate the extension
    buffer.writeln('extension FeatureManagerExt on FeatureManager {');
    for (final field in classElement.fields) {
      final featureOptions = _getFeatureOptions(field);
      if (featureOptions == null) {
        continue;
      }
      final featureType = _getFeatureType(featureOptions.valueType);
      buffer.writeln(
        '  $featureType get ${field.name} => _\$${classElement.name}().${field.name};',
      );
    }
    buffer.writeln('}');

    final generatedCode = buffer.toString();
    log.info('Generated code:\n$generatedCode');
    return generatedCode;
  }

  String _getFeatureType(FeatureValueType valueType) {
    switch (valueType) {
      case FeatureValueType.toggle:
        return 'BooleanFeature';
      case FeatureValueType.text:
        return 'TextFeature';
      case FeatureValueType.doubleNumber:
        return 'DoubleFeature';
      case FeatureValueType.integerNumber:
        return 'IntegerFeature';
      case FeatureValueType.json:
        return 'JsonFeature';
    }
  }

  FeatureOptions? _getFeatureOptions(FieldElement field) {
    const typeChecker = TypeChecker.fromRuntime(FeatureOptions);
    for (final metadata in field.metadata) {
      final elementValue = metadata.computeConstantValue();
      if (elementValue == null || !typeChecker.isExactlyType(elementValue.type!)) {
        continue;
      }
      return FeatureOptions(
        key: elementValue.getField('key')?.toStringValue() ?? '',
        title: elementValue.getField('title')?.toStringValue() ?? '',
        description: elementValue.getField('description')?.toStringValue() ?? '',
        defaultValue: elementValue.getField('defaultValue')?.toStringValue(),
        valueType: FeatureValueType
            .values[elementValue.getField('valueType')?.getField('index')?.toIntValue() ?? 0],
      );
    }
    return null;
  }

  String _generateFeatureInitializer(String fieldName, String featureType, FeatureOptions options) {
    return '''
        $fieldName = $featureType(
          key: '${options.key}',
          title: '${options.title}',
          description: '${options.description}',
          defaultValue: ${_formatDefaultValue(options.defaultValue)},
        )''';
  }

  String _formatDefaultValue(dynamic value) {
    if (value is String) {
      return "'${value.replaceAll("'", r"\'")}'";
    } else if (value is bool || value is num) {
      return value.toString();
    }
    return 'null';
  }
}
