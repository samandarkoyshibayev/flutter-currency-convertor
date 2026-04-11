import 'package:currency_converter/core/di/injection.dart';
import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/localization/localization_cubit/localization_cubit.dart';
import 'package:currency_converter/core/theme/app_theme.dart';
import 'package:currency_converter/core/theme/theme_cubit/theme_cubit.dart';
import 'package:currency_converter/features/presentation/screens/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()..loadTheme()),
        BlocProvider(create: (_) => sl<LocalizationCubit>()..loadLocale()),
        //      BlocProvider(create: (_) => getIt<ConnectivityCubit>()..startMonitoring()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state.themeMode;
    final locale = context.watch<LocalizationCubit>().state.locale;
    return MaterialApp(
      title: 'Currency Converter',
      themeMode: themeMode,
      locale: locale,
      supportedLocales: Localization.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: const [
        Localization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
