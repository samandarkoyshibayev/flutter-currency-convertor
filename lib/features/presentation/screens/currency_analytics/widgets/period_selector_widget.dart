import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';

class PeriodSelectorWidget extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodChanged;
  final Animation<Offset> animation;

  const PeriodSelectorWidget({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {

    return SlideTransition(
      position: animation,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildPeriodChip('1D', context),
            const SizedBox(width: 8),
            _buildPeriodChip('1W', context),
            const SizedBox(width: 8),
            _buildPeriodChip('1M', context),
            const SizedBox(width: 8),
            _buildPeriodChip('3M', context),
            const SizedBox(width: 8),
            _buildPeriodChip('1Y', context),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodChip(String period, BuildContext context) {
    final isSelected = selectedPeriod == period;
    return GestureDetector(
      onTap: () => onPeriodChanged(period),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? context.colors.primaryColor : context.colors.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? context.colors.primaryColor
                : context.colors.textSecondary.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Text(
          period,
          style: TextStyle(
            color: isSelected ? Colors.white : context.colors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}