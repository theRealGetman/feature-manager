import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:feature_manager/feature_manager.dart';
import 'package:source_gen/source_gen.dart';

class FeatureOptionsGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    const featureOptionsChecker = TypeChecker.fromRuntime(FeatureOptions);

    final annotatedFields = library.annotatedWith(featureOptionsChecker);

    if (annotatedFields.isEmpty) {
      return '';
    }

    final buffer = StringBuffer();

    buffer.writeln('class GeneratedFeatures {');

    for (final annotatedElement in annotatedFields) {
      final element = annotatedElement.element;
      if (element is! FieldElement) {
        continue;
      }

      final fieldName = element.name;
      final fieldType = element.type.getDisplayString();

      final annotation = annotatedElement.annotation;
      final reader = ConstantReader(annotation.objectValue);

      final key = reader.read('key').stringValue;
      final title = reader.read('title').stringValue;
      final description = reader.read('description').stringValue;
      final defaultValue = reader.read('defaultValue').stringValue;
      final valueType = reader.read('valueType').revive().accessor;

      buffer.writeln('  static final $fieldType $fieldName = Feature(');
      buffer.writeln("    key: '$key',");
      buffer.writeln("    title: '$title',");
      buffer.writeln("    description: '$description',");
      buffer.writeln("    defaultValue: '$defaultValue',");
      buffer.writeln('    valueType: FeatureValueType.$valueType,');
      buffer.writeln('  );');
    }

    buffer.writeln('}');

    return buffer.toString();
  }
}
