import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/clear_favorite/clear_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/find_favorite/find_favorite_bloc.dart';
import 'package:test_3_35_7/pages/favorite_list_page/widget/favorite_page_state.dart';

class FavoriteView extends StatelessWidget {
  final bool isSearchActive;
  final TextEditingController textController;
  final Function(bool)? onSearchStatusChanged;

  @override
  const FavoriteView({
    super.key,
    required this.isSearchActive,
    required this.textController,
    required this.onSearchStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              context.read<ClearFavoriteBloc>().add(DoClearFavoriteEvent());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Search Favorite',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value.isEmpty && isSearchActive) {
                  onSearchStatusChanged?.call(false);
                }
              },
              onSubmitted: (value) {
                if (value.isEmpty) return;

                onSearchStatusChanged?.call(true);
                context.read<FindFavoriteBloc>().add(FindFavoriteByName(value));
              },
            ),
          ),
          FavoriteViewState(isSearchActive: isSearchActive),
        ],
      ),
    );
  }
}
