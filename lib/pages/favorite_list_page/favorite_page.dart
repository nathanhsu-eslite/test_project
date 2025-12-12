import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/clear_favorite/clear_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/delete_favorite/delete_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/find_favorite/find_favorite_bloc.dart';
import 'package:test_3_35_7/features/favorite/blocs/get_all_favorite/get_all_favorite_bloc.dart';
import 'package:domain/domain.dart';
import 'package:test_3_35_7/service/service_locator.dart';

import 'widget/favorite_list.dart';

class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllFavoriteBloc>(
          create: (context) =>
              GetAllFavoriteBloc(getFavoriteUC: getIt<GetAllFavoriteUseCase>())
                ..add(DoGetAllFavoriteEvent()),
        ),
        BlocProvider<FindFavoriteBloc>(
          create: (context) =>
              FindFavoriteBloc(findFavoriteUC: getIt<FindFavoriteUseCase>()),
        ),
        BlocProvider<DeleteFavoriteBloc>(
          create: (context) => DeleteFavoriteBloc(
            deleteFavoriteUC: getIt<DeleteFavoriteUseCase>(),
          ),
        ),
        BlocProvider<ClearFavoriteBloc>(
          create: (context) =>
              ClearFavoriteBloc(clearFavoriteUC: getIt<ClearFavoriteUseCase>()),
        ),
      ],
      child: const FavoriteView(),
    );
  }
}

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
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
      child: Scaffold(
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
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Search Favorite',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (value.isEmpty && _isSearchActive) {
                    setState(() {
                      _isSearchActive = false;
                    });
                  }
                },
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _isSearchActive = true;
                    });
                    context.read<FindFavoriteBloc>().add(
                      FindFavoriteByName(value),
                    );
                  } else {
                    setState(() {
                      _isSearchActive = false;
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: _isSearchActive
                  ? BlocBuilder<FindFavoriteBloc, FindFavoriteState>(
                      builder: (context, state) {
                        if (state is FindFavoriteDataState) {
                          if (state.status == FindFavoriteStatus.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state.status == FindFavoriteStatus.success) {
                            return FavoriteList(favorites: state.favorites);
                          }
                          if (state.status == FindFavoriteStatus.failure) {
                            return Center(
                              child: Text(
                                state.errorMessage ?? 'Search failed',
                              ),
                            );
                          }
                        }
                        return Container();
                      },
                    )
                  : BlocBuilder<GetAllFavoriteBloc, GetAllFavoriteState>(
                      builder: (context, state) {
                        if (state.status == GetAllFavoriteStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state.status == GetAllFavoriteStatus.success) {
                          return FavoriteList(favorites: state.favorites);
                        }
                        return const Center(
                          child: Text('Press the button to load favorites.'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
