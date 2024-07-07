
import 'package:flutter/material.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/features/home/data/model/recommendation.dart';

class RecommendationListTile extends StatelessWidget {
  const RecommendationListTile({
    super.key,
    required this.recommendation,
  });

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      splashColor: Colors.blueGrey,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
      title: Text(recommendation.id, style: interSemiBold),
      subtitle: Text(
        recommendation.result,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
