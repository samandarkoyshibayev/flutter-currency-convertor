import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';

class LoadingStateWidget extends StatelessWidget {
  final String selectedLanguage;
  final bool isDarkMode;

  const LoadingStateWidget({
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
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colors.primaryColor.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                colors.primaryColor,
              ),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.t('loading', selectedLanguage),
            style: TextStyle(
              color: colors.textSecondary,
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}