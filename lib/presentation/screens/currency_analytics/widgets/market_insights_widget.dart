import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';


class MarketInsightsWidget extends StatelessWidget {
  final bool isPositive;
  final String selectedLanguage;
  final bool isDarkMode;
  final Animation<Offset> animation;

  const MarketInsightsWidget({
    super.key,
    required this.isPositive,
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
            AppStrings.t('market_insights', selectedLanguage),
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          _buildInsightCard(
            isPositive
                ? AppStrings.t('bullish_title', selectedLanguage)
                : AppStrings.t('bearish_title', selectedLanguage),
            isPositive
                ? AppStrings.t('bullish_desc', selectedLanguage)
                : AppStrings.t('bearish_desc', selectedLanguage),
            isPositive
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            isPositive ? colors.accentColor : colors.errorColor,
            colors,
          ),
          const SizedBox(height: 12),
          _buildInsightCard(
            AppStrings.t('stability_title', selectedLanguage),
            AppStrings.t('stability_desc', selectedLanguage),
            Icons.shield_outlined,
            colors.primaryColor,
            colors,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
      String title,
      String description,
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
          color: color.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}