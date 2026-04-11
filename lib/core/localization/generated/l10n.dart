// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Exchange Rates`
  String get title {
    return Intl.message('Exchange Rates', name: 'title', desc: '', args: []);
  }

  /// `Search currencies...`
  String get search_hint {
    return Intl.message(
      'Search currencies...',
      name: 'search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Loading exchange rates...`
  String get loading {
    return Intl.message(
      'Loading exchange rates...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong`
  String get error_title {
    return Intl.message(
      'Oops! Something went wrong',
      name: 'error_title',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get retry {
    return Intl.message('Try Again', name: 'retry', desc: '', args: []);
  }

  /// `No currencies found`
  String get no_results {
    return Intl.message(
      'No currencies found',
      name: 'no_results',
      desc: '',
      args: [],
    );
  }

  /// `Try a different search term`
  String get try_other {
    return Intl.message(
      'Try a different search term',
      name: 'try_other',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message('Popular', name: 'popular', desc: '', args: []);
  }

  /// `Trending`
  String get trending {
    return Intl.message('Trending', name: 'trending', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Convert`
  String get convert {
    return Intl.message('Convert', name: 'convert', desc: '', args: []);
  }

  /// `Rate`
  String get rate {
    return Intl.message('Rate', name: 'rate', desc: '', args: []);
  }

  /// `Select Language`
  String get select_language {
    return Intl.message(
      'Select Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sort_by {
    return Intl.message('Sort By', name: 'sort_by', desc: '', args: []);
  }

  /// `Name (A-Z)`
  String get name {
    return Intl.message('Name (A-Z)', name: 'name', desc: '', args: []);
  }

  /// `Most Popular`
  String get most_popular {
    return Intl.message(
      'Most Popular',
      name: 'most_popular',
      desc: '',
      args: [],
    );
  }

  /// `Highest Rate`
  String get highest_rate {
    return Intl.message(
      'Highest Rate',
      name: 'highest_rate',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Uzbek`
  String get uzbek {
    return Intl.message('Uzbek', name: 'uzbek', desc: '', args: []);
  }

  /// `Russian`
  String get russian {
    return Intl.message('Russian', name: 'russian', desc: '', args: []);
  }

  /// `Analytics`
  String get analytics {
    return Intl.message('Analytics', name: 'analytics', desc: '', args: []);
  }

  /// `Current Rate`
  String get current_rate {
    return Intl.message(
      'Current Rate',
      name: 'current_rate',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message('Statistics', name: 'statistics', desc: '', args: []);
  }

  /// `High`
  String get high {
    return Intl.message('High', name: 'high', desc: '', args: []);
  }

  /// `Low`
  String get low {
    return Intl.message('Low', name: 'low', desc: '', args: []);
  }

  /// `Average`
  String get average {
    return Intl.message('Average', name: 'average', desc: '', args: []);
  }

  /// `Volatility`
  String get volatility {
    return Intl.message('Volatility', name: 'volatility', desc: '', args: []);
  }

  /// `Market Insights`
  String get market_insights {
    return Intl.message(
      'Market Insights',
      name: 'market_insights',
      desc: '',
      args: [],
    );
  }

  /// `Bullish Trend`
  String get bullish_title {
    return Intl.message(
      'Bullish Trend',
      name: 'bullish_title',
      desc: '',
      args: [],
    );
  }

  /// `Currency is strengthening`
  String get bullish_desc {
    return Intl.message(
      'Currency is strengthening',
      name: 'bullish_desc',
      desc: '',
      args: [],
    );
  }

  /// `Bearish Trend`
  String get bearish_title {
    return Intl.message(
      'Bearish Trend',
      name: 'bearish_title',
      desc: '',
      args: [],
    );
  }

  /// `Currency is weakening`
  String get bearish_desc {
    return Intl.message(
      'Currency is weakening',
      name: 'bearish_desc',
      desc: '',
      args: [],
    );
  }

  /// `Stability`
  String get stability_title {
    return Intl.message(
      'Stability',
      name: 'stability_title',
      desc: '',
      args: [],
    );
  }

  /// `Currency remains relatively stable`
  String get stability_desc {
    return Intl.message(
      'Currency remains relatively stable',
      name: 'stability_desc',
      desc: '',
      args: [],
    );
  }

  /// `Convert {ccy} Rate`
  String convertRateTitle(String ccy) {
    return Intl.message(
      'Convert $ccy Rate',
      name: 'convertRateTitle',
      desc: '',
      args: [ccy],
    );
  }

  /// `View Analytics`
  String get viewAnalytics {
    return Intl.message(
      'View Analytics',
      name: 'viewAnalytics',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Please check your network settings.`
  String get error_network {
    return Intl.message(
      'No internet connection. Please check your network settings.',
      name: 'error_network',
      desc: '',
      args: [],
    );
  }

  /// `The request timed out. Please try again.`
  String get error_timeout {
    return Intl.message(
      'The request timed out. Please try again.',
      name: 'error_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Bad request. Please try again.`
  String get error_server_400 {
    return Intl.message(
      'Bad request. Please try again.',
      name: 'error_server_400',
      desc: '',
      args: [],
    );
  }

  /// `Access denied. You are not authorized.`
  String get error_server_401 {
    return Intl.message(
      'Access denied. You are not authorized.',
      name: 'error_server_401',
      desc: '',
      args: [],
    );
  }

  /// `The requested data was not found.`
  String get error_server_404 {
    return Intl.message(
      'The requested data was not found.',
      name: 'error_server_404',
      desc: '',
      args: [],
    );
  }

  /// `The server is temporarily unavailable. Try again later.`
  String get error_server_500 {
    return Intl.message(
      'The server is temporarily unavailable. Try again later.',
      name: 'error_server_500',
      desc: '',
      args: [],
    );
  }

  /// `Server error ({code}). Please try again later.`
  String error_server_unknown(Object code) {
    return Intl.message(
      'Server error ($code). Please try again later.',
      name: 'error_server_unknown',
      desc: '',
      args: [code],
    );
  }

  /// `No currency data available for the selected date.`
  String get error_no_data {
    return Intl.message(
      'No currency data available for the selected date.',
      name: 'error_no_data',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get error_unknown {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'error_unknown',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
