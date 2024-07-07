// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/utils/show_snackbar.dart';
import 'package:kaloree/core/widgets/dialog.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/home/presentation/bloc/save_recommendation_bloc.dart';

class FoodRecommendationView extends StatelessWidget {
  final String result;
  const FoodRecommendationView({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveRecommendationBloc, SaveRecommendationState>(
      listener: (context, state) {
        if (state is SaveRecommendationLoading) {
          showLoadingDialog(context);
        }

        if (state is SaveRecommendationSuccess) {
          pop(context);
          pop(context);
          showSnackbar(context, state.message);
        }

        if (state is SaveRecommendationFailure) {
          showSnackbar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: buildCustomAppBar(
            title: 'Personalisasi Makanan Anda', context: context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showConfirmationDialog(context, onYesPressed: () {
              context.read<SaveRecommendationBloc>().add(
                    SaveRecommendation(
                        isSportRecommendation: false, result: result),
                  );
            });
          },
          label: const Text('Simpan'),
          icon: const Icon(Icons.save),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20)
                    .copyWith(top: 20),
                child: Markdown(
                  data: result,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context,
      {required void Function()? onYesPressed}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Simpan Rekomendasi'),
            content: const Text(
                'Apakah kamu yakin ingin menyimpan hasil rekomendasi?'),
            actions: [
              TextButton(
                  onPressed: () {
                    pop(context);
                  },
                  child: const Text('Tidak')),
              TextButton(onPressed: onYesPressed, child: const Text('Yakin')),
            ],
          );
        });
  }
}
