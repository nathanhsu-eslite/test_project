import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/breeds_matcher/bloc/breeds_matcher_bloc.dart';
import 'package:test_3_35_7/pages/match_result_page/widget/match_result_list.dart';

class MatchResultPage extends StatelessWidget {
  const MatchResultPage({super.key});

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
                  return MatchResultList(
                    breedMatchResult: state.matchResult[index],
                  );
                },
                prototypeItem: MatchResultList(
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
