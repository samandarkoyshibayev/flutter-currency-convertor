import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';


class SearchBarWidget extends StatelessWidget {
  final bool isSearchExpanded;
  final String searchQuery;
  final TextEditingController searchTextController;
  final String selectedLanguage;
  final bool isDarkMode;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;
  final VoidCallback onClear;
  final Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.isSearchExpanded,
    required this.searchQuery,
    required this.searchTextController,
    required this.selectedLanguage,
    required this.isDarkMode,
    required this.onExpand,
    required this.onCollapse,
    required this.onClear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    return GestureDetector(
      onTap: onExpand,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: colors.searchBarColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSearchExpanded
                ? colors.primaryColor.withOpacity(0.4)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: isSearchExpanded ? colors.primaryColor : colors.textSecondary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isSearchExpanded
                  ? TextField(
                controller: searchTextController,
                autofocus: true,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: AppStrings.t(
                    'search_hint',
                    selectedLanguage,
                  ),
                  hintStyle: TextStyle(
                    color: colors.textSecondary,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: onChanged,
              )
                  : Text(
                AppStrings.t(
                  'search_hint',
                  selectedLanguage,
                ),
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSearchExpanded) ...[
              if (searchQuery.isNotEmpty)
                GestureDetector(
                  onTap: onClear,
                  child: Icon(
                    Icons.clear_rounded,
                    color: colors.textSecondary,
                    size: 20,
                  ),
                ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onCollapse,
                child: Icon(
                  Icons.close_rounded,
                  color: colors.textSecondary,
                  size: 22,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}