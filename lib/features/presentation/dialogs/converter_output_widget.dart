import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';


class ConverterOutputWidget extends StatelessWidget {
  final String convertedAmount;
  final String currencyCode;
  final String fromCurrency;
  final double exchangeRate;
  final bool isBaseCurrencyUzs;

  const ConverterOutputWidget({
    super.key,
    required this.convertedAmount,
    required this.currencyCode,
    required this.fromCurrency,
    required this.exchangeRate,
    required this.isBaseCurrencyUzs,
  });

  String _rateLabel() {
    if (!isBaseCurrencyUzs) {
      return '1 $fromCurrency = ${exchangeRate.toStringAsFixed(4)} $currencyCode';
    } else {
      final inverted = exchangeRate != 0 ? (1 / exchangeRate) : 0.0;
      return '1 $fromCurrency = ${inverted.toStringAsFixed(6)} $currencyCode';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colors.textSecondary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currencyCode,
            style: TextStyle(
              color: context.colors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    convertedAmount,
                    maxLines: 1,
                    style: TextStyle(
                      color: context.colors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                currencyCode,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${context.l10n.rate}: ${_rateLabel()}',
            style: TextStyle(
              color: context.colors.textSecondary,
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