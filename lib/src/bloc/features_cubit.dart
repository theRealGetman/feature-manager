import 'dart:async';

import 'package:feature_manager/src/bloc/cubit.dart';
import 'package:feature_manager/src/data/feature_repository.dart';
import 'package:feature_manager/src/domain/models/feature.dart';
import 'package:flutter/foundation.dart';

part 'features_state.dart';

class FeaturesCubit extends Cubit<FeaturesState> {
  FeaturesCubit(this.repository) : super(FeaturesInitial());

  final FeatureRepository repository;
  StreamSubscription<List<Feature>>? _featuresSubscription;

  Future<void> getFeatures() async {
    try {
      emit(FeaturesLoading());

      final features = await repository.getFeatures();

      if (features.isNotEmpty) {
        emit(FeaturesSuccess(features));
      } else {
        emit(FeaturesEmpty());
      }

      _listenFeatures();
    } catch (e) {
      if (kDebugMode) {
        print('FeatureManager error >> $e');
      }
      emit(FeaturesError());
    }
  }

  Future<void> changeFeature(
    Feature feature,
    Object? value,
  ) async {
    try {
      await repository.putValue(feature, value);
    } catch (e) {
      if (kDebugMode) {
        print('FeatureManager error >> $e');
      }
      emit(FeaturesError());
    }
  }

  void _listenFeatures() {
    _featuresSubscription ??= repository.getFeaturesStream().distinct().listen(
      (features) {
        if (features.isNotEmpty) {
          emit(FeaturesSuccess(features));
        } else {
          emit(FeaturesEmpty());
        }
      },
      onError: (dynamic e) {
        if (kDebugMode) {
          print('FeatureManager error >> $e');
        }
        emit(FeaturesError());
      },
    );
  }

  @override
  Future<void> close() {
    _featuresSubscription?.cancel();
    _featuresSubscription = null;
    return super.close();
  }
}
