part of 'features_cubit.dart';

abstract class FeaturesState {}

class FeaturesInitial extends FeaturesState {}

class FeaturesSuccess extends FeaturesState {
  FeaturesSuccess(this.features);

  final List<Feature> features;
}

class FeaturesLoading extends FeaturesState {}

class FeaturesEmpty extends FeaturesState {}

class FeaturesError extends FeaturesState {}
