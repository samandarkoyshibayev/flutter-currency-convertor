import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';



class AnalyticsChartWidget extends StatelessWidget {
  final List<FlSpot> chartData;
  final String selectedPeriod;
  final Animation<Offset> animation;

  const AnalyticsChartWidget({
    super.key,
    required this.chartData,
    required this.selectedPeriod,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {

    return SlideTransition(
      position: animation,
      child: Container(
        height: 280,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.colors.cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 
                context.isDarkMode ? 0.2 : 0.05,
              ),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: context.colors.textSecondary.withValues(alpha: 0.1),
                  strokeWidth: 1,
                );
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
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        _getBottomTitle(value.toInt()),
                        style: TextStyle(
                          color: context.colors.textSecondary,
                          fontSize: 10,
                          fontFamily: 'Inter',
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 45,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: TextStyle(
                        color: context.colors.textSecondary,
                        fontSize: 10,
                        fontFamily: 'Inter',
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: chartData,
                isCurved: true,
                curveSmoothness: 0.4,
                color: context.colors.primaryColor,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.colors.primaryColor.withValues(alpha: 0.3),
                      context.colors.primaryColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getBottomTitle(int value) {
    switch (selectedPeriod) {
      case '1D':
        return value % 4 == 0 ? '${value}h' : '';
      case '1W':
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][value % 7];
      case '1M':
        return value % 5 == 0 ? '${value + 1}' : '';
      case '3M':
        return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][value % 12];
      case '1Y':
        return ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'][value % 12];
      default:
        return '';
    }
  }
}