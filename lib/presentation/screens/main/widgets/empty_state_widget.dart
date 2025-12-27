import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';

class EmptyStateWidget extends StatelessWidget {
  final String selectedLanguage;
  final bool isDarkMode;

  const EmptyStateWidget({
    super.key,
    required this.selectedLanguage,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: colors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.t('no_results', selectedLanguage),
            style: TextStyle(
              color: colors.textSecondary,
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.t('try_other', selectedLanguage),
            style: TextStyle(
              color: colors.textSecondary.withOpacity(0.7),
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}