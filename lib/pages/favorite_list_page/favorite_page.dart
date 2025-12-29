import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/clear_favorite/clear_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/delete_favorite/delete_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/find_favorite/find_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/get_all_favorite/get_all_favorite_bloc.dart';

import 'package:test_3_35_7/pages/favorite_list_page/widget/favorite_view.dart';

class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({super.key});

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  bool _isSearchActive = false;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        //監聽讀取
        BlocListener<GetAllFavoriteBloc, GetAllFavoriteState>(
          listener: (context, state) {
            if (state.status == GetAllFavoriteStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? 'Failed to load favorites',
                  ),
                ),
              );
            }
          },
        ),
        //監聽刪除
        BlocListener<DeleteFavoriteBloc, DeleteFavoriteState>(
          listener: (context, state) {
            if (state is DeleteFavoriteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favorite deleted successfully!')),
              );

              if (_isSearchActive) {
                context.read<FindFavoriteBloc>().add(
                  FindFavoriteByName(_textController.text),
                );
              } else {
                context.read<GetAllFavoriteBloc>().add(DoGetAllFavoriteEvent());
              }
            } else if (state is DeleteFavoriteFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to delete favorite: ${state.message}'),
                ),
              );
            }
          },
        ),
        //監聽清除清單
        BlocListener<ClearFavoriteBloc, ClearFavoriteState>(
          listener: (context, state) {
            if (state is ClearFavoriteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All favorites cleared!')),
              );
              _textController.clear();
              setState(() {
                _isSearchActive = false;
              });
              context.read<GetAllFavoriteBloc>().add(DoGetAllFavoriteEvent());
            } else if (state is ClearFavoriteFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to clear favorites')),
              );
            }
          },
        ),
      ],
      child: FavoriteView(
        isSearchActive: _isSearchActive,
        textController: _textController,
        onSearchStatusChanged: (bool p1) {
          setState(() {
            _isSearchActive = p1;
          });
        },
      ),
    );
  }
}
