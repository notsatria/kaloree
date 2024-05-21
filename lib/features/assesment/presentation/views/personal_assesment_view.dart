import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/colors.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/features/assesment/presentation/bloc/assesment_bloc.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_body_size_form.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_progress_indicator.dart';

class PersonalAssesmentView extends StatefulWidget {
  const PersonalAssesmentView({super.key});

  @override
  State<PersonalAssesmentView> createState() => _PersonalAssesmentViewState();
}

class _PersonalAssesmentViewState extends State<PersonalAssesmentView> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final TextEditingController activityStatusController =
      TextEditingController();
  ActivityStatus? selectedActivityStatus;
  final TextEditingController healthPurposeController = TextEditingController();
  HealthPurpose? selectedHealthPurpose;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssesmentBloc, AssesmentState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffEAEAEA),
          resizeToAvoidBottomInset: false,
          appBar: buildCustomAppBar(title: 'Asesmen Diri', context: context),
          bottomNavigationBar: buildCustomBottomAppBar(
            text: 'Lihat Hasil',
            onTap: () {
              context.read<AssesmentBloc>().add(
                    SavePersonalInfo(
                      height: int.parse(heightController.text),
                      weight: int.parse(weightController.text),
                      activityStatus: selectedActivityStatus!.value,
                      healthPurpose: selectedHealthPurpose!.value,
                    ),
                  );
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
      },
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomBodySizeForm(
                  controller: heightController,
                  hintText: 'Tinggi Badan',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  suffixText: 'cm',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tinggi kosong';
                    }
                    return null;
                  },
                ),
              ),
              const Gap(16),
              Expanded(
                  child: CustomBodySizeForm(
                controller: weightController,
                hintText: 'Berat Badan',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                suffixText: 'kg',
                validator: (value) {
                  return 'Berat kosong';
                },
              )),
            ],
          ),
          const Gap(24),
          DropdownMenu<ActivityStatus>(
            width: getMaxWidth(context) / 1.23,
            controller: activityStatusController,
            requestFocusOnTap: false,
            onSelected: (ActivityStatus? activityStatus) {
              setState(() {
                selectedActivityStatus = activityStatus;
                debugPrint('Activity Status Value: ${activityStatus?.value}');
              });
            },
            hintText: 'Status Aktivitas Fisik',
            leadingIcon: Icon(
              Icons.directions_run_outlined,
              color: lightColorScheme.outline,
            ),
            textStyle: interRegular.copyWith(
                fontSize: 16, color: lightColorScheme.outline),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: interRegular.copyWith(
                  fontSize: 16, color: lightColorScheme.outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: lightColorScheme.outline,
                ),
              ),
            ),
            dropdownMenuEntries: ActivityStatus.values
                .map<DropdownMenuEntry<ActivityStatus>>(
                    (ActivityStatus activityStatus) {
              return DropdownMenuEntry<ActivityStatus>(
                value: activityStatus,
                label: activityStatus.label,
                enabled: activityStatus.label != 'Grey',
              );
            }).toList(),
          ),
          const Gap(24),
          DropdownMenu<HealthPurpose>(
            width: getMaxWidth(context) / 1.23,
            controller: healthPurposeController,
            requestFocusOnTap: false,
            onSelected: (HealthPurpose? healthPurpose) {
              setState(() {
                selectedHealthPurpose = healthPurpose;
              });
            },
            hintText: 'Tujuan Kesehatan',
            leadingIcon: Icon(
              Icons.sports_gymnastics,
              color: lightColorScheme.outline,
            ),
            textStyle: interRegular.copyWith(
                fontSize: 16, color: lightColorScheme.outline),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: interRegular.copyWith(
                  fontSize: 16, color: lightColorScheme.outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: lightColorScheme.outline,
                ),
              ),
            ),
            dropdownMenuEntries: HealthPurpose.values
                .map<DropdownMenuEntry<HealthPurpose>>(
                    (HealthPurpose healthPurpose) {
              return DropdownMenuEntry<HealthPurpose>(
                value: healthPurpose,
                label: healthPurpose.label,
                enabled: healthPurpose.label != 'Grey',
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

enum ActivityStatus {
  istirahat('Istirahat di Tempat Tidur', 0),
  sangatRingan('Kerja Sangat Ringan', 1),
  ringan('Kerja Ringan', 2),
  ringanSedang('Kerja Ringan-Sedang', 3),
  sedang('Kerja Sedang', 4),
  berat('Kerja Berat', 5),
  beratSekali('Kerja Berat Sekali', 6);

  const ActivityStatus(this.label, this.value);
  final String label;
  final int value;
}

enum HealthPurpose {
  turunBBEkstrim('Menurunkan Berat Badan Ekstrim', 0),
  turunBB('Menurunkan Berat Badan', 1),
  pertahankan('Mempertahankan Berat Badan', 2),
  menaikkanBB('Menaikkan Berat Badan', 3),
  menaikkanBBEkstrim('Menaikkan Berat Badan Ekstrim', 4);

  const HealthPurpose(this.label, this.value);
  final String label;
  final int value;
}
