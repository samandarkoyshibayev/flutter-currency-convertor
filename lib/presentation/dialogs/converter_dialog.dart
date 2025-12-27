import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/no_transition_page_route.dart';
import '../../core/app_colors.dart';
import '../screens/currency_analytics/page/currency_analytics_page.dart';
import 'converter_input_widget.dart';
import 'converter_output_widget.dart';

class CurrencyConverterSheet extends StatefulWidget {
  final dynamic currency;
  final String selectedLanguage;
  final bool isDarkMode;

  const CurrencyConverterSheet({
    super.key,
    required this.currency,
    required this.selectedLanguage,
    required this.isDarkMode,
  });

  @override
  State<CurrencyConverterSheet> createState() =>
      _CurrencyConverterSheetState();
}

class _CurrencyConverterSheetState extends State<CurrencyConverterSheet> {
  final TextEditingController _inputController =
  TextEditingController(text: '1');
  final FocusNode _focusNode = FocusNode();

  late double _exchangeRate;
  bool _isBaseCurrencyUzs = false;
  String _convertedAmount = '0';

  late NumberFormat _moneyFormatter;

  @override
  void initState() {
    super.initState();

    _exchangeRate = double.tryParse(widget.currency.rate) ?? 0.0;

    _moneyFormatter = NumberFormat('#,##0.######', 'ru_RU');

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
    final input = double.tryParse(_inputController.text) ?? 0.0;

    if (_exchangeRate == 0.0) {
      setState(() => _convertedAmount = 'Error');
      return;
    }

    final result = !_isBaseCurrencyUzs
        ? input * _exchangeRate
        : input / _exchangeRate;

    setState(() {
      _convertedAmount = _moneyFormatter.format(result);
    });
  }

  void _swapCurrencies() {
    setState(() {
      _isBaseCurrencyUzs = !_isBaseCurrencyUzs;
      _calculateConversion();
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: widget.isDarkMode);
    final fromCcy = _isBaseCurrencyUzs ? 'UZS' : widget.currency.ccy;
    final toCcy = _isBaseCurrencyUzs ? widget.currency.ccy : 'UZS';

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        decoration: BoxDecoration(
          color: colors.cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  convertRateTitle(
                    widget.currency.ccy,
                    widget.selectedLanguage,
                  ),
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: colors.textSecondary,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ConverterInputWidget(
              controller: _inputController,
              focusNode: _focusNode,
              currencyCode: fromCcy,
              isDarkMode: widget.isDarkMode,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '1 ${widget.currency.ccy} = ${widget.currency.rate} UZS',
                    style: TextStyle(
                      color: colors.textSecondary,
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
                      color: colors.textSecondary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.swap_vert_rounded,
                      color: colors.primaryColor,
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
              selectedLanguage: widget.selectedLanguage,
              isDarkMode: widget.isDarkMode,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    NoTransitionPageRoute(
                      builder: (context) => CurrencyAnalyticsPage(
                        currency: widget.currency,
                        selectedLanguage: widget.selectedLanguage,
                        isDarkMode: widget.isDarkMode,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryColor,
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
                      _getAnalyticsButtonText(widget.selectedLanguage),
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

  static String convertRateTitle(String ccy, String lang) {
    switch (lang) {
      case 'UZ':
        return '$ccy kursini konvertatsiya qilish';
      case 'RU':
        return 'Конвертация курса $ccy';
      case 'EN':
      default:
        return 'Convert $ccy Rate';
    }
  }

  static String _getAnalyticsButtonText(String lang) {
    switch (lang) {
      case 'UZ':
        return 'Tahlilni ko\'rish';
      case 'RU':
        return 'Посмотреть аналитику';
      case 'EN':
      default:
        return 'View Analytics';
    }
  }
}