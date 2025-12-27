import 'package:currency_converter/data/source/remote/api_service/api_service.dart';
import 'package:currency_converter/domain/entities/currency_entity.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repository/repository.dart';
import '../mapper/mapper.dart';

class RepositoryImpl extends Repository{
  final ApiService api;

  RepositoryImpl(this.api);

  @override
  Future<Either<String, List<CurrencyEntity>>> getCurrencies() async {
    try {
      final result = await api.getCurrencies();
      final currencies = result.map((e) => e.toEntity()).toList();
      return Right(currencies);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CurrencyEntity>>> getCurrenciesByDate(String date) async {
    try {
      final result = await api.getCurrenciesByDate(date);
      final currencies = result.map((e) => e.toEntity()).toList();
      return Right(currencies);
    } catch (e) {
      return Left(e.toString());
    }
  }
}