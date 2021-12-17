import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/src/widgets/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

      abstract class _MainSearch {
      late String hint;
        String result(int howMany);
        }
      class _EnMainSearch extends _MainSearch {
      /// Description: ""
    /// Example: "Search"
    @override
    final String hint = Intl.message('Search', name: 'hint', desc: '');
      /// Description: "null"
    /// Example: "zero: Not found any items, one: We found ${howMany} item, two: We found ${howMany} items, few: We found ${howMany} items, many: We found ${howMany} items, other: We found ${howMany} items"
    @override
    String result(int howMany) => Intl.plural(howMany,
      name: 'result',
      zero: 'Not found any items',
      one: 'We found ${howMany} item',
      two: 'We found ${howMany} items',
      few: 'We found ${howMany} items',
      many: 'We found ${howMany} items',
      other: 'We found ${howMany} items',
      desc: 'null',
    );
      }
      abstract class _Main {
      late String loading;
      late _MainSearch search;
      }
      class _EnMain extends _Main {
      /// Description: ""
    /// Example: "Loading..."
    @override
    final String loading = Intl.message('Loading...', name: 'loading', desc: '');
      @override
    final _MainSearch search = _EnMainSearch();
      }
      abstract class _Common {
      late String currency;
      late String percent;
      late String appTitle;
      }
      class _EnCommon extends _Common {
      /// Description: ""
    /// Example: "\$"
    @override
    final String currency = Intl.message('\$', name: 'currency', desc: '');
      /// Description: ""
    /// Example: "%"
    @override
    final String percent = Intl.message('%', name: 'percent', desc: '');
      /// Description: ""
    /// Example: "High Low"
    @override
    final String appTitle = Intl.message('High Low', name: 'appTitle', desc: '');
      }
      abstract class LocalizationMessages {
      late _Main main;
      late _Common common;
      }
      class _En extends LocalizationMessages {
      @override
    final _Main main = _EnMain();
      @override
    final _Common common = _EnCommon();
      }
      class _RuMainSearch extends _MainSearch {
      /// Description: ""
    /// Example: "Поиск"
    @override
    final String hint = Intl.message('Поиск', name: 'hint', desc: '');
      /// Description: "null"
    /// Example: "zero: Мы ничего не нашли, one: Мы нашли ${howMany} элемент, two: Мы нашли ${howMany} элемента, few: Мы нашли ${howMany} элемента, many: Мы нашли ${howMany} элементов, other: Мы нашли ${howMany} элементов"
    @override
    String result(int howMany) => Intl.plural(howMany,
      name: 'result',
      zero: 'Мы ничего не нашли',
      one: 'Мы нашли ${howMany} элемент',
      two: 'Мы нашли ${howMany} элемента',
      few: 'Мы нашли ${howMany} элемента',
      many: 'Мы нашли ${howMany} элементов',
      other: 'Мы нашли ${howMany} элементов',
      desc: 'null',
    );
      }
      class _RuMain extends _Main {
      /// Description: ""
    /// Example: "Загрузка..."
    @override
    final String loading = Intl.message('Загрузка...', name: 'loading', desc: '');
      @override
    final _MainSearch search = _RuMainSearch();
      }
      class _RuCommon extends _Common {
      /// Description: ""
    /// Example: "\$"
    @override
    final String currency = Intl.message('\$', name: 'currency', desc: '');
      /// Description: ""
    /// Example: "%"
    @override
    final String percent = Intl.message('%', name: 'percent', desc: '');
      /// Description: ""
    /// Example: "High Low"
    @override
    final String appTitle = Intl.message('High Low', name: 'appTitle', desc: '');
      }
      class _Ru extends LocalizationMessages {
      @override
    final _Main main = _RuMain();
      @override
    final _Common common = _RuCommon();
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
      'en': _En(),
        'ru': _Ru(),
      };

    }

    class Messages {
    static LocalizationMessages of(BuildContext context) => Localizations.of(context, LocalizationMessages);

    static LocalizationMessages get en => LocalizationDelegate()._languageMap['en']!;
    static LocalizationMessages get ru => LocalizationDelegate()._languageMap['ru']!;
    
    
    static LocalizationMessages? getLocale(String locale) {
      final List<String> localeData = locale.split('_');
      String languageCode = '';
      String countryCode = '';
      if (localeData.isEmpty) {
        throw Exception('Not found any locale info in string ${locale}');
      }
      languageCode = localeData[0];
      if (localeData.length > 1) {
        countryCode = localeData[1];
      }
      return LocalizationDelegate()._languageMap[languageCode];
    }
  }
  
  final List<LocalizationsDelegate> localizationsDelegates = [LocalizationDelegate(), ...GlobalMaterialLocalizations.delegates];

  const List<Locale> supportedLocales = [
const Locale('en'),
    const Locale('ru'),
    ];