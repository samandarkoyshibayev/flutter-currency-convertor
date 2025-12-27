import 'package:flutter/material.dart';

import '../../core/app_colors.dart';


class ConverterInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String currencyCode;
  final bool isDarkMode;

  const ConverterInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.currencyCode,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                fontFamily: 'Inter',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            currencyCode,
            style: TextStyle(
              color: colors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}