import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/features/assesment/presentation/views/personal_assesment_view.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_gender_chip.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_progress_indicator.dart';
import 'package:kaloree/theme/fonts.dart';
import 'package:kaloree/theme/sizes.dart';
import 'package:kaloree/utils/platform/app_route.dart';

class GenderInformationView extends StatelessWidget {
  const GenderInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      appBar: buildCustomAppBar(title: 'Jenis Kelamin', context: context),
      bottomNavigationBar: buildCustomBottomAppBar(
        text: 'Berikutnya',
        onTap: () {
          goToAnimated(context, const PersonalAssesmentView());
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: margin_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            const CustomProgressIndicator(value: 2),
            const Gap(24),
            Text(
              'Jenis Kelamin',
              style: interMedium.copyWith(fontSize: 24),
            ),
            const Gap(8),
            Text(
              'Lengkapi data diri kamu untuk mengetahui hasil asesmen kamu',
              style: interRegular.copyWith(fontSize: 14),
            ),
            const Gap(14),
            const Align(
              alignment: Alignment.center,
              child: CustomGenderChip(
                genderType: GenderType.male,
                isSelected: true,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: CustomGenderChip(
                genderType: GenderType.female,
                isSelected: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}