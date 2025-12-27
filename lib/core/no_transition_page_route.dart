import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NoTransitionPageRoute<T> extends MaterialPageRoute<T> {
  NoTransitionPageRoute({required super.builder});

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return child;
  }
}

class MoneyInputFormatter extends TextInputFormatter {
  final NumberFormat formatter;

  MoneyInputFormatter(this.formatter);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (newValue.text.endsWith('.')) {
      return newValue;
    }

    final rawText = newValue.text.replaceAll(' ', '');

    final value = double.tryParse(rawText);
    if (value == null) {
      return oldValue;
    }

    final formatted = formatter.format(value);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}
