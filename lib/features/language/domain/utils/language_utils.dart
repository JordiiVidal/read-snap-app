class LanguageUtils {
  static String getLanguageName(String code) {
    final languages = {
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
      'it': 'Italian',
      'pt': 'Portuguese',
      'ja': 'Japanese',
      'zh': 'Chinese',
      'ko': 'Korean',
      'ru': 'Russian',
      'ar': 'Arabic',
      'hi': 'Hindi',
      'nl': 'Dutch',
      'sv': 'Swedish',
      'no': 'Norwegian',
      'da': 'Danish',
      'fi': 'Finnish',
      'pl': 'Polish',
      'tr': 'Turkish',
      'el': 'Greek',
      'he': 'Hebrew',
      'id': 'Indonesian',
      'th': 'Thai',
      'vi': 'Vietnamese',
      'cs': 'Czech',
      'hu': 'Hungarian',
      'ro': 'Romanian',
      'uk': 'Ukrainian',
    };

    return languages[code.toLowerCase()] ?? code.toUpperCase();
  }

  static String getLanguageFlag(String code) {
    final flags = {
      'en': '🇬🇧',
      'es': '🇪🇸',
      'fr': '🇫🇷',
      'de': '🇩🇪',
      'it': '🇮🇹',
      'pt': '🇵🇹',
      'ja': '🇯🇵',
      'zh': '🇨🇳',
      'ko': '🇰🇷',
      'ru': '🇷🇺',
      'ar': '🇸🇦',
      'hi': '🇮🇳',
      'nl': '🇳🇱',
      'sv': '🇸🇪',
      'no': '🇳🇴',
      'da': '🇩🇰',
      'fi': '🇫🇮',
      'pl': '🇵🇱',
      'tr': '🇹🇷',
      'el': '🇬🇷',
      'he': '🇮🇱',
      'id': '🇮🇩',
      'th': '🇹🇭',
      'vi': '🇻🇳',
      'cs': '🇨🇿',
      'hu': '🇭🇺',
      'ro': '🇷🇴',
      'uk': '🇺🇦',
    };

    return flags[code.toLowerCase()] ?? '🌐';
  }

  LanguageUtils._();
}
