import 'package:dartz/dartz.dart';

import '../entities/currency_entity.dart';

abstract class Repository {
  Future<Either<String, List<CurrencyEntity>>> getCurrencies();
  Future<Either<String, List<CurrencyEntity>>> getCurrenciesByDate(String date);
}