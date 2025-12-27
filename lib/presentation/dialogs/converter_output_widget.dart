import 'package:flutter/material.dart';

import '../../../core/app_strings.dart';
import '../../core/app_colors.dart';

class ConverterOutputWidget extends StatelessWidget {
  final String convertedAmount;
  final String currencyCode;
  final String fromCurrency;
  final double exchangeRate;
  final String selectedLanguage;
  final bool isDarkMode;

  const ConverterOutputWidget({
    super.key,
    required this.convertedAmount,
    required this.currencyCode,
    required this.fromCurrency,
    required this.exchangeRate,
    required this.selectedLanguage,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.textSecondary.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currencyCode,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  convertedAmount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                currencyCode,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${AppStrings.t('rate', selectedLanguage)}: '
                '1 $fromCurrency = ${exchangeRate.toStringAsFixed(4)} $currencyCode',
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 12,
              fontStyle: FontStyle.italic,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}