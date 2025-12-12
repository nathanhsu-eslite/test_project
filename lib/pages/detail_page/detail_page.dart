import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3_35_7/features/get_cat_detail/bloc/get_cat_bloc.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';
import 'package:test_3_35_7/page/error_page.dart';
import 'package:test_3_35_7/pages/detail_page/widget/detail_widget.dart';
import 'package:test_3_35_7/service/service_locator.dart';

class CatDetailPage extends StatelessWidget {
  const CatDetailPage({super.key, required this.image});
  final MyImage image;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetCatBloc(getCatsDetailUseCase: getIt<GetCatDetailUC>())
            ..add(GetCatQueried(image.id)),

      child: CatDetailView(image: image),
    );
  }
}

class CatDetailView extends StatelessWidget {
  const CatDetailView({super.key, required this.image});
  final MyImage image;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCatBloc, GetCatDetailState>(
      builder: (context, state) {
        switch (state) {
          case GetCatDetailInitialState():
          case GetCatDetailLoadingState():
            return const Center(child: CircularProgressIndicator());
          case CatGetDetailFailureState():
            return ErrorPage(error: state.error);
          case CatGetDetailSuccessState():
            final cat = state.detail;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(cat.breedName),
                centerTitle: true,
              ),
              body: DetailWidget(image: image, cat: cat),
            );
        }
      },
    );
  }
}
