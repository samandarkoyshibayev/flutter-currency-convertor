import 'dart:developer';

import 'package:currency_converter/data/source/remote/response/currency_response.dart';
import 'package:dio/dio.dart';

class ApiService {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://cbu.uz/',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
      receiveDataWhenStatusError: true,
    ),
  );

  Future<List<CurrencyResponse>> getCurrencies() async {
    try {
      final response = await dio.get('uz/arkhiv-kursov-valyut/json/');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CurrencyResponse.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load currencies: Status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('Network Error occurred: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<CurrencyResponse>> getCurrenciesByDate(String date) async {
    try {
      final response = await dio.get('uz/arkhiv-kursov-valyut/json/all/$date/');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CurrencyResponse.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load currencies: Status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('Network Error occurred: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
