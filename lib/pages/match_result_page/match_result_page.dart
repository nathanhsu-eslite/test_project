import 'package:cats_repository/cats_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_3_35_7/features/breeds_matcher/bloc/breeds_matcher_bloc.dart';
import 'package:test_3_35_7/pages/match_result_page/match_result_widget.dart';

class MatchResultPage extends StatelessWidget {
  const MatchResultPage({super.key, required this.userPreference});
  final UserPreference userPreference;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BreedsMatcherBloc(getMatchResultUC: GetIt.I.get<GetMatchResultUC>())
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
                  return MatchResultWidget(
                    breedMatchResult: state.matchResult[index],
                  );
                },
                prototypeItem: MatchResultWidget(
                  breedMatchResult: state.matchResult[0],
                ),
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
