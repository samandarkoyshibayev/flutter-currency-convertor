import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final int id;
  final String code;
  final String ccy;
  final String ccyNmEN;
  final String ccyNmRu;
  final String ccyNmUz;
  final String ccyNmUzc;
  final String nominal;
  final String rate;
  final String diff;
  final String date;

  const CurrencyEntity({
    required this.id,
    required this.code,
    required this.ccy,
    required this.ccyNmEN,
    required this.nominal,
    required this.rate,
    required this.diff,
    required this.date,
    required this.ccyNmRu,
    required this.ccyNmUz,
    required this.ccyNmUzc,
  });

  @override
  List<Object?> get props => [
    id, code, ccy, ccyNmEN, ccyNmRu, ccyNmUz,
    ccyNmUzc, nominal, rate, diff, date,
  ];
}