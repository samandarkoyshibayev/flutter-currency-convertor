import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../widgets/analytics_header_widget.dart';
import '../widgets/current_rate_widget.dart';
import '../widgets/period_selector_widget.dart';
import '../widgets/analytics_chart_widget.dart';
import '../widgets/market_insights_widget.dart';
import '../widgets/statistcs_section_widget.dart';

class CurrencyAnalyticsPage extends StatefulWidget {
  final dynamic currency;
  final String selectedLanguage;
  final bool isDarkMode;

  const CurrencyAnalyticsPage({
    super.key,
    required this.currency,
    required this.selectedLanguage,
    required this.isDarkMode,
  });

  @override
  State<CurrencyAnalyticsPage> createState() =>
      _CurrencyAnalyticsPageState();
}

class _CurrencyAnalyticsPageState extends State<CurrencyAnalyticsPage> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  String selectedPeriod = '1W';

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  List<FlSpot> _generateChartData() {
    final rate = double.tryParse(widget.currency.rate) ?? 12000.0;
    final diff = double.tryParse(
      widget.currency.diff.replaceAll(RegExp(r'[^0-9.-]'), ''),
    ) ??
        0;

    switch (selectedPeriod) {
      case '1D':
        return List.generate(24, (i) {
          final variance = (i % 6 - 3) * (rate * 0.001);
          return FlSpot(i.toDouble(), rate + variance);
        });
      case '1W':
        return List.generate(7, (i) {
          final variance = (i % 4 - 2) * (rate * 0.005);
          return FlSpot(i.toDouble(), rate + variance - (diff * i * 0.3));
        });
      case '1M':
        return List.generate(30, (i) {
          final variance = (i % 8 - 4) * (rate * 0.008);
          return FlSpot(i.toDouble(), rate + variance - (diff * i * 0.1));
        });
      case '3M':
        return List.generate(12, (i) {
          final variance = (i % 5 - 2.5) * (rate * 0.015);
          return FlSpot(i.toDouble(), rate + variance - (diff * i * 0.5));
        });
      case '1Y':
        return List.generate(12, (i) {
          final variance = (i % 6 - 3) * (rate * 0.025);
          return FlSpot(i.toDouble(), rate + variance - (diff * i * 2));
        });
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: widget.isDarkMode);
    final rate = double.tryParse(widget.currency.rate) ?? 0;
    final diff = widget.currency.diff;
    final isPositive = diff.startsWith('+') || !diff.startsWith('-');

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AnalyticsHeaderWidget(
              currency: widget.currency,
              selectedLanguage: widget.selectedLanguage,
              isDarkMode: widget.isDarkMode,
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CurrentRateCardWidget(
                      currency: widget.currency,
                      selectedLanguage: widget.selectedLanguage,
                      isDarkMode: widget.isDarkMode,
                      animation: _animController,
                    ),
                    const SizedBox(height: 24),
                    PeriodSelectorWidget(
                      selectedPeriod: selectedPeriod,
                      isDarkMode: widget.isDarkMode,
                      onPeriodChanged: (period) {
                        setState(() => selectedPeriod = period);
                      },
                      animation: Tween<Offset>(
                        begin: const Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animController,
                          curve: const Interval(
                            0.2,
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnalyticsChartWidget(
                      chartData: _generateChartData(),
                      selectedPeriod: selectedPeriod,
                      isDarkMode: widget.isDarkMode,
                      animation: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animController,
                          curve: const Interval(
                            0.3,
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    StatisticsSectionWidget(
                      rate: rate,
                      selectedLanguage: widget.selectedLanguage,
                      isDarkMode: widget.isDarkMode,
                      animation: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animController,
                          curve: const Interval(
                            0.4,
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    MarketInsightsWidget(
                      isPositive: isPositive,
                      selectedLanguage: widget.selectedLanguage,
                      isDarkMode: widget.isDarkMode,
                      animation: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animController,
                          curve: const Interval(
                            0.5,
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}