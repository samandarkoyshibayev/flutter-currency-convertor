import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';


class SortBottomSheetWidget extends StatelessWidget {
  final String sortBy;
  final ValueChanged<String> onSortSelected;

  const SortBottomSheetWidget({
    super.key,
    required this.sortBy,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: context.colors.cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colors.textSecondary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              context.l10n.sort_by,
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SortOptionItem(
            label: context.l10n.name,
            value: 'name',
            icon: Icons.sort_by_alpha_rounded,
            sortBy: sortBy,
            context: context,
            onSortSelected: onSortSelected,
          ),
          _SortOptionItem(
            label: context.l10n.most_popular,
            value: 'popular',
            icon: Icons.star_rounded,
            sortBy: sortBy,
            onSortSelected: onSortSelected,
            context: context,
          ),
          _SortOptionItem(
            label: context.l10n.trending,
            value: 'trending',
            icon: Icons.trending_up_rounded,
            sortBy: sortBy,
            context: context,
            onSortSelected: onSortSelected,
          ),
          _SortOptionItem(
            label: context.l10n.highest_rate,
            value: 'rate',
            icon: Icons.arrow_upward_rounded,
            sortBy: sortBy,
            context: context,
            onSortSelected: onSortSelected,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SortOptionItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final String sortBy;
  final ValueChanged<String> onSortSelected;
  final BuildContext context;

  const _SortOptionItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.sortBy,
    required this.onSortSelected, 
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = sortBy == value;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onSortSelected(value);
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colors.primaryColor.withValues(alpha: 0.15)
                      : context.colors.searchBarColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? context.colors.primaryColor : context.colors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? context.colors.primaryColor : context.colors.textPrimary,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: context.colors.primaryColor,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}