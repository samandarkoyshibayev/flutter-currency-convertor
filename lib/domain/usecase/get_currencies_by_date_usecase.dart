
import 'package:dartz/dartz.dart';

import '../entities/currency_entity.dart';
import '../repository/repository.dart';

class GetCurrenciesByDateUseCase {
  final Repository repository;

  GetCurrenciesByDateUseCase(this.repository);

  Future<Either<String, List<CurrencyEntity>>> call(String date) {
    return repository.getCurrenciesByDate(date);
  }
}