import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/utils/date_format.dart';
import 'package:kaloree/core/widgets/dialog.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/assesment/presentation/views/personal_assesment_view.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_error_view.dart';
import 'package:kaloree/features/home/presentation/bloc/daily_calories_bloc.dart';
import 'package:kaloree/features/home/presentation/bloc/user_home_bloc.dart';
import 'package:kaloree/features/home/presentation/views/food_recommendation_view.dart';
import 'package:kaloree/features/home/presentation/views/sport_recommendation_view.dart';
import 'package:kaloree/features/home/presentation/widgets/food_card.dart';
import 'package:kaloree/features/home/presentation/widgets/sport_card.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final today = formatDateTo(date: DateTime.now(), format: 'EEEE, d MMMM yyyy');
  final gemini = Gemini.instance;
  double dailyCalSupplied = 0;

  @override
  void initState() {
    super.initState();
    context.read<UserHomeBloc>().add(GetUserData());
    context.read<DailyCaloriesBloc>().add(GetDailyCaloriesSupplied());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserHomeBloc, UserHomeState>(
          listener: (context, state) {
            if (state is GetUserDataSuccess) {
              context.read<DailyCaloriesBloc>().add(GetDailyCaloriesSupplied());
            }
          },
        ),
      ],
      child: BlocBuilder<UserHomeBloc, UserHomeState>(
        builder: (context, userState) {
          if (userState is GetUserDataSuccess) {
            final user = userState.user;
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
                              top: MediaQuery.of(context).padding.top +
                                  margin_12),
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
                          builder: (context, dailyCaloriesState) {
                            log('State: $dailyCaloriesState');
                            if (dailyCaloriesState
                                is GetDailyCaloriesSuppliedSuccess) {
                              dailyCalSupplied =
                                  dailyCaloriesState.dailyCaloriesSupplied;
                              log('Daily Calories Supplied on Home: ${dailyCaloriesState.dailyCaloriesSupplied}');
                              return _buildDailySummary(
                                dailyCaloriesNeeded:
                                    user.healthProfile?.bmr ?? 0,
                                dailyCaloriesSupplied:
                                    dailyCaloriesState.dailyCaloriesSupplied,
                              );
                            } else {
                              return _buildDailySummary(
                                dailyCaloriesNeeded:
                                    user.healthProfile?.bmr ?? 0,
                                dailyCaloriesSupplied: 0,
                              );
                            }
                          },
                        ),
                        const Gap(24),
                        SportCard(
                          onTap: () {
                            _showConfirmationDialog(context,
                                isSportRecommendation: true, onYesPressed: () {
                              pop(context);
                              showLoadingDialog(context);
                              final healthProfile = user.healthProfile;
                              final gender = (healthProfile!.gender == 0)
                                  ? 'laki-laki'
                                  : 'perempuan';

                              ActivityStatus? activityStatusResult;
                              HealthPurpose? healthPurposeResult;
                              switch (healthProfile.activityStatus) {
                                case 0:
                                  activityStatusResult =
                                      ActivityStatus.sangatJarang;
                                  break;
                                case 1:
                                  activityStatusResult = ActivityStatus.jarang;
                                  break;
                                case 2:
                                  activityStatusResult = ActivityStatus.normal;
                                  break;
                                case 3:
                                  activityStatusResult = ActivityStatus.sering;
                                  break;
                                case 4:
                                  activityStatusResult =
                                      ActivityStatus.sangatSering;
                                  break;
                                default:
                                  activityStatusResult = ActivityStatus.normal;
                                  break;
                              }

                              switch (healthProfile.healthPurpose) {
                                case 0:
                                  healthPurposeResult =
                                      HealthPurpose.turunBBEkstrim;
                                  break;
                                case 1:
                                  healthPurposeResult = HealthPurpose.turunBB;
                                  break;
                                case 2:
                                  healthPurposeResult =
                                      HealthPurpose.pertahankan;
                                  break;
                                case 3:
                                  healthPurposeResult =
                                      HealthPurpose.menaikkanBB;
                                  break;
                                case 4:
                                  healthPurposeResult =
                                      HealthPurpose.menaikkanBBEkstrim;
                                  break;
                                default:
                                  healthPurposeResult =
                                      HealthPurpose.pertahankan;
                                  break;
                              }

                              final prompt = ''' 
                            Berikan rekomendasi kepada saya olahraga apa yang baik untuk saya dengan deskripsi sebagai berikut.

                            Saya adalah seseorang dengan gender: $gender, usia: ${healthProfile.age} tahun, dengan index BMI: ${healthProfile.bmiIndex!.toStringAsFixed(2)} yang hidup di negara Indonesia.

                            Aktivitas keseharian saya adalah ${activityStatusResult.label}.

                            Tujuan kesehatan saya adalah ingin ${healthPurposeResult.label}.

                            Berikan rekomendasi seolah olah Anda adalah dokter yang berpengalaman.
                            ''';

                              log('Prompt: $prompt');
                              gemini.text(prompt).then((value) {
                                final result = value?.content?.parts?.last.text;
                                log('Result: $result');

                                pop(context);

                                goTo(
                                    context,
                                    SportRecommendationView(
                                      result: result!,
                                    ));
                              }).catchError((e) {
                                log('Error on Gemini: $e');
                              });
                            });
                          },
                        ),
                        const Gap(24),
                        FoodCard(
                          onTap: () {
                            _showConfirmationDialog(context,
                                isSportRecommendation: false, onYesPressed: () {
                              pop(context);
                              showLoadingDialog(context);
                              final healthProfile = user.healthProfile;
                              final gender = (healthProfile!.gender == 0)
                                  ? 'laki-laki'
                                  : 'perempuan';

                              ActivityStatus? activityStatusResult;
                              HealthPurpose? healthPurposeResult;
                              switch (healthProfile.activityStatus) {
                                case 0:
                                  activityStatusResult =
                                      ActivityStatus.sangatJarang;
                                  break;
                                case 1:
                                  activityStatusResult = ActivityStatus.jarang;
                                  break;
                                case 2:
                                  activityStatusResult = ActivityStatus.normal;
                                  break;
                                case 3:
                                  activityStatusResult = ActivityStatus.sering;
                                  break;
                                case 4:
                                  activityStatusResult =
                                      ActivityStatus.sangatSering;
                                  break;
                                default:
                                  activityStatusResult = ActivityStatus.normal;
                                  break;
                              }

                              switch (healthProfile.healthPurpose) {
                                case 0:
                                  healthPurposeResult =
                                      HealthPurpose.turunBBEkstrim;
                                  break;
                                case 1:
                                  healthPurposeResult = HealthPurpose.turunBB;
                                  break;
                                case 2:
                                  healthPurposeResult =
                                      HealthPurpose.pertahankan;
                                  break;
                                case 3:
                                  healthPurposeResult =
                                      HealthPurpose.menaikkanBB;
                                  break;
                                case 4:
                                  healthPurposeResult =
                                      HealthPurpose.menaikkanBBEkstrim;
                                  break;
                                default:
                                  healthPurposeResult =
                                      HealthPurpose.pertahankan;
                                  break;
                              }

                              final prompt = ''' 
                            Berikan rekomendasi kepada saya makanan apa yang cocok untuk saya jadikan program diet.

                            Saya adalah seseorang dengan gender: $gender, usia: ${healthProfile.age} tahun dengan index BMI: ${healthProfile.bmiIndex!.toStringAsFixed(2)} dan Basal Metabolic Rate: ${healthProfile.bmr!.toStringAsFixed(0)}kkal yang hidup di negara Indonesia.

                            Berat badan saya adalah ${healthProfile.weight}kg dan hari ini, kalori yang telah saya penuhi adalah sekitar ${dailyCalSupplied.toStringAsFixed(0)}kkal dari makanan utama.

                            Tujuan saya adalah ingin ${healthPurposeResult.label} dan aktivitas harian saya adalah aktivitas ${activityStatusResult.label}.

                            Berikan rekomendasi seolah olah Anda adalah dokter yang berpengalaman.
                            ''';

                              log('Prompt: $prompt');
                              gemini.text(prompt).then((value) {
                                final result = value?.content?.parts?.last.text;
                                log('Result: $result');

                                pop(context);

                                goTo(
                                    context,
                                    FoodRecommendationView(
                                      result: result!,
                                    ));
                              }).catchError((e) {
                                log('Error on Gemini: $e');
                              });
                            });
                          },
                        ),
                        const Gap(50)
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (userState is GetUserDataFailure) {
            return Scaffold(
              body: ErrorView(message: userState.message),
            );
          } else if (userState is GetUserDataLoading) {
            return const Scaffold(
              body: Loading(),
            );
          } else {
            return const ErrorView(message: 'Terjadi Kesalahan');
          }
        },
      ),
    );
  }

  Row _buildUserAvatarName({required String name, required String photoUrl}) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            photoUrl,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
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
                  '${dailyCaloriesNeeded.toStringAsFixed(0)} kkal',
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
                  '${dailyCaloriesSupplied.toStringAsFixed(0)} kkal',
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

  void _showConfirmationDialog(BuildContext context,
      {required void Function()? onYesPressed,
      required bool isSportRecommendation}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Rekomendasi ${isSportRecommendation ? 'Olahraga' : 'Makanan'}'),
            content: const Text('Apakah kamu yakin ingin melanjutkan?'),
            actions: [
              TextButton(
                  onPressed: () {
                    pop(context);
                  },
                  child: const Text('Tidak')),
              TextButton(onPressed: onYesPressed, child: const Text('Yakin')),
            ],
          );
        });
  }
}
