part of 'main_page_bloc.dart';

@immutable
sealed class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

final class GetCurrenciesEvent extends MainPageEvent {
  const GetCurrenciesEvent();
}

final class GetCurrenciesByDateEvent extends MainPageEvent {
  final DateTime date;

  const GetCurrenciesByDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}