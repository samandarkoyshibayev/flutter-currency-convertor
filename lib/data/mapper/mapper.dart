import '../../domain/entities/currency_entity.dart';
import '../source/remote/response/currency_response.dart';

extension CurrencyResponseMapper on CurrencyResponse {
  CurrencyEntity toEntity() {
    return CurrencyEntity(
      id: id,
      code: code,
      ccy: ccy,
      ccyNmEN: ccyNmEn,
      ccyNmRu: ccyNmRu,
      ccyNmUz: ccyNmUz,
      ccyNmUzc: ccyNmUzc,
      nominal: nominal,
      rate: rate,
      diff: diff,
      date: date,
    );
  }
}
