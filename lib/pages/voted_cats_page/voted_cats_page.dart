import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/votes/blocs/delete_vote/delete_votes_bloc.dart';
import 'package:test_3_35_7/features/votes/blocs/get_votes/get_votes_bloc.dart';
import 'package:test_3_35_7/pages/voted_cats_page/widget/voted_cat_card.dart';

class VotedCatsPage extends StatelessWidget {
  const VotedCatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voted Cats')),
      body: BlocListener<DeleteVotesBloc, DeleteVotesState>(
        listener: (context, state) {
          if (state is DeleteVotesSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(content: Text('Vote deleted!')));
            context.read<GetVotesBloc>().add(GetVotes());
          }
          if (state is DeleteVotesError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Failed to delete vote: ${state.exception}'),
                ),
              );
          }
        },
        child: BlocBuilder<GetVotesBloc, GetVotesDataState>(
          builder: (context, state) {
            switch (state.status) {
              case GetVotesStatus.loading:
              case GetVotesStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case GetVotesStatus.failure:
                return Center(
                  child: Text('Failed to load voted cats: ${state.error}'),
                );
              case GetVotesStatus.success:
                if (state.groupedVotes.isEmpty) {
                  return const Center(child: Text('No voted cats found.'));
                }

                final uniqueImageIds = state.groupedVotes.keys.toList();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: uniqueImageIds.length,
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    final imageId = uniqueImageIds[index];
                    final votesForImage = state.groupedVotes[imageId]!;
                    final firstVote = votesForImage.first;
                    final voteCount = votesForImage.length;

                    return VotedCatCard(
                      vote: firstVote,
                      voteCount: voteCount,
                      onDelete: () {
                        context.read<DeleteVotesBloc>().add(
                          DeleteVote(firstVote.imageId),
                        );
                      },
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
