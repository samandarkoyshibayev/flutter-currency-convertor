import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';

class MainScreenHeaderWidget extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedLanguage;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final VoidCallback onLanguageSelect;
  final VoidCallback onDateSelect;

  const MainScreenHeaderWidget({
    super.key,
    required this.selectedDate,
    required this.selectedLanguage,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onLanguageSelect,
    required this.onDateSelect,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.t('title', selectedLanguage),
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 21,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'EEEE, MMM dd',
                          _getLocaleFromLanguage(selectedLanguage),
                        ).format(selectedDate),
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            _buildHeaderButton(
              icon: isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              onTap: onThemeToggle,
              colors: colors,
            ),
            const SizedBox(width: 8),
            _buildHeaderButton(
              icon: Icons.translate_rounded,
              onTap: onLanguageSelect,
              colors: colors,
            ),
            const SizedBox(width: 8),
            _buildHeaderButton(
              icon: Icons.calendar_today_rounded,
              onTap: onDateSelect,
              colors: colors,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
    required AppThemeColors colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors.searchBarColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: colors.primaryColor, size: 20),
      ),
    );
  }

  String _getLocaleFromLanguage(String lang) {
    switch (lang) {
      case 'UZ':
        return 'uz_UZ';
      case 'RU':
        return 'ru_RU';
      case 'EN':
      default:
        return 'en_US';
    }
  }
}