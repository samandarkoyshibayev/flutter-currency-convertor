part of 'main_page_bloc.dart';

@immutable
sealed class MainPageState extends Equatable {
  const MainPageState();

  @override
  List<Object?> get props => [];
}

final class MainScreenInitial extends MainPageState {
  const MainScreenInitial();
}

final class MainScreenLoading extends MainPageState {
  const MainScreenLoading();
}

final class MainScreenLoaded extends MainPageState {
  final List<CurrencyEntity> currencies;

  const MainScreenLoaded(this.currencies);

  @override
  List<Object?> get props => [currencies];
}

final class MainScreenError extends MainPageState {
  final String message;

  const MainScreenError(this.message);

  @override
  List<Object?> get props => [message];
}