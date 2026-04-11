import 'dart:developer';

import 'package:currency_converter/core/error/error_type.dart';
import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/features/data/mapper/mapper.dart';
import 'package:currency_converter/features/data/source/remote/api_service/api_service.dart';
import 'package:currency_converter/features/data/source/remote/response/currency_response.dart';
import 'package:currency_converter/features/domain/entities/currency_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final ApiService api;

  RepositoryImpl(this.api);

  @override
  Future<Either<AppError, List<CurrencyEntity>>> getCurrencies() =>
      _safeCall(() => api.getCurrencies());

  @override
  Future<Either<AppError, List<CurrencyEntity>>> getCurrenciesByDate(
    String date,
  ) => _safeCall(() => api.getCurrenciesByDate(date));

  Future<Either<AppError, List<CurrencyEntity>>> _safeCall(
    Future<List<CurrencyResponse>> Function() call,
  ) async {
    try {
      final result = await call();
      final entities = result.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on AppFailure catch (f) {
      log('AppFailure: ${f.runtimeType}');
      return Left(_toAppError(f));
    } catch (e) {
      log('Unexpected repository error: $e');
      return Left(AppError(key: ErrorKey.unknown));
    }
  }

  AppError _toAppError(AppFailure failure) {
    return switch (failure) {
      NetworkFailure() => AppError(key: ErrorKey.network),
      TimeoutFailure() => AppError(key: ErrorKey.timeout),
      NoDataFailure() => AppError(key: ErrorKey.noData),
      ServerFailure(statusCode: final code) => switch (code) {
        400 => AppError(key: ErrorKey.server400),
        401 || 403 => AppError(key: ErrorKey.server401),
        404 => AppError(key: ErrorKey.server404),
        500 || 502 || 503 => AppError(key: ErrorKey.server500),
        _ => AppError(
          key: ErrorKey.serverUnknown,
          code: code?.toString() ?? '?',
        ),
      },
      _ => AppError(key: ErrorKey.unknown),
    };
  }
}

class AppError {
  final ErrorKey key;
  final String? code;

  const AppError({required this.key, this.code});
}
