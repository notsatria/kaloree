import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_error_view.dart';
import 'package:kaloree/features/profile/presentation/bloc/get_recommendation_bloc.dart';
import 'package:kaloree/features/profile/presentation/widgets/recommendation_list_tile.dart';

class SportRecommendationListView extends StatefulWidget {
  const SportRecommendationListView({super.key});

  @override
  State<SportRecommendationListView> createState() =>
      _SportRecommendationListViewState();
}

class _SportRecommendationListViewState
    extends State<SportRecommendationListView> {
  @override
  void initState() {
    context
        .read<GetRecommendationBloc>()
        .add(const GetRecommendationList(isSportRecommendation: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRecommendationBloc, GetRecommendationState>(
      builder: (context, state) {
        if (state is GetRecommendationSuccess) {
          final recommendationList = state.recommendationList;
          if (recommendationList.isEmpty) {
            return _buildErrorStateView(
                context, 'Belum ada rekomendasi olahraga');
          }
          return Scaffold(
            appBar: buildCustomAppBar(
                title: 'List Rekomendasi Olahraga Anda', context: context),
            body: ListView.separated(
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
              itemCount: recommendationList.length,
              itemBuilder: (context, index) {
                final recommendation = recommendationList[index];
                return RecommendationListTile(recommendation: recommendation);
              },
            ),
          );
        } else if (state is GetRecommendationFailure) {
          return _buildErrorStateView(context, state.message);
        } else {
          return _buildErrorStateView(context, 'Terjadi Kesalahan');
        }
      },
    );
  }

  Scaffold _buildErrorStateView(BuildContext context, String message) =>
      Scaffold(
        appBar: buildCustomAppBar(
            title: 'List Rekomendasi Olahraga Anda', context: context),
        body: ErrorView(message: message),
      );
}
