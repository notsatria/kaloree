import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/theme/color_schemes.g.dart';
import 'package:kaloree/theme/colors.dart';
import 'package:kaloree/theme/fonts.dart';
import 'package:kaloree/theme/sizes.dart';
import 'package:kaloree/utils/platform/app_route.dart';
import 'package:kaloree/utils/platform/assets.dart';
import 'package:kaloree/widgets/dialog.dart';

class AssesmentResultView extends StatelessWidget {
  const AssesmentResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        showBackDialog(context);
      },
      child: Scaffold(
        backgroundColor: onBoardingBackgroundColor,
        appBar: buildCustomAppBar(
          title: 'Asesmen Diri',
          context: context,
          canPop: false,
          backgroundColor: onBoardingBackgroundColor,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: getMaxHeight(context) * 0.45,
                padding: const EdgeInsets.symmetric(horizontal: margin_20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: _buildClassificationActivitiesResult(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: buildCustomBottomAppBar(
                text: 'Kembali ke Beranda',
                color: Colors.white,
                onTap: () {
                  goAndRemoveUntilNamed(context, AppRoute.main);
                },
              ),
            ),
            Positioned(
              bottom: getMaxHeight(context) * 0.43,
              left: 20,
              right: 20,
              child: Container(
                width: getMaxHeight(context),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: lightColorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: customBoxShadow,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Kebutuhan Kalori Harian',
                        style: interMedium.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '2200kkal',
                        style: interBold.copyWith(
                          fontSize: 14,
                          color: const Color(0xffFFAE12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: margin_20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hai, \nDamar Satria',
                    style: interBold.copyWith(
                        fontSize: 28, color: lightColorScheme.primary),
                  ),
                  const Gap(8),
                  Text(
                    'Terima kasih sudah mengisi asesmen diri kamu, berikut ini hasilnya',
                    style: interRegular.copyWith(
                        fontSize: 14, color: lightColorScheme.primary),
                  ),
                  const Gap(20),
                  _buildResultScoreCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildClassificationActivitiesResult() {
    return Column(
      children: [
        const Gap(40),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildClassificationResult(
                    icon: Icons.directions_run,
                    title: 'Status Aktifitas Fisik',
                    value: 'Kerja Ringan-Sedang',
                  ),
                  const Gap(15),
                  _buildClassificationResult(
                    image: iconHeartPlus,
                    title: 'Klasifikasi Status Gizi',
                    value: 'Normal',
                  ),
                ],
              ),
            ),
            const Gap(15),
            Expanded(
              child: Column(
                children: [
                  _buildClassificationResult(
                    icon: Icons.sports_gymnastics,
                    title: 'Tujuan Kesehatan',
                    value: 'Berat Badan Turun',
                  ),
                  const Gap(15),
                  InkWell(
                    onTap: () {},
                    child: _buildClassificationResult(
                      image: iconMathFormula,
                      title: 'Tekan untuk pelajari',
                      value: 'Rumus yang digunakan',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _buildClassificationResult({
    IconData? icon,
    String? image,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffE7E7E7).withOpacity(0.55),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (icon != null)
              ? Icon(
                  icon,
                  color: lightColorScheme.outline,
                  size: 40,
                )
              : Image.asset(
                  image!,
                  width: 40,
                  height: 40,
                ),
          const Gap(18),
          Text(
            title,
            style: interBold.copyWith(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: interMedium.copyWith(
              fontSize: 12,
              color: Colors.black.withOpacity(0.55),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildResultScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(margin_20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.73),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomText(title: 'Tinggi Badan', value: '172 cm'),
                const Gap(12),
                _buildCustomText(title: 'Usia', value: '20 Tahun'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomText(title: 'Berat Badan', value: '72 kg'),
                const Gap(12),
                _buildCustomText(title: 'Index BMI', value: '24.1'),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              iconHealthSquare,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildCustomText({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: interMedium.copyWith(
            fontSize: 14,
            color: Colors.black.withOpacity(0.55),
          ),
        ),
        Text(
          value,
          style: interBold.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
