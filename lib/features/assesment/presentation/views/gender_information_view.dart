import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/features/assesment/presentation/bloc/assesment_bloc.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_gender_chip.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_progress_indicator.dart';

class GenderInformationView extends StatefulWidget {
  const GenderInformationView({super.key});

  @override
  State<GenderInformationView> createState() => _GenderInformationViewState();
}

class _GenderInformationViewState extends State<GenderInformationView> {
  bool firstChipSelected = true;
  bool secondChipSelected = false;
  int selectedGender = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssesmentBloc, AssesmentState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffEAEAEA),
          appBar: buildCustomAppBar(title: 'Jenis Kelamin', context: context),
          bottomNavigationBar: buildCustomBottomAppBar(
            text: 'Berikutnya',
            onTap: () {
              if (firstChipSelected) {
                selectedGender = 0;
              } else {
                selectedGender = 1;
              }
              context.read<AssesmentBloc>().add(
                    UpdateGender(gender: selectedGender),
                  );
              goToNamed(context, AppRoute.assesment);
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
                Align(
                  alignment: Alignment.center,
                  child: CustomGenderChip(
                    genderType: GenderType.male,
                    isSelected: firstChipSelected,
                    onSelected: (selected) {
                      setState(() {
                        firstChipSelected = selected;
                        secondChipSelected = !selected;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomGenderChip(
                    genderType: GenderType.female,
                    isSelected: secondChipSelected,
                    onSelected: (selected) {
                      setState(() {
                        secondChipSelected = selected;
                        firstChipSelected = !selected;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
