import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_progress_indicator.dart';
import 'package:kaloree/theme/colors.dart';
import 'package:kaloree/theme/fonts.dart';
import 'package:kaloree/theme/sizes.dart';
import 'package:kaloree/utils/platform/app_route.dart';
import 'package:kaloree/widgets/custom_form_field.dart';

class PersonalInformationView extends StatelessWidget {
  const PersonalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      appBar: buildCustomAppBar(title: 'Data Diri', context: context),
      bottomNavigationBar: buildCustomBottomAppBar(
        text: 'Berikutnya',
        onTap: () {
          goToNamed(context, AppRoute.genderInformation);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: margin_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            const CustomProgressIndicator(value: 1),
            const Gap(24),
            Text(
              'Isi data diri kamu',
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
          CustomFormField(
            hintText: 'Nama Lengkap',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefixIcon: Icons.person_outline,
          ),
          Gap(24),
          CustomFormField(
            hintText: 'Tanggal Lahir',
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.done,
            prefixIcon: Icons.date_range_outlined,
          ),
        ],
      ),
    );
  }
}
