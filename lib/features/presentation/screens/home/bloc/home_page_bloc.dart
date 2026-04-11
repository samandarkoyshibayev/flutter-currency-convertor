import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:currency_converter/features/data/repository/repository_impl.dart';
import 'package:currency_converter/features/domain/usecase/get_currencies_by_date_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/currency_entity.dart';
import '../../../../domain/usecase/get_currencies_usecase.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetCurrenciesUseCase getCurrenciesUseCase;
  final GetCurrenciesByDateUseCase getCurrenciesByDateUseCase;

  HomePageBloc(this.getCurrenciesUseCase, this.getCurrenciesByDateUseCase)
    : super(HomeScreenInitial()) {
    on<GetCurrenciesEvent>(_onGetCurrencies);
    on<GetCurrenciesByDateEvent>(_onGetCurrenciesByDate);
  }

  Future<void> _onGetCurrencies(
    GetCurrenciesEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(HomeScreenLoading());
    final result = await getCurrenciesUseCase();
    result.fold(
      (error) => emit(HomeScreenError(error)),
      (currencies) => emit(HomeScreenLoaded(currencies)),
    );
  }

  Future<void> _onGetCurrenciesByDate(
    GetCurrenciesByDateEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(HomeScreenLoading());
    final formattedDate =
        "${event.date.year.toString().padLeft(4, '0')}-"
        "${event.date.month.toString().padLeft(2, '0')}-"
        "${event.date.day.toString().padLeft(2, '0')}";

    log(formattedDate);

    final result = await getCurrenciesByDateUseCase(formattedDate);
    result.fold(
      (error) => emit(HomeScreenError(error)),
      (currencies) => emit(HomeScreenLoaded(currencies)),
    );
  }
}
