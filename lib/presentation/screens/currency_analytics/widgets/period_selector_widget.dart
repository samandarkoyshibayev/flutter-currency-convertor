import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';


class PeriodSelectorWidget extends StatelessWidget {
  final String selectedPeriod;
  final bool isDarkMode;
  final Function(String) onPeriodChanged;
  final Animation<Offset> animation;

  const PeriodSelectorWidget({
    super.key,
    required this.selectedPeriod,
    required this.isDarkMode,
    required this.onPeriodChanged,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    return SlideTransition(
      position: animation,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildPeriodChip('1D', colors),
            const SizedBox(width: 8),
            _buildPeriodChip('1W', colors),
            const SizedBox(width: 8),
            _buildPeriodChip('1M', colors),
            const SizedBox(width: 8),
            _buildPeriodChip('3M', colors),
            const SizedBox(width: 8),
            _buildPeriodChip('1Y', colors),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodChip(String period, AppThemeColors colors) {
    final isSelected = selectedPeriod == period;
    return GestureDetector(
      onTap: () => onPeriodChanged(period),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryColor : colors.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colors.primaryColor
                : colors.textSecondary.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: Text(
          period,
          style: TextStyle(
            color: isSelected ? Colors.white : colors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}