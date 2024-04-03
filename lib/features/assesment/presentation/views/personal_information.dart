import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/theme/color_schemes.g.dart';
import 'package:kaloree/theme/colors.dart';
import 'package:kaloree/theme/fonts.dart';
import 'package:kaloree/theme/sizes.dart';
import 'package:kaloree/widgets/custom_button.dart';
import 'package:kaloree/widgets/custom_form_field.dart';

class PersonalInformationView extends StatelessWidget {
  const PersonalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      appBar: buildCustomAppBar(title: 'Data Diri', context: context),
      bottomNavigationBar: _buildBottomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: margin_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 1 / 3,
                    backgroundColor: lightColorScheme.primaryContainer,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        lightColorScheme.surfaceTint),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const Gap(8),
                Text(
                  '1 dari 3',
                  style: interMedium.copyWith(fontSize: 12),
                ),
              ],
            ),
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

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      color: const Color(0xffEAEAEA),
      elevation: 0,
      child: CustomFilledButton(
          text: 'Berikutnya',
          onTap: () {
            log('check');
          },
          backgroundColor: onBoardingBackgroundColor,
          textColor: Colors.white),
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
