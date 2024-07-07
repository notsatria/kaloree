// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/utils/date_format.dart';
import 'package:kaloree/features/home/data/model/recommendation.dart';

class RecommendationListTile extends StatelessWidget {
  final void Function()? onTap;
  final int index;
  final Recommendation recommendation;

  const RecommendationListTile({
    Key? key,
    this.onTap,
    required this.index,
    required this.recommendation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = formatDateTo(
        date: DateTime.parse(recommendation.createdAt), format: 'd MMMM y');
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
      title: Row(
        children: [
          Text('Rekomendasi $index', style: interSemiBold),
          const Gap(8),
          Text('($date)', style: interRegular.copyWith(fontSize: 14)),
        ],
      ),
      subtitle: Text(
        recommendation.result,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
