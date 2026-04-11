import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';


class SearchBarWidget extends StatelessWidget {
  final bool isSearchExpanded;
  final String searchQuery;
  final TextEditingController searchTextController;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;
  final VoidCallback onClear;
  final Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.isSearchExpanded,
    required this.searchQuery,
    required this.searchTextController,
    required this.onExpand,
    required this.onCollapse,
    required this.onClear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onExpand,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: context.colors.searchBarColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSearchExpanded
                ? context.colors.primaryColor.withValues(alpha: 0.4)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: isSearchExpanded
                  ? context.colors.primaryColor
                  : context.colors.textSecondary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isSearchExpanded
                  ? Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: context.colors.primaryColor,
                          selectionColor: context.colors.primaryColor.withValues(
                            alpha: 0.3,
                          ),
                          selectionHandleColor: context.colors.primaryColor,
                        ),
                      ),
                      child: TextField(
                        controller: searchTextController,
                        autofocus: true,
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: context.l10n.search_hint,
                          hintStyle: TextStyle(color: context.colors.textSecondary),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: onChanged,
                      ),
                    )
                  : Text(
                      context.l10n.search_hint,
                      style: TextStyle(
                        color: context.colors.textSecondary,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
            if (isSearchExpanded) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: searchQuery.isNotEmpty ? onClear : onCollapse,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.close_rounded,
                    color: context.colors.textSecondary,
                    size: 22,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
