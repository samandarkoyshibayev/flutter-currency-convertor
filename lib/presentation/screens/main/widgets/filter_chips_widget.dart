import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';

class FilterChipsWidget extends StatelessWidget {
  final String sortBy;
  final String selectedLanguage;
  final bool isDarkMode;
  final Function(String) onSortChanged;
  final VoidCallback onSortButtonTap;

  const FilterChipsWidget({
    super.key,
    required this.sortBy,
    required this.selectedLanguage,
    required this.isDarkMode,
    required this.onSortChanged,
    required this.onSortButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    AppStrings.t('all', selectedLanguage),
                    sortBy == 'name',
                        () => onSortChanged('name'),
                    colors,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    AppStrings.t('popular', selectedLanguage),
                    sortBy == 'popular',
                        () => onSortChanged('popular'),
                    colors,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    AppStrings.t('trending', selectedLanguage),
                    sortBy == 'trending',
                        () => onSortChanged('trending'),
                    colors,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildSortButton(colors),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
      String label,
      bool isSelected,
      VoidCallback onTap,
      AppThemeColors colors,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryColor : colors.searchBarColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colors.primaryColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : colors.textSecondary,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSortButton(AppThemeColors colors) {
    return GestureDetector(
      onTap: onSortButtonTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors.searchBarColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.sort_rounded, color: colors.primaryColor, size: 22),
      ),
    );
  }
}