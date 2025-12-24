import 'package:cats_repository/cats_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/votes/blocs/delete_vote/delete_votes_bloc.dart';

class VotedCatCard extends StatelessWidget {
  const VotedCatCard({
    super.key,
    required this.vote,
    required this.voteCount,
    required this.onDelete,
  });

  final VotesDataEntity vote;
  final int voteCount;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (vote.url != null)
            Image.network(
              vote.url!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            )
          else
            const Icon(Icons.error),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Chip(
              label: Text('$voteCount Votes'),
              backgroundColor: Colors.black.withAlpha((0.6 * 255).round()),
              labelStyle: const TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withAlpha((0.5 * 255).round()),
              child: BlocBuilder<DeleteVotesBloc, DeleteVotesState>(
                builder: (context, state) {
                  if (state is DeleteVotesLoading) {
                    // It would be better to check if *this* specific card is being deleted
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: onDelete,
                    tooltip: 'Delete All Votes',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
