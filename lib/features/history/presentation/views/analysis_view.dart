import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/utils/date_format.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/history/data/model/nutrition_history.dart';
import 'package:kaloree/features/history/presentation/bloc/get_nutrition_in_month_bloc.dart';
import 'package:kaloree/features/history/presentation/bloc/get_total_calories_in_week_bloc.dart';
import 'package:kaloree/features/history/presentation/bloc/get_user_data_bloc.dart';
import 'package:kaloree/features/history/presentation/widgets/nutritions_pie_chart.dart';
import 'package:kaloree/features/history/presentation/widgets/weekly_calories_bar_chart.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key});

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  @override
  void initState() {
    super.initState();
    context.read<GetTotalCaloriesInWeekBloc>().add(GetTotalCaloriesInWeek());
    context.read<GetUserDataBloc>().add(GetUserData());
    context.read<GetNutritionInMonthBloc>().add(GetNutritionInMonth());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetTotalCaloriesInWeekBloc, GetTotalCaloriesInWeekState>(
          listener: (context, state) {
            if (state is GetTotalCaloriesInWeekSuccess) {
              // You can handle additional logic here if needed
            }
          },
        ),
      ],
      child:
          BlocBuilder<GetTotalCaloriesInWeekBloc, GetTotalCaloriesInWeekState>(
        builder: (context, state) {
          log("State in AnalysisView: $state");
          if (state is GetTotalCaloriesInWeekSuccess) {
            return _buildWeeklyCaloriesChartSuccess(state.weeklyCalories);
          } else {
            Map<String, double> weeklyCalories = {
              'monday': 0,
              'tuesday': 0,
              'wednesday': 0,
              'thursday': 0,
              'friday': 0,
              'saturday': 0,
              'sunday': 0
            };
            return _buildWeeklyCaloriesChartSuccess(weeklyCalories);
          }
        },
      ),
    );
  }

  SafeArea _buildWeeklyCaloriesChartSuccess(Map<String, double> data) {
    final thisMonth = formatDateTo(date: DateTime.now(), format: 'MMMM');
    double dailyCaloriesNeeded = 0;
    final userDataBlocState = context.watch<GetUserDataBloc>().state;
    if (userDataBlocState is GetUserDataSuccess) {
      dailyCaloriesNeeded = userDataBlocState.user.healthProfile?.bmr ?? 0;
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildHistoryAppBar(),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            WeeklyCaloriesBarChart(
              data: data,
              dailyCaloriesNeeded: dailyCaloriesNeeded,
            ),
            const Gap(40),
            Center(
              child: Text(
                'Grafik Sebaran Nutrisi',
                style: interBold.copyWith(fontSize: 20, color: Colors.black54),
              ),
            ),
            Center(
              child: Text(
                'Bulan $thisMonth',
                style: interBold.copyWith(fontSize: 16, color: Colors.black54),
              ),
            ),
            BlocBuilder<GetNutritionInMonthBloc, GetNutritionInMonthState>(
              builder: (context, state) {
                log('State GetNutritionInMonth: $state');
                if (state is GetNutritionInMonthSuccess) {
                  return NutritionHistoryPieChart(
                    nutritionHistory: state.nutritionHistory,
                  );
                } else if (state is GetNutritionInMonthLoading) {
                  return const Loading();
                } else {
                  final nutritionHistory = NutritionHistory(
                      calories: 0, protein: 0, fat: 0, carbs: 0);
                  return NutritionHistoryPieChart(
                    nutritionHistory: nutritionHistory,
                  );
                }
              },
            ),
            Gap(MediaQuery.of(context).padding.top),
          ],
        ),
      ),
    );
  }

  AppBar _buildHistoryAppBar() {
    return AppBar(
      backgroundColor: lightColorScheme.background,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const Text('Analisis'),
    );
  }
}
