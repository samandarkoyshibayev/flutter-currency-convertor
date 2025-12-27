import 'package:currency_converter/data/repository/repository_impl.dart';
import 'package:currency_converter/data/source/remote/api_service/api_service.dart';
import 'package:currency_converter/domain/repository/repository.dart';
import 'package:currency_converter/domain/usecase/get_currencies_by_date_usecase.dart';
import 'package:currency_converter/domain/usecase/get_currencies_usecase.dart';
import 'package:get_it/get_it.dart';

import '../presentation/screens/main/bloc/main_page_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(sl()));
  sl.registerLazySingleton<GetCurrenciesUseCase>(() => GetCurrenciesUseCase(sl()));
  sl.registerLazySingleton<GetCurrenciesByDateUseCase>(() => GetCurrenciesByDateUseCase(sl()));
  sl.registerFactory<MainPageBloc>(() => MainPageBloc(
    sl<GetCurrenciesUseCase>(),
    sl<GetCurrenciesByDateUseCase>(),
  ));
}