import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../domain/entities/currency_entity.dart';

class CurrencyItemWidget extends StatelessWidget {
  final CurrencyEntity currency;
  final bool isDarkMode;
  final String selectedLanguage;
  final VoidCallback onTap;

  const CurrencyItemWidget({
    super.key,
    required this.currency,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);
    final isPositive = currency.diff.startsWith('+') ||
        !currency.diff.startsWith('-');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : const Color(0xFF4A5568).withOpacity(0.06),
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
                        colors.primaryColor.withOpacity(0.15),
                        colors.primaryColor.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCurrencyFlag(
                        currency.ccy,
                        colors.primaryColor,
                        isDarkMode,
                      ),
                      const SizedBox(width: 14),
                      Text(
                        currency.ccy,
                        style: TextStyle(
                          color: colors.primaryColor,
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
                        _getCurrencyName(currency),
                        style: TextStyle(
                          color: colors.textPrimary,
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
                              color: colors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '1 ${currency.ccy}',
                              style: TextStyle(
                                color: colors.primaryColor,
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
                              color: colors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              '${currency.rate} UZS',
                              style: TextStyle(
                                color: colors.textPrimary,
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
                            ? colors.accentColor.withOpacity(0.12)
                            : colors.errorColor.withOpacity(0.12),
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
                                ? colors.accentColor
                                : colors.errorColor,
                            size: 14,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            currency.diff,
                            style: TextStyle(
                              color: isPositive
                                  ? colors.accentColor
                                  : colors.errorColor,
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
                      color: colors.textSecondary.withOpacity(0.5),
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

  Widget _buildCurrencyFlag(
      String ccy,
      Color primaryColor,
      bool isDarkMode,
      ) {
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
                  color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.08),
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

  String _getCurrencyName(CurrencyEntity currency) {
    switch (selectedLanguage) {
      case 'UZ':
        return currency.ccyNmUz;
      case 'RU':
        return currency.ccyNmRu;
      case 'EN':
      default:
        return currency.ccyNmEN;
    }
  }
}