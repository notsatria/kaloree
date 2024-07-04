import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kaloree/core/platform/assets.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/features/history/data/model/nutrition_history.dart';
import 'package:kaloree/features/history/presentation/widgets/indicator.dart';

class NutritionHistoryPieChart extends StatefulWidget {
  final NutritionHistory nutritionHistory;

  const NutritionHistoryPieChart({super.key, required this.nutritionHistory});

  @override
  State<NutritionHistoryPieChart> createState() =>
      _NutritionHistoryPieChartState();
}

class _NutritionHistoryPieChartState extends State<NutritionHistoryPieChart> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections(widget.nutritionHistory),
              ),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Indicator(
              color: Colors.blue[300]!,
              isSquare: false,
              text: 'Kalori',
            ),
            Indicator(
              color: Colors.yellow[300]!,
              isSquare: false,
              text: 'Karbohidrat',
            ),
            Indicator(
              color: Colors.pink[300]!,
              isSquare: false,
              text: 'Lemak',
            ),
            Indicator(
              color: Colors.green[300]!,
              isSquare: false,
              text: 'Protein',
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(NutritionHistory nutritionHistory) {
    double total = (nutritionHistory.calories ?? 0) +
        (nutritionHistory.carbs ?? 0) +
        (nutritionHistory.fat ?? 0) +
        (nutritionHistory.protein ?? 0);

    final caloriesPercentage =
        (nutritionHistory.calories / total * 100).toStringAsFixed(0);
    final carbsPercentage =
        (nutritionHistory.carbs / total * 100).toStringAsFixed(0);
    final proteinPercentage =
        (nutritionHistory.protein / total * 100).toStringAsFixed(0);
    final fatPercentage =
        (nutritionHistory.fat / total * 100).toStringAsFixed(0);
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue[300],
            value: nutritionHistory.calories,
            title: '$caloriesPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              iconCalorie,
              size: widgetSize,
              borderColor: Colors.black12,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow[300],
            value: nutritionHistory.carbs,
            title: '$carbsPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              iconCarbs,
              size: widgetSize,
              borderColor: Colors.black12,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.pink[300],
            value: nutritionHistory.fat,
            title: '$fatPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              iconFat,
              size: widgetSize,
              borderColor: Colors.black12,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green[300],
            value: nutritionHistory.protein,
            title: '$proteinPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              iconProtein,
              size: widgetSize,
              borderColor: Colors.black12,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.iconPath, {
    required this.size,
    required this.borderColor,
  });
  final String iconPath;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(
          iconPath,
          width: 24,
          color: lightColorScheme.outline,
        ),
      ),
    );
  }
}
