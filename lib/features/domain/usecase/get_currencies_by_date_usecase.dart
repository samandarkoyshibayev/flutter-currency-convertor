
import 'package:currency_converter/features/data/repository/repository_impl.dart';
import 'package:dartz/dartz.dart';

import '../entities/currency_entity.dart';
import '../repository/repository.dart';

class GetCurrenciesByDateUseCase {
  final Repository repository;

  GetCurrenciesByDateUseCase(this.repository);

  Future<Either<AppError, List<CurrencyEntity>>> call(String date) {
    return repository.getCurrenciesByDate(date);
  }
}