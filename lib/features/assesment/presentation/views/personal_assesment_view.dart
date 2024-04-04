import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_assesment_form.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_progress_indicator.dart';
import 'package:kaloree/theme/colors.dart';
import 'package:kaloree/theme/fonts.dart';
import 'package:kaloree/theme/sizes.dart';
import 'package:kaloree/utils/platform/app_route.dart';
import 'package:kaloree/widgets/custom_form_field.dart';

class PersonalAssesmentView extends StatelessWidget {
  const PersonalAssesmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      resizeToAvoidBottomInset: false,
      appBar: buildCustomAppBar(title: 'Asesmen Diri', context: context),
      bottomNavigationBar: buildCustomBottomAppBar(
        text: 'Lihat Hasil',
        onTap: () {
          goAndRemoveUntilNamed(context, AppRoute.assesmentResult);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: margin_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            const CustomProgressIndicator(value: 3),
            const Gap(24),
            Text(
              'Asesmen Diri',
              style: interMedium.copyWith(fontSize: 24),
            ),
            const Gap(8),
            Text(
              'Lengkapi data diri kamu untuk mengetahui hasil asesmen kamu',
              style: interRegular.copyWith(fontSize: 14),
            ),
            const Gap(14),
            _buildFormCard(),
          ],
        ),
      ),
    );
  }

  Container _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
      decoration: BoxDecoration(
        boxShadow: customBoxShadow,
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomBodySizeForm(
                  hintText: 'Tinggi Badan',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  suffixText: 'cm',
                ),
              ),
              Gap(16),
              Expanded(
                  child: CustomBodySizeForm(
                hintText: 'Berat Badan',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                suffixText: 'kg',
              )),
            ],
          ),
          Gap(24),
          CustomFormField(
            hintText: 'Status Aktivitas Fisik',
            prefixIcon: Icons.directions_run_outlined,
            suffixIcon: Icon(Icons.keyboard_arrow_down),
          ),
          Gap(24),
          CustomFormField(
            hintText: 'Tujuan Kesehatan',
            prefixIcon: Icons.sports_gymnastics,
            suffixIcon: Icon(Icons.keyboard_arrow_down),
          ),
        ],
      ),
    );
  }
}
