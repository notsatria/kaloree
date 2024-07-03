import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/colors.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/core/utils/show_snackbar.dart';
import 'package:kaloree/core/widgets/dialog.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/assesment/presentation/bloc/assesment_bloc.dart';
import 'package:kaloree/features/assesment/presentation/views/personal_assesment_view.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_error_view.dart';

class AssesmentResultView extends StatefulWidget {
  const AssesmentResultView({super.key});

  @override
  State<AssesmentResultView> createState() => _AssesmentResultViewState();
}

class _AssesmentResultViewState extends State<AssesmentResultView> {
  @override
  void initState() {
    super.initState();
    debugPrint("Initstate: running GetUserData");
    context.read<AssesmentBloc>().add(GetUserData());
  }

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
      child: BlocConsumer<AssesmentBloc, AssesmentState>(
        listener: (context, state) {
          if (state is GetUserDataFailed) {
            showSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          debugPrint("State: $state");
          if (state is GetUserDataSuccess) {
            final userData = state.userModel;
            final healthProfile = userData.healthProfile;
            final bmr = healthProfile?.bmr?.toInt();

            return Scaffold(
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
                      height: getMaxHeight(context) * 0.47,
                      padding:
                          const EdgeInsets.symmetric(horizontal: margin_20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: _buildClassificationActivitiesResult(
                        activityStatus: healthProfile!.activityStatus,
                        healthPurpose: healthProfile.healthPurpose,
                        nutritionClassification:
                            healthProfile.nutritionClassification!,
                        gender: healthProfile.gender,
                      ),
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
                    bottom: getMaxHeight(context) * 0.46,
                    left: 20,
                    right: 20,
                    child: Container(
                      width: getMaxHeight(context),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
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
                              '$bmr kkal',
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
                          'Hai, \n${userData.fullName}',
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
                        _buildResultScoreCard(
                          age: healthProfile.age!,
                          bmi: healthProfile.bmiIndex!,
                          height: healthProfile.height,
                          weight: healthProfile.weight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetUserDataFailed) {
            return Scaffold(
              body: ErrorView(message: state.message),
            );
          } else {
            return const Scaffold(
              body: Loading(),
            );
          }
        },
      ),
    );
  }

  Column _buildClassificationActivitiesResult({
    required int activityStatus,
    required int healthPurpose,
    required String nutritionClassification,
    required int gender,
  }) {
    ActivityStatus? activityStatusResult;
    HealthPurpose? healthPurposeResult;
    switch (activityStatus) {
      case 0:
        activityStatusResult = ActivityStatus.sangatJarang;
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
        activityStatusResult = ActivityStatus.sangatSering;
        break;
      default:
        activityStatusResult = ActivityStatus.normal;
        break;
    }

    switch (healthPurpose) {
      case 0:
        healthPurposeResult = HealthPurpose.turunBBEkstrim;
        break;
      case 1:
        healthPurposeResult = HealthPurpose.turunBB;
        break;
      case 2:
        healthPurposeResult = HealthPurpose.pertahankan;
        break;
      case 3:
        healthPurposeResult = HealthPurpose.menaikkanBB;
        break;
      case 4:
        healthPurposeResult = HealthPurpose.menaikkanBBEkstrim;
        break;
      default:
        healthPurposeResult = HealthPurpose.pertahankan;
        break;
    }

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
                    title: 'Status Aktivitas Fisik',
                    value: activityStatusResult.label,
                  ),
                  const Gap(15),
                  _buildClassificationResult(
                    image: iconHeartPlus,
                    title: 'Klasifikasi Status Gizi',
                    value: nutritionClassification,
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
                    value: healthPurposeResult.label,
                  ),
                  const Gap(15),
                  GestureDetector(
                    onTap: () {
                      _showFormulaDialog(context,
                          gender: gender, activityStatus: activityStatus);
                    },
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

  Container _buildResultScoreCard(
      {required int height,
      required int weight,
      required int age,
      required double bmi}) {
    double parsedBMI = double.parse(bmi.toStringAsFixed(1));
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
                _buildCustomText(title: 'Tinggi Badan', value: '$height cm'),
                const Gap(12),
                _buildCustomText(title: 'Usia', value: '$age Tahun'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomText(title: 'Berat Badan', value: '$weight kg'),
                const Gap(12),
                _buildCustomText(title: 'Index BMI', value: '$parsedBMI'),
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

  void _showFormulaDialog(BuildContext context,
      {required int gender, required int activityStatus}) {
    String genderName = 'Laki-laki';
    String bmrByGender = 'BMR = 66 + (13.7 x BB) + (5 x TB) - (6.78 x U)';
    String activityStatusFactor = '1.2';
    ActivityStatus? activityStatusResult;
    if (gender == 0) {
      genderName = 'Laki-laki';
      bmrByGender = 'BMR = 66 + (13.7 x BB) + (5 x TB) - (6.78 x U)';
    } else {
      genderName = 'Perempuan';
      bmrByGender = 'BMR = 655 + (9.6 x BB) + (1.8 x TB) - (4.7 x U)';
    }

    switch (activityStatus) {
      case 0:
        activityStatusResult = ActivityStatus.sangatJarang;
        activityStatusFactor = '1.2';
        break;
      case 1:
        activityStatusResult = ActivityStatus.jarang;
        activityStatusFactor = '1.375';
        break;
      case 2:
        activityStatusResult = ActivityStatus.normal;
        activityStatusFactor = '1.55';
        break;
      case 3:
        activityStatusResult = ActivityStatus.sering;
        activityStatusFactor = '1.725';
        break;
      case 4:
        activityStatusResult = ActivityStatus.sangatSering;
        activityStatusFactor = '1.9';
        break;
      default:
        activityStatusResult = ActivityStatus.normal;
        break;
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Rumus Kebutuhan Kalori Harian',
                style: interBold.copyWith(fontSize: 16),
              ),
            ),
            content: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Teori Harris Benedict',
                    style: interSemiBold,
                  ),
                  const Gap(4),
                  Text(
                    'Basal Metabolic Rate (BMR) merupakan kebutuhan energi minimal yang diperlukan tubuh untuk mempertahankan fungsinya.',
                    style: interRegular,
                  ),
                  const Gap(8),
                  Text('Rumus (Gender $genderName):'),
                  Text(
                    bmrByGender,
                    style: interBold,
                  ),
                  const Gap(8),
                  Text(
                    'Total Kalori = Faktor aktivitas fisik x BMR',
                    style: interBold,
                  ),
                  Text(
                      'Faktor aktivitas fisik Anda = $activityStatusFactor (${activityStatusResult!.label})'),
                  Text(
                    'Total Kalori = $activityStatusFactor x BMR',
                    style: interBold,
                  ),
                  const Gap(4),
                  const Divider(),
                  const Gap(4),
                  Text(
                    'Keterangan',
                    style: interSemiBold,
                  ),
                  const Text('BMR = Basal Metabolic Rate'),
                  const Text('BB = Berat Badan (kg)'),
                  const Text('TB = Tinggi Badan (cm)'),
                  const Text('U = Umur (tahun)'),
                ],
              ),
            ),
          );
        });
  }
}
