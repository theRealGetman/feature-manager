import 'package:feature_manager/feature_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  tearDown(FeatureManager.dispose);

  group('isEnabled', () {
    test('when feature is toggle should return value', () async {
      // given
      SharedPreferences.setMockInitialValues(<String, Object>{
        'key': true,
      });
      const feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.toggle,
      );

      // when
      final featureManager = await FeatureManager.getInstance();
      final value = featureManager.isEnabled(feature);

      // then
      expect(value, true);
    });

    test('when feature is toggle and value is null should return default value',
        () async {
      // given
      SharedPreferences.setMockInitialValues(<String, Object>{});
      const feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.toggle,
        defaultValue: true,
      );

      // when
      final featureManager = await FeatureManager.getInstance();
      final value = featureManager.isEnabled(feature);

      // then
      expect(value, true);
    });

    test(
        'when feature is toggle and value is null and default value is null should return false',
        () async {
      // given
      SharedPreferences.setMockInitialValues(<String, Object>{});
      const feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.toggle,
      );

      // when
      final featureManager = await FeatureManager.getInstance();
      final value = featureManager.isEnabled(feature);

      // then
      expect(value, false);
    });

    test('when feature is not toggle should return false', () async {
      // given
      SharedPreferences.setMockInitialValues(<String, Object>{});
      const feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.text,
      );

      // when
      final featureManager = await FeatureManager.getInstance();
      final value = featureManager.isEnabled(feature);

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
      const feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.text,
      );

      // when
      final featureManager = await FeatureManager.getInstance();
      final value = featureManager.getValue(feature) as String;

      // then
      expect(value, 'some text');
    });

    test('when stored value is null should return default value', () async {
      // given
      SharedPreferences.setMockInitialValues(<String, Object>{});
      const feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.text,
        defaultValue: 'default text',
      );

      // when
      final featureManager = await FeatureManager.getInstance();
      final value = featureManager.getValue(feature) as String;

      // then
      expect(value, 'default text');
    });
  });
}
