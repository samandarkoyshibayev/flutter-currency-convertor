import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';


class StatisticsSectionWidget extends StatelessWidget {
  final double rate;
  final String selectedLanguage;
  final bool isDarkMode;
  final Animation<Offset> animation;

  const StatisticsSectionWidget({
    super.key,
    required this.rate,
    required this.selectedLanguage,
    required this.isDarkMode,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    return SlideTransition(
      position: animation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.t('statistics', selectedLanguage),
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  AppStrings.t('high', selectedLanguage),
                  (rate * 1.05).toStringAsFixed(2),
                  Icons.arrow_upward_rounded,
                  colors.accentColor,
                  colors,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  AppStrings.t('low', selectedLanguage),
                  (0.95 * rate).toStringAsFixed(2),
                  Icons.arrow_downward_rounded,
                  colors.errorColor,
                  colors,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  AppStrings.t('average', selectedLanguage),
                  rate.toStringAsFixed(2),
                  Icons.analytics_rounded,
                  colors.primaryColor,
                  colors,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  AppStrings.t('volatility', selectedLanguage),
                  ((rate * 0.02).toStringAsFixed(2)),
                  Icons.show_chart_rounded,
                  const Color(0xFFFFB74D),
                  colors,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String label,
      String value,
      IconData icon,
      Color color,
      AppThemeColors colors,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.textSecondary.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}