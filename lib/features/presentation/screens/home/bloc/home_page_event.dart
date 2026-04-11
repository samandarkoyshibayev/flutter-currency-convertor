part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object?> get props => [];
}

final class GetCurrenciesEvent extends HomePageEvent {
  const GetCurrenciesEvent();
}

final class GetCurrenciesByDateEvent extends HomePageEvent {
  final DateTime date;

  const GetCurrenciesByDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}
