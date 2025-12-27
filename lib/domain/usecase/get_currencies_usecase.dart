import 'package:currency_converter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/currency_entity.dart';

class GetCurrenciesUseCase {
  final Repository repository;

  GetCurrenciesUseCase(this.repository);

  Future<Either<String, List<CurrencyEntity>>> call() {
    return repository.getCurrencies();
  }
}