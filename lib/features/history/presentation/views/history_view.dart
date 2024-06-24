import 'package:flutter/material.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/features/history/presentation/widgets/weekly_calories_chart.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildHistoryAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              WeeklyCaloriesChart(),
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
