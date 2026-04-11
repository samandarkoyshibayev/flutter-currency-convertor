// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(ccy) => "Конвертация курса ${ccy}";

  static String m1(code) => "Ошибка сервера (${code}). Попробуйте позже.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "all": MessageLookupByLibrary.simpleMessage("Все"),
    "analytics": MessageLookupByLibrary.simpleMessage("Аналитика"),
    "average": MessageLookupByLibrary.simpleMessage("Средний"),
    "bearish_desc": MessageLookupByLibrary.simpleMessage("Валюта ослабевает"),
    "bearish_title": MessageLookupByLibrary.simpleMessage("Медвежий тренд"),
    "bullish_desc": MessageLookupByLibrary.simpleMessage("Валюта укрепляется"),
    "bullish_title": MessageLookupByLibrary.simpleMessage("Бычий тренд"),
    "convert": MessageLookupByLibrary.simpleMessage("Конвертировать"),
    "convertRateTitle": m0,
    "current_rate": MessageLookupByLibrary.simpleMessage("Текущий курс"),
    "error_network": MessageLookupByLibrary.simpleMessage(
      "Нет подключения к интернету. Проверьте настройки сети.",
    ),
    "error_no_data": MessageLookupByLibrary.simpleMessage(
      "Данные о валютах за выбранную дату недоступны.",
    ),
    "error_server_400": MessageLookupByLibrary.simpleMessage(
      "Неверный запрос. Пожалуйста, попробуйте снова.",
    ),
    "error_server_401": MessageLookupByLibrary.simpleMessage(
      "Доступ запрещён. У вас нет прав.",
    ),
    "error_server_404": MessageLookupByLibrary.simpleMessage(
      "Запрашиваемые данные не найдены.",
    ),
    "error_server_500": MessageLookupByLibrary.simpleMessage(
      "Сервер временно недоступен. Попробуйте позже.",
    ),
    "error_server_unknown": m1,
    "error_timeout": MessageLookupByLibrary.simpleMessage(
      "Время ожидания истекло. Пожалуйста, попробуйте снова.",
    ),
    "error_title": MessageLookupByLibrary.simpleMessage("Что-то пошло не так"),
    "error_unknown": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так. Пожалуйста, попробуйте снова.",
    ),
    "high": MessageLookupByLibrary.simpleMessage("Макс."),
    "highest_rate": MessageLookupByLibrary.simpleMessage("Самый высокий курс"),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка курсов валют..."),
    "low": MessageLookupByLibrary.simpleMessage("Мин."),
    "market_insights": MessageLookupByLibrary.simpleMessage("Обзор рынка"),
    "most_popular": MessageLookupByLibrary.simpleMessage("Самые популярные"),
    "name": MessageLookupByLibrary.simpleMessage("Название (A–Z)"),
    "no_results": MessageLookupByLibrary.simpleMessage("Валюты не найдены"),
    "popular": MessageLookupByLibrary.simpleMessage("Популярные"),
    "rate": MessageLookupByLibrary.simpleMessage("Курс"),
    "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "search_hint": MessageLookupByLibrary.simpleMessage("Поиск валют..."),
    "select_language": MessageLookupByLibrary.simpleMessage("Выберите язык"),
    "sort_by": MessageLookupByLibrary.simpleMessage("Сортировать"),
    "stability_desc": MessageLookupByLibrary.simpleMessage(
      "Валюта относительно стабильна",
    ),
    "stability_title": MessageLookupByLibrary.simpleMessage("Стабильность"),
    "statistics": MessageLookupByLibrary.simpleMessage("Статистика"),
    "title": MessageLookupByLibrary.simpleMessage("Курсы валют"),
    "trending": MessageLookupByLibrary.simpleMessage("В тренде"),
    "try_other": MessageLookupByLibrary.simpleMessage(
      "Попробуйте другой запрос",
    ),
    "viewAnalytics": MessageLookupByLibrary.simpleMessage(
      "Посмотреть аналитику",
    ),
    "volatility": MessageLookupByLibrary.simpleMessage("Волатильность"),
  };
}
