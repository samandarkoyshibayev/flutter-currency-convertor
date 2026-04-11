part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object?> get props => [];
}

final class HomeScreenInitial extends HomePageState {
  const HomeScreenInitial();
}

final class HomeScreenLoading extends HomePageState {
  const HomeScreenLoading();
}

final class HomeScreenLoaded extends HomePageState {
  final List<CurrencyEntity> currencies;

  const HomeScreenLoaded(this.currencies);

  @override
  List<Object?> get props => [currencies];
}

final class HomeScreenError extends HomePageState {
  final AppError error;
 
  const HomeScreenError(this.error);
 
  @override
  List<Object?> get props => [error.key, error.code];
}