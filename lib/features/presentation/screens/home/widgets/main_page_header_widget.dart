import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreenHeaderWidget extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onThemeToggle;
  final VoidCallback onLanguageSelect;
  final VoidCallback onDateSelect;

  const MainScreenHeaderWidget({
    super.key,
    required this.selectedDate,
    required this.onThemeToggle,
    required this.onLanguageSelect,
    required this.onDateSelect,
  });

  @override
  Widget build(BuildContext context) {
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
                        context.l10n.title,
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontSize: 21,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'EEEE, MMM dd',
                          _getLocaleFromLanguage(context.languageCode),
                        ).format(selectedDate),
                        style: TextStyle(
                          color: context.colors.textSecondary,
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
              icon: context.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              onTap: onThemeToggle,
              context: context

            ),
            const SizedBox(width: 8),
            _buildHeaderButton(
              icon: Icons.translate_rounded,
              onTap: onLanguageSelect,
              context: context
            ),
            const SizedBox(width: 8),
            _buildHeaderButton(
              icon: Icons.calendar_today_rounded,
              onTap: onDateSelect,
              context: context
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.colors.searchBarColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: context.colors.primaryColor, size: 20),
      ),
    );
  }

  String _getLocaleFromLanguage(String lang) {
    switch (lang) {
      case 'uz':
        return 'uz_UZ';
      case 'ru':
        return 'ru_RU';
      case 'en':
      default:
        return 'en_US';
    }
  }
}