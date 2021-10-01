import 'package:bloc_test/bloc_test.dart';
import 'package:feature_manager/feature_manager.dart';
import 'package:feature_manager/src/bloc/features_cubit.dart';
import 'package:feature_manager/src/data/feature_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'feature_cubit_test.mocks.dart';

@GenerateMocks([FeatureRepository, Feature])
void main() {
  final FeatureRepository _repository = MockFeatureRepository();
  final Feature _feature = MockFeature();

  group('getFeatures', () {
    blocTest(
      'FeaturesCubit emits FeaturesSuccess when feature list is not empty',
      build: () {
        // given
        when(_repository.getFeaturesStream())
            .thenAnswer((_) => Stream.value([_feature]));

        return FeaturesCubit(_repository);
      },
      act: (FeaturesCubit cubit) => cubit.getFeatures(),
      expect: () => [
        isInstanceOf<FeaturesLoading>(),
        isInstanceOf<FeaturesSuccess>(),
      ],
    );

    blocTest(
      'FeaturesCubit emits FeaturesEmpty when feature list is empty',
      build: () {
        // given
        when(_repository.getFeaturesStream())
            .thenAnswer((_) => Stream.value([]));

        return FeaturesCubit(_repository);
      },
      act: (FeaturesCubit cubit) => cubit.getFeatures(),
      expect: () => [
        isInstanceOf<FeaturesLoading>(),
        isInstanceOf<FeaturesEmpty>(),
      ],
    );

    blocTest(
      'FeaturesCubit emits FeaturesError when stream error',
      build: () {
        // given
        when(_repository.getFeaturesStream()).thenThrow(Error());

        return FeaturesCubit(_repository);
      },
      act: (FeaturesCubit cubit) => cubit.getFeatures(),
      expect: () => [
        isInstanceOf<FeaturesLoading>(),
        isInstanceOf<FeaturesError>(),
      ],
    );
  });

  group('changeFeature', () {
    blocTest(
      'FeaturesCubit invokes putValue for provided feature',
      build: () {
        // given
        when(_repository.putValue(_feature, any)).thenAnswer((_) async => {});

        return FeaturesCubit(_repository);
      },
      act: (FeaturesCubit cubit) => cubit.changeFeature(_feature, true),
      verify: (_) {
        verify(_repository.putValue(_feature, true)).called(1);
      },
    );

    blocTest(
      'FeaturesCubit emits FeaturesError when putValue throws error',
      build: () {
        // given
        when(_repository.putValue(_feature, any)).thenThrow(Error());

        return FeaturesCubit(_repository);
      },
      act: (FeaturesCubit cubit) => cubit.changeFeature(_feature, true),
      verify: (_) {
        verify(_repository.putValue(_feature, true)).called(1);
      },
      expect: () => [
        isInstanceOf<FeaturesError>(),
      ],
    );
  });
}
