import 'package:currency_converter/core/localization/localization_cubit/localization_cubit.dart';
import 'package:currency_converter/core/storage/local/hive_storage.dart';
import 'package:currency_converter/core/storage/local/local_storage.dart';
import 'package:currency_converter/core/storage/secure/flutter_secure_storage_impl.dart';
import 'package:currency_converter/core/storage/secure/secure_storage.dart';
import 'package:currency_converter/core/storage/storage_service.dart';
import 'package:currency_converter/core/theme/theme_cubit/theme_cubit.dart';
import 'package:currency_converter/features/data/repository/repository_impl.dart';
import 'package:currency_converter/features/data/source/remote/api_service/api_service.dart';
import 'package:currency_converter/features/domain/repository/repository.dart';
import 'package:currency_converter/features/domain/usecase/get_currencies_by_date_usecase.dart';
import 'package:currency_converter/features/domain/usecase/get_currencies_usecase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../features/presentation/screens/home/bloc/home_page_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _registerStorage();
  _registerCubits();
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(sl()));
  sl.registerLazySingleton<GetCurrenciesUseCase>(
    () => GetCurrenciesUseCase(sl()),
  );
  sl.registerLazySingleton<GetCurrenciesByDateUseCase>(
    () => GetCurrenciesByDateUseCase(sl()),
  );
  sl.registerFactory<HomePageBloc>(
    () => HomePageBloc(
      sl<GetCurrenciesUseCase>(),
      sl<GetCurrenciesByDateUseCase>(),
    ),
  );
}

void _registerCubits() {
  // sl.registerFactory<ThemeCubit>(() => ThemeCubit(getIt<StorageService>()));

  sl.registerFactory<LocalizationCubit>(
    () => LocalizationCubit(sl<LocalStorage>()),
  );

  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl<LocalStorage>()));
}

Future<void> _registerStorage() async {
  final settingsBox = await Hive.openBox('settings_box');

  sl.registerSingleton<Box>(settingsBox, instanceName: 'settingsBox');

  sl.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(
      // ignore: deprecated_member_use
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  sl.registerLazySingleton<LocalStorage>(
    () => HiveStorage(sl<Box>(instanceName: 'settingsBox')),
  );

  sl.registerLazySingleton<SecureStorage>(
    () => FlutterSecureStorageImpl(sl<FlutterSecureStorage>()),
  );

  sl.registerSingleton<StorageService>(
    StorageService(sl<LocalStorage>(), sl<SecureStorage>()),
  );
}
