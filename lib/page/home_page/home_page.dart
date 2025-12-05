// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:public_api/public_api.dart';

// import 'package:test_3_35_7/page/error_page.dart';
// import 'package:test_3_35_7/page/home_page/bloc/home_bloc.dart';
// import 'package:test_3_35_7/page/home_page/widget/cats_list.dart';
// import 'package:test_3_35_7/service/service_locator.dart';

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           HomeBloc(catApi: getIt<CatApiClient>())..add(const HomeCatsFetched()),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: Text(title),
//         ),
//         body: const HomeView(),
//       ),
//     );
//   }
// }

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         if (state.status == HomeStatus.failure) {
//           return ErrorPage(error: state.error);
//         }

//         if (state.cats.isEmpty) {
//           if (state.status == HomeStatus.loading ||
//               state.status == HomeStatus.initial) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state.status == HomeStatus.success) {
//             return const Center(child: Text('no cats'));
//           }
//         }
//         return Center(child: Text(''));
//         // return RefreshIndicator(
//         //   onRefresh: () async {
//         //     context.read<HomeBloc>().add(const HomeCatsRefreshed());
//         //   },
//         //   // child: CatsList(
//         //   //   cats: state.cats,
//         //   //   controller: _scrollController,
//         //   //   hasReachedMax: state.hasReachedMax,
//         //   // ),
//         // );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController
//       ..removeListener(_onScroll)
//       ..dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (_isBottom) context.read<HomeBloc>().add(const HomeCatsFetched());
//   }

//   bool get _isBottom {
//     if (!_scrollController.hasClients) return false;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.offset;
//     return currentScroll >= (maxScroll * 0.9);
//   }
// }
