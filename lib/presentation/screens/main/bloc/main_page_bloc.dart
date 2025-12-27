import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:currency_converter/domain/usecase/get_currencies_by_date_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/currency_entity.dart';
import '../../../../domain/usecase/get_currencies_usecase.dart';

part 'main_page_event.dart';

part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final GetCurrenciesUseCase getCurrenciesUseCase;
  final GetCurrenciesByDateUseCase getCurrenciesByDateUseCase;

  MainPageBloc(this.getCurrenciesUseCase, this.getCurrenciesByDateUseCase) : super(MainScreenInitial()) {
    on<GetCurrenciesEvent>(_onGetCurrencies);
    on<GetCurrenciesByDateEvent>(_onGetCurrenciesByDate);
  }

  Future<void> _onGetCurrencies(
    GetCurrenciesEvent event,
    Emitter<MainPageState> emit,
  ) async {
    emit(MainScreenLoading());
    final result = await getCurrenciesUseCase();
    result.fold(
      (error) => emit(MainScreenError(error)),
      (currencies) => emit(MainScreenLoaded(currencies)),
    );
  }

  Future<void> _onGetCurrenciesByDate(
    GetCurrenciesByDateEvent event,
    Emitter<MainPageState> emit,
  ) async {
    emit(MainScreenLoading());
    final formattedDate =
        "${event.date.year.toString().padLeft(4, '0')}-"
        "${event.date.month.toString().padLeft(2, '0')}-"
        "${event.date.day.toString().padLeft(2, '0')}";

    log(formattedDate);

    final result = await getCurrenciesByDateUseCase(formattedDate);
    result.fold(
      (error) => emit(MainScreenError(error)),
      (currencies) => emit(MainScreenLoaded(currencies)),
    );
  }
}
