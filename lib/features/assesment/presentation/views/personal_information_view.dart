import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kaloree/core/routes/app_route.dart';
import 'package:kaloree/core/theme/colors.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/theme/sizes.dart';
import 'package:kaloree/features/assesment/presentation/bloc/assesment_bloc.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_form_field.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_progress_indicator.dart';

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView({super.key});

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  final nameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssesmentBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xffEAEAEA),
        appBar: buildCustomAppBar(
            title: 'Data Diri', context: context, canPop: false),
        bottomNavigationBar: buildCustomBottomAppBar(
          text: 'Berikutnya',
          onTap: () {
            if (formKey.currentState!.validate()) {
              context.read<AssesmentBloc>().add(SavePersonalInfo(
                    fullName: nameController.text,
                    dateOfBirth: dateOfBirthController.text,
                  ));
              goToNamed(context, AppRoute.genderInformation);
            }
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
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomFormField(
              controller: nameController,
              hintText: 'Nama Lengkap',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (value!.length <= 1) {
                  return 'Masukkan Nama Anda';
                }
                return null;
              },
            ),
            const Gap(24),
            CustomFormField(
              readOnly: true,
              controller: dateOfBirthController,
              onTap: () {
                _selectDate(context);
              },
              hintText: 'Tanggal Lahir',
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
              prefixIcon: Icons.date_range_outlined,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Masukkan Tanggal Lahir Anda';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateOfBirthController.text = DateFormat.yMMMMd().format(selectedDate);
      });
    }
  }
}
