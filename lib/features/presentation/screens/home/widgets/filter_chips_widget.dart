import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';

class FilterChipsWidget extends StatelessWidget {
  final String sortBy;
  final Function(String) onSortChanged;
  final VoidCallback onSortButtonTap;

  const FilterChipsWidget({
    super.key,
    required this.sortBy,
    required this.onSortChanged,
    required this.onSortButtonTap,
  });

  @override
  Widget build(BuildContext context) {
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
                    context.l10n.all,
                    sortBy == 'name',
                    () => onSortChanged('name'),
                    context,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    context.l10n.popular,
                    sortBy == 'popular',
                    () => onSortChanged('popular'),
                    context,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    context.l10n.trending,
                    sortBy == 'trending',
                    () => onSortChanged('trending'),
                    context,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildSortButton(context),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    bool isSelected,
    VoidCallback onTap,
    final BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primaryColor
              : context.colors.searchBarColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? context.colors.primaryColor
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : context.colors.textSecondary,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSortButton(final BuildContext context) {
    return GestureDetector(
      onTap: onSortButtonTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.colors.searchBarColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.sort_rounded,
          color: context.colors.primaryColor,
          size: 22,
        ),
      ),
    );
  }
}
