import 'package:currency_converter/features/data/repository/repository_impl.dart';
import 'package:currency_converter/features/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/currency_entity.dart';

class GetCurrenciesUseCase {
  final Repository repository;

  GetCurrenciesUseCase(this.repository);

  Future<Either<AppError, List<CurrencyEntity>>> call() {
    return repository.getCurrencies();
  }
}