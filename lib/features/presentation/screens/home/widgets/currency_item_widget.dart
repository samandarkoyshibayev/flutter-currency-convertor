import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/currency_entity.dart';

class CurrencyItemWidget extends StatelessWidget {
  final CurrencyEntity currency;
  final VoidCallback onTap;

  const CurrencyItemWidget({
    super.key,
    required this.currency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final isPositive = currency.diff.startsWith('+') || !currency.diff.startsWith('-');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.colors.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : const Color(0xFF4A5568).withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        context.colors.primaryColor.withValues(alpha: 0.15),
                        context.colors.primaryColor.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCurrencyFlag(
                        currency.ccy,
                        context.colors.primaryColor,
                        context.isDarkMode,
                      ),
                      const SizedBox(width: 14),
                      Text(
                        currency.ccy,
                        style: TextStyle(
                          color: context.colors.primaryColor,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getCurrencyName(currency, context.languageCode),
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '1 ${currency.ccy}',
                              style: TextStyle(
                                color: context.colors.primaryColor,
                                fontFamily: 'Inter',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '=',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: context.colors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              '${currency.rate} UZS',
                              style: TextStyle(
                                color: context.colors.textPrimary,
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isPositive
                            ? context.colors.accentColor.withValues(alpha: 0.12)
                            : context.colors.errorColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPositive
                                ? Icons.trending_up_rounded
                                : Icons.trending_down_rounded,
                            color: isPositive
                                ? context.colors.accentColor
                                : context.colors.errorColor,
                            size: 14,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            currency.diff,
                            style: TextStyle(
                              color: isPositive
                                  ? context.colors.accentColor
                                  : context.colors.errorColor,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: context.colors.textSecondary.withValues(alpha: 0.5),
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCountryCode(String ccy) {
    switch (ccy) {
      case 'USD':
        return 'us';
      case 'EUR':
        return 'eu';
      case 'GBP':
        return 'gb';
      case 'JPY':
        return 'jp';
      case 'CNY':
        return 'cn';
      case 'RUB':
        return 'ru';
      case 'UZS':
        return 'uz';
      default:
        if (ccy.length >= 2) {
          return ccy.substring(0, 2).toLowerCase();
        }
        return 'us';
    }
  }

  Widget _buildCurrencyFlag(String ccy, Color primaryColor, bool isDarkMode) {
    final countryCode = _getCountryCode(ccy);
    final flagUrl = 'https://flagcdn.com/w160/$countryCode.png';
    const double flagWidth = 40.0;
    const double flagHeight = 28.0;

    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: flagWidth,
            height: flagHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDarkMode ? 0.2 : 0.08),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(flagUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrencyName(CurrencyEntity currency, String currentLanguageCode) {
    switch (currentLanguageCode) {
      case 'uz':
        return currency.ccyNmUz;
      case 'ru':
        return currency.ccyNmRu;
      case 'en':
      default:
        return currency.ccyNmEN;
    }
  }
}
