import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ConverterInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String currencyCode;

  const ConverterInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.currencyCode,
  });

  
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.colors.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: context.colors.primaryColor,
                  selectionColor: context.colors.primaryColor.withValues(alpha: 0.3),
                  selectionHandleColor: context.colors.primaryColor,
                ),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textAlign: TextAlign.start,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9. ]')),
                  CurrencyInputFormatter(),
                ],
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Inter',
                ),
                cursorColor: context.colors.primaryColor,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (value.text.isNotEmpty) ...[
                    GestureDetector(
                      onTap: () {
                        controller.clear();
                        focusNode.requestFocus(); 
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: context.colors.textSecondary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: context.colors.textSecondary,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    currencyCode,
                    style: TextStyle(
                      color: context.colors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.isEmpty) return newValue;
    if (text.split('.').length > 2) return oldValue;

    final parts = text.split('.');
    final rawInteger = parts[0].replaceAll(' ', '');
    final hasDecimal = parts.length > 1;
    final decimalPart = hasDecimal ? parts[1] : '';

    if (rawInteger.isNotEmpty && int.tryParse(rawInteger) == null) {
      return oldValue;
    }

    if (decimalPart.length > 2) return oldValue;

    final formattedInteger = rawInteger.isEmpty
        ? ''
        : rawInteger.replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]} ',
          );

    final finalText = hasDecimal
        ? '$formattedInteger.$decimalPart'
        : formattedInteger;

    final oldCursor = newValue.selection.end.clamp(0, text.length);
    final nonSpaceBeforeCursor = text
        .substring(0, oldCursor)
        .replaceAll(' ', '')
        .length;

    int newCursor = 0;
    int counted = 0;
    for (int i = 0; i < finalText.length; i++) {
      if (counted == nonSpaceBeforeCursor) break;
      if (finalText[i] != ' ') counted++;
      newCursor++;
    }
    newCursor = newCursor.clamp(0, finalText.length);

    return TextEditingValue(
      text: finalText,
      selection: TextSelection.collapsed(offset: newCursor),
    );
  }
}