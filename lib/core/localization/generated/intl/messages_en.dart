// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(ccy) => "Convert ${ccy} Rate";

  static String m1(code) => "Server error (${code}). Please try again later.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "analytics": MessageLookupByLibrary.simpleMessage("Analytics"),
    "average": MessageLookupByLibrary.simpleMessage("Average"),
    "bearish_desc": MessageLookupByLibrary.simpleMessage(
      "Currency is weakening",
    ),
    "bearish_title": MessageLookupByLibrary.simpleMessage("Bearish Trend"),
    "bullish_desc": MessageLookupByLibrary.simpleMessage(
      "Currency is strengthening",
    ),
    "bullish_title": MessageLookupByLibrary.simpleMessage("Bullish Trend"),
    "convert": MessageLookupByLibrary.simpleMessage("Convert"),
    "convertRateTitle": m0,
    "current_rate": MessageLookupByLibrary.simpleMessage("Current Rate"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "error_network": MessageLookupByLibrary.simpleMessage(
      "No internet connection. Please check your network settings.",
    ),
    "error_no_data": MessageLookupByLibrary.simpleMessage(
      "No currency data available for the selected date.",
    ),
    "error_server_400": MessageLookupByLibrary.simpleMessage(
      "Bad request. Please try again.",
    ),
    "error_server_401": MessageLookupByLibrary.simpleMessage(
      "Access denied. You are not authorized.",
    ),
    "error_server_404": MessageLookupByLibrary.simpleMessage(
      "The requested data was not found.",
    ),
    "error_server_500": MessageLookupByLibrary.simpleMessage(
      "The server is temporarily unavailable. Try again later.",
    ),
    "error_server_unknown": m1,
    "error_timeout": MessageLookupByLibrary.simpleMessage(
      "The request timed out. Please try again.",
    ),
    "error_title": MessageLookupByLibrary.simpleMessage(
      "Oops! Something went wrong",
    ),
    "error_unknown": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "high": MessageLookupByLibrary.simpleMessage("High"),
    "highest_rate": MessageLookupByLibrary.simpleMessage("Highest Rate"),
    "loading": MessageLookupByLibrary.simpleMessage(
      "Loading exchange rates...",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Low"),
    "market_insights": MessageLookupByLibrary.simpleMessage("Market Insights"),
    "most_popular": MessageLookupByLibrary.simpleMessage("Most Popular"),
    "name": MessageLookupByLibrary.simpleMessage("Name (A-Z)"),
    "no_results": MessageLookupByLibrary.simpleMessage("No currencies found"),
    "popular": MessageLookupByLibrary.simpleMessage("Popular"),
    "rate": MessageLookupByLibrary.simpleMessage("Rate"),
    "retry": MessageLookupByLibrary.simpleMessage("Try Again"),
    "russian": MessageLookupByLibrary.simpleMessage("Russian"),
    "search_hint": MessageLookupByLibrary.simpleMessage("Search currencies..."),
    "select_language": MessageLookupByLibrary.simpleMessage("Select Language"),
    "sort_by": MessageLookupByLibrary.simpleMessage("Sort By"),
    "stability_desc": MessageLookupByLibrary.simpleMessage(
      "Currency remains relatively stable",
    ),
    "stability_title": MessageLookupByLibrary.simpleMessage("Stability"),
    "statistics": MessageLookupByLibrary.simpleMessage("Statistics"),
    "title": MessageLookupByLibrary.simpleMessage("Exchange Rates"),
    "trending": MessageLookupByLibrary.simpleMessage("Trending"),
    "try_other": MessageLookupByLibrary.simpleMessage(
      "Try a different search term",
    ),
    "uzbek": MessageLookupByLibrary.simpleMessage("Uzbek"),
    "viewAnalytics": MessageLookupByLibrary.simpleMessage("View Analytics"),
    "volatility": MessageLookupByLibrary.simpleMessage("Volatility"),
  };
}
