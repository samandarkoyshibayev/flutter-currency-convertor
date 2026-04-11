import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/no_transition_page_route.dart';
import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:currency_converter/features/presentation/screens/currency_analytics/page/currency_analytics_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'converter_input_widget.dart';
import 'converter_output_widget.dart';

class CurrencyConverterSheet extends StatefulWidget {
  final Object? currency;

  const CurrencyConverterSheet({super.key, required this.currency});

  @override
  State<CurrencyConverterSheet> createState() => _CurrencyConverterSheetState();
}

class _CurrencyConverterSheetState extends State<CurrencyConverterSheet> {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late double _exchangeRate;
  bool _isBaseCurrencyUzs = false;
  String _convertedAmount = '0';
  static final _outputFormatter = NumberFormat('#,##0.######', 'en_US');

  @override
  void initState() {
    super.initState();
    final currencyModel = widget.currency as dynamic;
    _exchangeRate = double.tryParse(currencyModel.rate) ?? 0.0;
    _inputController.text = '1';
    _calculateConversion();

    _inputController.addListener(_calculateConversion);
  }

  @override
  void dispose() {
    _inputController.removeListener(_calculateConversion);
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _calculateConversion() {
    final rawText = _inputController.text.replaceAll(' ', '').trim();
    final input = double.tryParse(rawText) ?? 0.0;

    if (_exchangeRate == 0.0) {
      setState(() => _convertedAmount = 'Error');
      return;
    }

    final result = !_isBaseCurrencyUzs
        ? input * _exchangeRate
        : input / _exchangeRate;

    setState(() {
      _convertedAmount = _outputFormatter.format(result).replaceAll(',', ' ');
    });
  }

  void _swapCurrencies() {
    _isBaseCurrencyUzs = !_isBaseCurrencyUzs;
    _calculateConversion();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final currencyModel = widget.currency as dynamic;

    final fromCcy = _isBaseCurrencyUzs ? 'UZS' : currencyModel.ccy as String;
    final toCcy = _isBaseCurrencyUzs ? currencyModel.ccy as String : 'UZS';

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        decoration: BoxDecoration(
          color: context.colors.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.convertRateTitle(currencyModel.ccy as String),
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: context.colors.textSecondary,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ConverterInputWidget(
              controller: _inputController,
              focusNode: _focusNode,
              currencyCode: fromCcy,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '1 ${currencyModel.ccy} = ${currencyModel.rate} UZS',
                    style: TextStyle(
                      color: context.colors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _swapCurrencies,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.colors.textSecondary.withValues(
                        alpha: 0.1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.swap_vert_rounded,
                      color: context.colors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ConverterOutputWidget(
              convertedAmount: _convertedAmount,
              currencyCode: toCcy,
              fromCurrency: fromCcy,
              exchangeRate: _exchangeRate,
              isBaseCurrencyUzs: _isBaseCurrencyUzs,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.pop(context),
                  Navigator.push(
                    context,
                    NoTransitionPageRoute(
                      builder: (context) =>
                          CurrencyAnalyticsPage(currency: widget.currency),
                    ),
                  ),
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.analytics_rounded, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      context.l10n.viewAnalytics,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
