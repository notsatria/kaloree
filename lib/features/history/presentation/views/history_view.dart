import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/features/history/presentation/bloc/get_total_calories_in_week_bloc.dart';
import 'package:kaloree/features/history/presentation/bloc/get_user_data_bloc.dart';
import 'package:kaloree/features/history/presentation/widgets/weekly_calories_chart.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<GetTotalCaloriesInWeekBloc>().add(GetTotalCaloriesInWeek());
    context.read<GetUserDataBloc>().add(GetUserData());
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
          log("State in HistoryView: $state");
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
    double dailyCaloriesNeeded = 0;
    final userDataBlocState = context.watch<GetUserDataBloc>().state;
    if (userDataBlocState is GetUserDataSuccess) {
      dailyCaloriesNeeded = userDataBlocState.user.healthProfile?.bmr ?? 0;
    }
    return SafeArea(
      child: Scaffold(
        appBar: _buildHistoryAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              WeeklyCaloriesChart(
                data: data,
                dailyCaloriesNeeded: dailyCaloriesNeeded,
              ),
            ],
          ),
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
