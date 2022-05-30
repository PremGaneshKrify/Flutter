import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ar'),
    const Locale('hi'),
    const Locale('es'),
    const Locale('de'),
    const Locale('ne'),
  ];

  static String? getFlag(String code) {
    switch (code) {
      case 'ar':
        return "arabic";
      case "hi":
        return "hindi";
      case "es":
        return "es";
      case "de":
        return " detch";

      case "en":
        return "english";
      case "ne":
        return "nepal";
    }
    return null;
  }
}
