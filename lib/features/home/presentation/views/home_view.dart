import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/features/home/presentation/widgets/sport_card.dart';
import 'package:kaloree/theme/color_schemes.g.dart';
import 'package:kaloree/theme/fonts.dart';
import 'package:kaloree/theme/sizes.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightColorScheme.primaryContainer,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: getMaxHeight(context) * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: margin_20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + margin_12),
                  child: _buildUserAvatarName(),
                ),
                const Gap(24),
                Text(
                  'Ringkasan Harian',
                  style: interBold.copyWith(
                    fontSize: 15,
                    color: lightColorScheme.onPrimaryContainer,
                  ),
                ),
                const Gap(10),
                _buildDailySummary(),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rekomendasi Olahraga',
                      style: interBold.copyWith(fontSize: 15),
                    ),
                    Text(
                      'Lihat semua',
                      style: interMedium.copyWith(
                          fontSize: 14, color: lightColorScheme.onSurface),
                    ),
                  ],
                ),
                const Gap(12),
                const SportCard()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildUserAvatarName() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          child: FlutterLogo(),
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Satria!',
              style: interBold.copyWith(
                  fontSize: 16, color: lightColorScheme.primary),
            ),
            Text(
              'Hari ini, 4 April 2024',
              style: interMedium.copyWith(
                fontSize: 12,
                color: lightColorScheme.surfaceTint,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildDailySummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: lightColorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kalorimu Hari ini!',
                  style:
                      interSemiBold.copyWith(fontSize: 14, color: Colors.white),
                ),
                const Gap(18),
                Text(
                  'Kebutuhan Kalori',
                  style: interMedium.copyWith(
                    fontSize: 12,
                    color: const Color(0xffE2E3DF),
                  ),
                ),
                const Gap(2),
                Text(
                  '2280 kkal',
                  style: interBold.copyWith(fontSize: 14, color: Colors.white),
                ),
                const Gap(18),
                Text(
                  'Kalori Terpenuhi',
                  style: interMedium.copyWith(
                    fontSize: 12,
                    color: const Color(0xffE2E3DF),
                  ),
                ),
                const Gap(2),
                Text(
                  '1800 kkal',
                  style: interBold.copyWith(fontSize: 14, color: Colors.white),
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 180,
              child: _buildGauge(),
            ),
          )
        ],
      ),
    );
  }

  SfRadialGauge _buildGauge() {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 1800,
          showTicks: false,
          showLabels: false,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.2,
            cornerStyle: CornerStyle.bothCurve,
            color: Color(0xffE2E3DF),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 600,
              color: const Color(0xffFFAE12),
              label: 'Halo',
              labelStyle: const GaugeTextStyle(
                color: Colors.transparent,
              ),
            ),
          ],
          pointers: const <GaugePointer>[
            MarkerPointer(
              value: 600,
              markerHeight: 25,
              markerWidth: 25,
              color: Color(0xffFFAE12),
              markerType: MarkerType.circle,
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '60%',
                    style:
                        interBold.copyWith(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    'Kalori masuk',
                    style:
                        interMedium.copyWith(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
