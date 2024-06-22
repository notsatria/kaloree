import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_error_view.dart';
import 'package:kaloree/features/home/presentation/bloc/daily_calories_bloc.dart';
import 'package:kaloree/features/home/presentation/bloc/user_home_bloc.dart';
import 'package:kaloree/features/home/presentation/widgets/food_card.dart';
import 'package:kaloree/features/home/presentation/widgets/sport_card.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final today = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    context.read<UserHomeBloc>().add(GetUserData());
    context.read<DailyCaloriesBloc>().add(GetDailyCaloriesSupplied());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserHomeBloc, UserHomeState>(
      builder: (context, state) {
        if (state is GetUserDataSuccess) {
          final user = state.user;
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
                            top:
                                MediaQuery.of(context).padding.top + margin_12),
                        child: _buildUserAvatarName(
                          name: user.fullName.toString(),
                          photoUrl: user.profilePicture.toString(),
                        ),
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
                      BlocBuilder<DailyCaloriesBloc, DailyCaloriesState>(
                        builder: (context, state) {
                          log('State: $state');
                          if (state is GetDailyCaloriesSuppliedSuccess) {
                            return _buildDailySummary(
                              dailyCaloriesNeeded: user.healthProfile?.bmr ?? 0,
                              dailyCaloriesSupplied:
                                  state.dailyCaloriesSupplied,
                            );
                          } else {
                            return _buildDailySummary(
                              dailyCaloriesNeeded: user.healthProfile?.bmr ?? 0,
                              dailyCaloriesSupplied: 0,
                            );
                          }
                        },
                      ),
                      const Gap(12),
                      _buildSubtitleText(text: 'Rekomendasi Olahraga'),
                      const Gap(12),
                      const SportCard(),
                      const Gap(24),
                      _buildSubtitleText(text: 'Rekomendasi Makanan'),
                      const Gap(12),
                      const FoodCard(),
                      const Gap(50)
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is GetUserDataFailure) {
          return Scaffold(
            body: ErrorView(message: state.message),
          );
        } else if (state is GetUserDataLoading) {
          return const Scaffold(
            body: Loading(),
          );
        } else {
          return const ErrorView(message: 'Terjadi Kesalahan');
        }
      },
    );
  }

  Row _buildSubtitleText({required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: interBold.copyWith(fontSize: 15),
        ),
        Text(
          'Lihat semua',
          style: interMedium.copyWith(
              fontSize: 14, color: lightColorScheme.onSurface),
        ),
      ],
    );
  }

  Row _buildUserAvatarName({required String name, required String photoUrl}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          child: Image.network(photoUrl, fit: BoxFit.cover),
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, $name!',
              style: interBold.copyWith(
                  fontSize: 16, color: lightColorScheme.primary),
            ),
            Text(
              today,
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

  _buildDailySummary({
    required double dailyCaloriesNeeded,
    required double dailyCaloriesSupplied,
  }) {
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
                  '${dailyCaloriesNeeded.toStringAsFixed(0)} kal',
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
                  '${dailyCaloriesSupplied.toStringAsFixed(0)} kal',
                  style: interBold.copyWith(fontSize: 14, color: Colors.white),
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 180,
              child: _buildGauge(
                dailyCaloriesNeeded: dailyCaloriesNeeded,
                dailyCaloriesSupplied: dailyCaloriesSupplied,
              ),
            ),
          )
        ],
      ),
    );
  }

  SfRadialGauge _buildGauge(
      {required double dailyCaloriesNeeded,
      required double dailyCaloriesSupplied}) {
    String caloriesSuppliedPercent =
        (dailyCaloriesSupplied / dailyCaloriesNeeded * 100).toStringAsFixed(0);
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: dailyCaloriesNeeded,
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
              endValue: dailyCaloriesSupplied,
              color: const Color(0xffFFAE12),
              label: 'Halo',
              labelStyle: const GaugeTextStyle(
                color: Colors.transparent,
              ),
            ),
          ],
          pointers: <GaugePointer>[
            MarkerPointer(
              value: dailyCaloriesSupplied,
              markerHeight: 25,
              markerWidth: 25,
              color: const Color(0xffFFAE12),
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
                    '$caloriesSuppliedPercent%',
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
