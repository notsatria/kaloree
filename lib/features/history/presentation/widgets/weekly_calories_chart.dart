import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/utils/date_format.dart';

class WeeklyCaloriesChart extends StatefulWidget {
  final Map<String, double> data;
  final double dailyCaloriesNeeded;

  WeeklyCaloriesChart(
      {super.key, required this.data, required this.dailyCaloriesNeeded});

  final Color barBackgroundColor =
      lightColorScheme.onSurfaceVariant.withOpacity(0.5);
  final Color barColor = Colors.white;
  final Color touchedBarColor = lightColorScheme.primaryContainer;

  @override
  State<StatefulWidget> createState() => WeeklyCaloriesChartState();
}

class WeeklyCaloriesChartState extends State<WeeklyCaloriesChart> {
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  DateTime startWeekDate = getStartOfWeek(DateTime.now());
  DateTime endWeekDate = getEndOfWeek(DateTime.now());

  @override
  Widget build(BuildContext context) {
    String formattedStartWeekDate =
        formatDateTo(date: startWeekDate, format: 'MMMMd');

    String formattedEndWeekDate =
        formatDateTo(date: endWeekDate, format: 'MMMMd');

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff6DBB8A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      const Text(
                        'Mingguan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '$formattedStartWeekDate - $formattedEndWeekDate ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Grafik konsumsi kalori',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        mainBarData(data: widget.data),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: widget.dailyCaloriesNeeded,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups({required Map<String, double> data}) =>
      List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(i, data['monday'] ?? 0,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(i, data['tuesday'] ?? 0,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(i, data['wednesday'] ?? 0,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(i, data['thursday'] ?? 0,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(i, data['friday'] ?? 0,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(i, data['saturday'] ?? 0,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(i, data['sunday'] ?? 0,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData({required Map<String, double> data}) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Senin';
                break;
              case 1:
                weekDay = 'Selasa';
                break;
              case 2:
                weekDay = 'Rabu';
                break;
              case 3:
                weekDay = 'Kamis';
                break;
              case 4:
                weekDay = 'Jumat';
                break;
              case 5:
                weekDay = 'Sabtu';
                break;
              case 6:
                weekDay = 'Minggu';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.white, //widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(data: data),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('S', style: style);
        break;
      case 1:
        text = const Text('S', style: style);
        break;
      case 2:
        text = const Text('R', style: style);
        break;
      case 3:
        text = const Text('K', style: style);
        break;
      case 4:
        text = const Text('J', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('M', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
