import 'package:cats_repository/cats_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/breeds_matcher/bloc/breeds_matcher_bloc.dart';
import 'package:test_3_35_7/service/service_locator.dart';

class MatchResultPage extends StatelessWidget {
  const MatchResultPage({super.key, required this.userPreference});
  final UserPreference userPreference;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BreedsMatcherBloc(getMatchResultUC: getIt<GetMatchResultUC>())
            ..add(BreedsMatcherStarted(userPreference: userPreference)),
      child: const MatchResultView(),
    );
  }
}

class MatchResultView extends StatelessWidget {
  const MatchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Result')),
      body: BlocBuilder<BreedsMatcherBloc, BreedsMatcherState>(
        builder: (context, state) {
          switch (state) {
            case BreedsMatcherInitial():
            case BreedsMatcherLoadInProgress():
              return const Center(child: CircularProgressIndicator());

            case BreedsMatcherLoadSuccess():
              return ListView.builder(
                itemCount: state.matchResult.length,
                itemBuilder: (context, index) {
                  final match = state.matchResult[index];
                  final image = match.catModel;
                  final breeds = image.breeds;

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            image.url,
                            height: 200,
                            fit: BoxFit.contain,
                            cacheHeight: image.urlHeight,
                            cacheWidth: image.urlWidth,
                          ),
                          ListTile(
                            title: Text(breeds!.first.name),
                            subtitle: Text(
                              'Score: ${match.score.toStringAsFixed(2)}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            case BreedsMatcherLoadFailure():
              return Center(
                child: Text('Failed to load match result: ${state.message}'),
              );
          }
        },
      ),
    );
  }
}
