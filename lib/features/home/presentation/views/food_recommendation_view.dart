// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';

class FoodRecommendationView extends StatelessWidget {
  final String result;
  const FoodRecommendationView({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
          title: 'Personalisasi Makanan Anda', context: context),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
              child: Markdown(
                data: result,
              ),
            ),
          )
        ],
      ),
    );
  }
}
