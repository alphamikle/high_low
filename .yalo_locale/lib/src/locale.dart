import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

abstract class MainSearch {
  T getContent<T>(String key);
  String get hint;
  String result(int howMany, {int? precision});
  String get secret;
}

class EnMainSearch extends MainSearch {
  Map<String, Object?> get _contentMap => {
        'hint': hint,
        'result': result,
        'secret': secret,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  /// Description: ""
  /// Example: "Search"
  @override
  final String hint = Intl.message(
    '''Search''',
    name: 'hint',
    desc: '',
  );

  /// Description: ""
  /// Example: "zero: Not found any items, one: We found $howMany item, two: We found $howMany items, few: null, many: null, other: We found $howMany items"
  @override
  String result(int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: '''result''',
        zero: '''Not found any items''',
        one: '''We found $howMany item''',
        two: '''We found $howMany items''',
        few: '''We found $howMany items''',
        many: '''We found $howMany items''',
        other: '''We found $howMany items''',
        desc: '''''',
        precision: precision,
      );

  /// Description: ""
  /// Example: "It seems - you found a secret (42)"
  @override
  final String secret = Intl.message(
    '''It seems - you found a secret (42)''',
    name: 'secret',
    desc: '',
  );
}

abstract class MainErrors {
  T getContent<T>(String key);
  String get loadingError;
}

class EnMainErrors extends MainErrors {
  Map<String, Object?> get _contentMap => {
        'loadingError': loadingError,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  /// Description: ""
  /// Example: "Cryptocurrency load failed"
  @override
  final String loadingError = Intl.message(
    '''Cryptocurrency load failed''',
    name: 'loadingError',
    desc: '',
  );
}

abstract class Main {
  T getContent<T>(String key);
  String get loading;
  MainSearch get search;
  MainErrors get errors;
  String get repeat;
}

class EnMain extends Main {
  Map<String, Object?> get _contentMap => {
        'loading': loading,
        'search': search,
        'errors': errors,
        'repeat': repeat,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  /// Description: ""
  /// Example: "Loading..."
  @override
  final String loading = Intl.message(
    '''Loading...''',
    name: 'loading',
    desc: '',
  );
  @override
  final MainSearch search = EnMainSearch();
  @override
  final MainErrors errors = EnMainErrors();

  /// Description: ""
  /// Example: "Reload"
  @override
  final String repeat = Intl.message(
    '''Reload''',
    name: 'repeat',
    desc: '',
  );
}

abstract class Common {
  T getContent<T>(String key);
  String get currency;
  String get percent;
  String get appTitle;
}

class EnCommon extends Common {
  Map<String, Object?> get _contentMap => {
        'currency': currency,
        'percent': percent,
        'appTitle': appTitle,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  /// Description: ""
  /// Example: "\$"
  @override
  final String currency = Intl.message(
    '''\$''',
    name: 'currency',
    desc: '',
  );

  /// Description: ""
  /// Example: "%"
  @override
  final String percent = Intl.message(
    '''%''',
    name: 'percent',
    desc: '',
  );

  /// Description: ""
  /// Example: "High Low"
  @override
  final String appTitle = Intl.message(
    '''High Low''',
    name: 'appTitle',
    desc: '',
  );
}

abstract class LocalizationMessages {
  T getContent<T>(String key);
  Main get main;
  Common get common;
}

class En extends LocalizationMessages {
  Map<String, Object?> get _contentMap => {
        'main': main,
        'common': common,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  @override
  final Main main = EnMain();
  @override
  final Common common = EnCommon();
}

class RuMainSearch extends MainSearch {
  Map<String, Object?> get _contentMap => {
        'hint': hint,
        'result': result,
        'secret': secret,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  /// Description: ""
  /// Example: "Поиск"
  @override
  final String hint = Intl.message(
    '''Поиск''',
    name: 'hint',
    desc: '',
  );

  /// Description: ""
  /// Example: "zero: Мы ничего не нашли, one: Мы нашли $howMany элемент, two: Мы нашли $howMany элемента, few: null, many: null, other: Мы нашли $howMany элементов"
  @override
  String result(int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: '''result''',
        zero: '''Мы ничего не нашли''',
        one: '''Мы нашли $howMany элемент''',
        two: '''Мы нашли $howMany элемента''',
        few: '''Мы нашли $howMany элементов''',
        many: '''Мы нашли $howMany элементов''',
        other: '''Мы нашли $howMany элементов''',
        desc: '''''',
        precision: precision,
      );

  /// Description: ""
  /// Example: "Похоже, ты нашел секрет! (42)"
  @override
  final String secret = Intl.message(
    '''Похоже, ты нашел секрет! (42)''',
    name: 'secret',
    desc: '',
  );
}

class RuMainErrors extends MainErrors {
  Map<String, Object?> get _contentMap => {
        'loadingError': loadingError,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  /// Description: ""
  /// Example: "Загрузка крипты не удалась"
  @override
  final String loadingError = Intl.message(
    '''Загрузка крипты не удалась''',
    name: 'loadingError',
    desc: '',
  );
}

class RuMain extends Main {
  Map<String, Object?> get _contentMap => {
        'loading': loading,
        'search': search,
        'errors': errors,
        'repeat': repeat,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  /// Description: ""
  /// Example: "Загрузка..."
  @override
  final String loading = Intl.message(
    '''Загрузка...''',
    name: 'loading',
    desc: '',
  );
  @override
  final MainSearch search = RuMainSearch();
  @override
  final MainErrors errors = RuMainErrors();

  /// Description: ""
  /// Example: "Перезагрузить"
  @override
  final String repeat = Intl.message(
    '''Перезагрузить''',
    name: 'repeat',
    desc: '',
  );
}

class RuCommon extends Common {
  Map<String, Object?> get _contentMap => {
        'currency': currency,
        'percent': percent,
        'appTitle': appTitle,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  /// Description: ""
  /// Example: "\$"
  @override
  final String currency = Intl.message(
    '''\$''',
    name: 'currency',
    desc: '',
  );

  /// Description: ""
  /// Example: "%"
  @override
  final String percent = Intl.message(
    '''%''',
    name: 'percent',
    desc: '',
  );

  /// Description: ""
  /// Example: "High Low"
  @override
  final String appTitle = Intl.message(
    '''High Low''',
    name: 'appTitle',
    desc: '',
  );
}

class Ru extends LocalizationMessages {
  Map<String, Object?> get _contentMap => {
        'main': main,
        'common': common,
      };

  @override
  T getContent<T>(String key) {
    final Object? content = _contentMap[key];
    if (content is T) {
      return content;
    }
    throw Exception('Not found correct content of type "$T" by key "$key"');
  }

  @override
  final Main main = RuMain();
  @override
  final Common common = RuCommon();
}

class LocalizationDelegate extends LocalizationsDelegate<LocalizationMessages> {
  @override
  bool isSupported(Locale locale) => _languageMap.keys.contains(locale.languageCode);

  @override
  Future<LocalizationMessages> load(Locale locale) async {
    Intl.defaultLocale = locale.countryCode == null ? locale.languageCode : locale.toString();
    return _languageMap[locale.languageCode]!;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationMessages> old) => false;

  final Map<String, LocalizationMessages> _languageMap = {
    'en': En(),
    'ru': Ru(),
  };
}

class Messages {
  static LocalizationMessages of(BuildContext context) => Localizations.of(context, LocalizationMessages);

  static LocalizationMessages get en => LocalizationDelegate()._languageMap['en']!;
  static LocalizationMessages get ru => LocalizationDelegate()._languageMap['ru']!;
}

final List<LocalizationsDelegate> localizationsDelegates = [
  LocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates
];

const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('ru'),
];
