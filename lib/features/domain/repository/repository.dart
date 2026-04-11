import 'package:currency_converter/features/data/repository/repository_impl.dart';
import 'package:dartz/dartz.dart';

import '../entities/currency_entity.dart';

abstract class Repository {
  Future<Either<AppError, List<CurrencyEntity>>> getCurrencies();
  Future<Either<AppError, List<CurrencyEntity>>> getCurrenciesByDate(String date);
}