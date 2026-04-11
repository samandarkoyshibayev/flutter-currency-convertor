import 'dart:developer';

import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/features/data/source/remote/response/currency_response.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://cbu.uz/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveDataWhenStatusError: true,
    ),
  );

  Future<List<CurrencyResponse>> getCurrencies() async {
    return _get('uz/arkhiv-kursov-valyut/json/');
  }

  Future<List<CurrencyResponse>> getCurrenciesByDate(String date) async {
    return _get('uz/arkhiv-kursov-valyut/json/all/$date/');
  }

  Future<List<CurrencyResponse>> _get(String path) async {
    try {
      final response = await dio.get(path);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null || (data is List && data.isEmpty)) {}
        return (data as List)
            .map((json) => CurrencyResponse.fromJson(json))
            .toList();
      }

      throw ServerFailure(statusCode: response.statusCode);
    } on AppFailure {
      rethrow;
    } on DioException catch (e) {
      log('DioException [$path]: $e');
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout: throw const TimeoutFailure();
        case DioExceptionType.connectionError: throw const NetworkFailure();
        case DioExceptionType.badResponse: throw ServerFailure(statusCode: e.response?.statusCode);
        default:
          throw const NetworkFailure();
      }
    } catch (e) {
      log('Unexpected error [$path]: $e');
      throw const UnknownFailure();
    }
  }
}
