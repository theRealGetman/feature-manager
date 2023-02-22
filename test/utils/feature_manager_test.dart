import 'package:feature_manager/feature_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late FeatureManager _target;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    sharedPreferences = await SharedPreferences.getInstance();
    _target = FeatureManager(
      sharedPreferences: sharedPreferences,
    );
  });

  group('isEnabled', () {
    test('when feature is toggle should return value', () async {
      // given
      SharedPreferences.setMockInitialValues(<String, Object>{
        'key': true,
      });
      sharedPreferences = await SharedPreferences.getInstance();
      _target = FeatureManager(
        sharedPreferences: sharedPreferences,
      );
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.toggle,
      );

      // when
      final bool value = _target.isEnabled(feature);

      // then
      expect(value, true);
    });

    test('when feature is toggle and value is null should return default value',
        () {
      // given
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.toggle,
        defaultValue: true,
      );

      // when
      final bool value = _target.isEnabled(feature);

      // then
      expect(value, true);
    });

    test(
        'when feature is toggle and value is null and default value is null should return false',
        () {
      // given
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.toggle,
      );

      // when
      final bool value = _target.isEnabled(feature);

      // then
      expect(value, false);
    });

    test('when feature is not toggle should return false', () {
      // given
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.text,
      );

      // when
      final bool value = _target.isEnabled(feature);

      // then
      expect(value, false);
    });
  });

  group('getValue', () {
    test('return stored value', () async {
      // given
      SharedPreferences.setMockInitialValues(<String, Object>{
        'key': 'some text',
      });
      sharedPreferences = await SharedPreferences.getInstance();
      _target = FeatureManager(
        sharedPreferences: sharedPreferences,
      );
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.text,
      );

      // when
      final String value = _target.getValue(feature) as String;

      // then
      expect(value, 'some text');
    });

    test('when stored value is null should return default value', () {
      // given
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.text,
        defaultValue: 'default text',
      );

      // when
      final String value = _target.getValue(feature) as String;

      // then
      expect(value, 'default text');
    });
  });
}
