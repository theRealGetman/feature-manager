import 'package:feature_manager/src/bloc/features_cubit.dart';
import 'package:feature_manager/src/data/feature_repository.dart';
import 'package:feature_manager/src/domain/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'feature_item.dart';

class DeveloperPreferencesScreen extends StatelessWidget {
  const DeveloperPreferencesScreen({
    Key? key,
    required this.sharedPreferences,
    required this.featuresList,
  }) : super(key: key);

  final List<Feature> featuresList;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeaturesCubit>(
      create: (BuildContext context) => FeaturesCubit(
        FeatureRepository(
          featuresList: featuresList,
          sharedPreferences: sharedPreferences,
        ),
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
            return _Success(state.features);
          } else if (state is FeaturesLoading) {
            return const _Loading();
          } else if (state is FeaturesEmpty) {
            return const _Empty();
          } else if (state is FeaturesError) {
            return const _Error();
          }
          return Container();
        },
      ),
    );
  }
}

class _Success extends StatelessWidget {
  const _Success(this.preferences);

  final List<Feature> preferences;

  @override
  Widget build(BuildContext context) {
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
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Error while getting preferences',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'There are no preferences',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
