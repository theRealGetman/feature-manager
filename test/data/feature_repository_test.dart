import 'package:feature_manager/feature_manager.dart';
import 'package:feature_manager/src/data/feature_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late FeatureRepository _target;
  late SharedPreferences sharedPreferences;
  List<Feature> _preferencesList = [];

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    sharedPreferences = await SharedPreferences.getInstance();
    _target = FeatureRepository(
      featuresList: _preferencesList,
      sharedPreferences: sharedPreferences,
    );
  });

  group('putValue', () {
    test('when put value for toggle should store in shared preferences',
        () async {
      // given
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.toggle,
      );

      // when
      await _target.putValue(feature, true);

      // then
      final bool? storedValue = sharedPreferences.getBool('key');
      expect(storedValue, true);
    });

    test('when put value for double should store in shared preferences',
        () async {
      // given
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.doubleNumber,
      );

      // when
      await _target.putValue(feature, 1.1);

      // then
      final double? storedValue = sharedPreferences.getDouble('key');
      expect(storedValue, 1.1);
    });

    test('when put value for integer should store in shared preferences',
        () async {
      // given
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.integerNumber,
      );

      // when
      await _target.putValue(feature, 101);

      // then
      final int? storedValue = sharedPreferences.getInt('key');
      expect(storedValue, 101);
    });

    test('when put value for text should store in shared preferences',
        () async {
      // given
      final Feature feature = Feature(
        key: 'key',
        title: '',
        type: FeatureType.feature,
        valueType: FeatureValueType.text,
      );

      // when
      await _target.putValue(feature, 'some text');

      // then
      final String? storedValue = sharedPreferences.getString('key');
      expect(storedValue, 'some text');
    });
  });

  group('getFeatures', () {
    test('should return features with stored values', () async {
      // given
      SharedPreferences.setMockInitialValues(<String, Object>{
        'toggle_key': true,
        'text_key': 'some text',
        'double_key': 1.1,
        'integer_key': 101,
      });
      _preferencesList.addAll([
        Feature(
          key: 'toggle_key',
          title: '',
          type: FeatureType.feature,
          valueType: FeatureValueType.toggle,
        ),
        Feature(
          key: 'text_key',
          title: '',
          type: FeatureType.feature,
          valueType: FeatureValueType.text,
        ),
        Feature(
          key: 'double_key',
          title: '',
          type: FeatureType.feature,
          valueType: FeatureValueType.doubleNumber,
        ),
        Feature(
          key: 'integer_key',
          title: '',
          type: FeatureType.feature,
          valueType: FeatureValueType.integerNumber,
        ),
      ]);
      _target = FeatureRepository(
        featuresList: _preferencesList,
        sharedPreferences: sharedPreferences,
      );

      // when
      final List<Feature> features = await _target.getFeatures();

      // then
      expect(features[0].value, true);
      expect(features[1].value, 'some text');
      expect(features[2].value, 1.1);
      expect(features[3].value, 101);
    });
  });

  // group('getFeaturesStream', () {
  //   test('when getFeatures should yield features with stored values', () async {
  //     // given
  //     SharedPreferences.setMockInitialValues(<String, Object>{
  //       'toggle_key': true,
  //       'text_key': 'some text',
  //       'double_key': 1.1,
  //       'integer_key': 101,
  //     });
  //     _preferencesList.addAll([
  //       Feature(
  //         key: 'toggle_key',
  //         title: '',
  //         type: FeatureType.feature,
  //         valueType: FeatureValueType.toggle,
  //       ),
  //       Feature(
  //         key: 'text_key',
  //         title: '',
  //         type: FeatureType.feature,
  //         valueType: FeatureValueType.text,
  //       ),
  //       Feature(
  //         key: 'double_key',
  //         title: '',
  //         type: FeatureType.feature,
  //         valueType: FeatureValueType.doubleNumber,
  //       ),
  //       Feature(
  //         key: 'integer_key',
  //         title: '',
  //         type: FeatureType.feature,
  //         valueType: FeatureValueType.integerNumber,
  //       ),
  //     ]);
  //     _target = FeatureRepository(_preferencesList);
  //
  //     // then
  //     expect(
  //       _target.getFeaturesStream(),
  //       emits(
  //         equals(
  //           [
  //             Feature(
  //               key: 'toggle_key',
  //               title: '',
  //               type: FeatureType.feature,
  //               valueType: FeatureValueType.toggle,
  //               value: true,
  //             ),
  //             Feature(
  //               key: 'text_key',
  //               title: '',
  //               type: FeatureType.feature,
  //               valueType: FeatureValueType.text,
  //               value: 'some text',
  //             ),
  //             Feature(
  //               key: 'double_key',
  //               title: '',
  //               type: FeatureType.feature,
  //               valueType: FeatureValueType.doubleNumber,
  //               value: 1.1,
  //             ),
  //             Feature(
  //               key: 'integer_key',
  //               title: '',
  //               type: FeatureType.feature,
  //               valueType: FeatureValueType.integerNumber,
  //               value: 101,
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //     await _target.getFeatures();
  //   });
  //
  //   test('when putValue should yield features with stored values', () async {
  //     // given
  //     SharedPreferences.setMockInitialValues(<String, Object>{
  //       'toggle_key': true,
  //       'text_key': 'some text',
  //       'double_key': 1.1,
  //       'integer_key': 101,
  //     });
  //     final Feature feature = Feature(
  //       key: 'text_key',
  //       title: '',
  //       type: FeatureType.feature,
  //       valueType: FeatureValueType.text,
  //     );
  //     _preferencesList.addAll([
  //       Feature(
  //         key: 'toggle_key',
  //         title: '',
  //         type: FeatureType.feature,
  //         valueType: FeatureValueType.toggle,
  //       ),
  //       feature,
  //       Feature(
  //         key: 'double_key',
  //         title: '',
  //         type: FeatureType.feature,
  //         valueType: FeatureValueType.doubleNumber,
  //       ),
  //       Feature(
  //         key: 'integer_key',
  //         title: '',
  //         type: FeatureType.feature,
  //         valueType: FeatureValueType.integerNumber,
  //       ),
  //     ]);
  //     _target = FeatureRepository(_preferencesList);
  //
  //     // then
  //     expect(
  //       _target.getFeaturesStream(),
  //       emits(
  //         equals(
  //           [
  //             Feature(
  //               key: 'toggle_key',
  //               title: '',
  //               type: FeatureType.feature,
  //               valueType: FeatureValueType.toggle,
  //               value: true,
  //             ),
  //             Feature(
  //               key: 'text_key',
  //               title: '',
  //               type: FeatureType.feature,
  //               valueType: FeatureValueType.text,
  //               value: 'some text 2',
  //             ),
  //             Feature(
  //               key: 'double_key',
  //               title: '',
  //               type: FeatureType.feature,
  //               valueType: FeatureValueType.doubleNumber,
  //               value: 1.1,
  //             ),
  //             Feature(
  //               key: 'integer_key',
  //               title: '',
  //               type: FeatureType.feature,
  //               valueType: FeatureValueType.integerNumber,
  //               value: 101,
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //     await _target.putValue(feature, 'some text 2');
  //   });
  // });
}
