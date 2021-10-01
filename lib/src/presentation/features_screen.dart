import 'package:feature_manager/src/bloc/features_cubit.dart';
import 'package:feature_manager/src/data/feature_repository.dart';
import 'package:feature_manager/src/domain/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feature_item.dart';

class DeveloperPreferencesScreen extends StatelessWidget {
  const DeveloperPreferencesScreen(
    this.featuresList, {
    Key? key,
  }) : super(key: key);

  final List<Feature> featuresList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeaturesCubit>(
      create: (BuildContext context) => FeaturesCubit(
        FeatureRepository(featuresList),
      )..getFeatures(),
      child: _DeveloperPreferencesWidget(),
    );
  }
}

class _DeveloperPreferencesWidget extends StatelessWidget {
  const _DeveloperPreferencesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Preferences'),
      ),
      body: BlocBuilder<FeaturesCubit, FeaturesState>(
        builder: (BuildContext context, FeaturesState state) {
          if (state is FeaturesSuccess) {
            return _success(context, state.features);
          } else if (state is FeaturesLoading) {
            return _loading(context);
          } else if (state is FeaturesEmpty) {
            return _empty(context);
          } else if (state is FeaturesError) {
            return _error(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget _success(BuildContext context, List<Feature> preferences) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final Feature preference = preferences[index];
        return _FeatureItem(
          preference,
          onChanged: (Object? newValue) {
            context.read<FeaturesCubit>().changeFeature(preference, newValue);
          },
        );
      },
      itemCount: preferences.length,
    );
  }

  Widget _loading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(BuildContext context) {
    return Center(
      child: Text(
        'Error while getting preferences',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return Center(
      child: Text(
        'There are no preferences',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
