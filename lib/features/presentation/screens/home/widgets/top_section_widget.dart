import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';

import 'main_page_header_widget.dart';
import 'search_bar_widget.dart';

class TopSectionWidget extends StatelessWidget {
  final DateTime selectedDate;
  final bool isSearchExpanded;
  final String searchQuery;
  final TextEditingController searchTextController;
  final VoidCallback onThemeToggle;
  final VoidCallback onLanguageSelect;
  final VoidCallback onDateSelect;
  final VoidCallback onSearchExpand;
  final VoidCallback onSearchCollapse;
  final VoidCallback onSearchClear;
  final ValueChanged<String> onSearchChanged;

  const TopSectionWidget({
    super.key,
    required this.selectedDate,
    required this.isSearchExpanded,
    required this.searchQuery,
    required this.searchTextController,
    required this.onThemeToggle,
    required this.onLanguageSelect,
    required this.onDateSelect,
    required this.onSearchExpand,
    required this.onSearchCollapse,
    required this.onSearchClear,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colors.primaryColor.withValues(alpha: 0.05),
            context.colors.cardColor,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainScreenHeaderWidget(
                selectedDate: selectedDate,
                onThemeToggle: onThemeToggle,
                onLanguageSelect: onLanguageSelect,
                onDateSelect: onDateSelect,
              ),
              const SizedBox(height: 16),
              SearchBarWidget(
                isSearchExpanded: isSearchExpanded,
                searchQuery: searchQuery,
                searchTextController: searchTextController,
                onExpand: onSearchExpand,
                onCollapse: onSearchCollapse,
                onClear: onSearchClear,
                onChanged: onSearchChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}