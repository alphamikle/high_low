import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/src/widgets/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

      abstract class _MainSearch {
      late String hint;
        String result(int howMany);
        late String secret;
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
      /// Description: ""
    /// Example: "It seems - you found a secret (42)"
    @override
    final String secret = Intl.message('It seems - you found a secret (42)', name: 'secret', desc: '');
      }
      abstract class _MainErrors {
      late String loadingError;
      }
      class _EnMainErrors extends _MainErrors {
      /// Description: ""
    /// Example: "Cryptocurrency load failed"
    @override
    final String loadingError = Intl.message('Cryptocurrency load failed', name: 'loadingError', desc: '');
      }
      abstract class _Main {
      late String loading;
      late _MainSearch search;
      late _MainErrors errors;
      late String repeat;
      }
      class _EnMain extends _Main {
      /// Description: ""
    /// Example: "Loading..."
    @override
    final String loading = Intl.message('Loading...', name: 'loading', desc: '');
      @override
    final _MainSearch search = _EnMainSearch();
      @override
    final _MainErrors errors = _EnMainErrors();
      /// Description: ""
    /// Example: "Reload"
    @override
    final String repeat = Intl.message('Reload', name: 'repeat', desc: '');
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
    /// Example: "??????????"
    @override
    final String hint = Intl.message('??????????', name: 'hint', desc: '');
      /// Description: "null"
    /// Example: "zero: ???? ???????????? ???? ??????????, one: ???? ?????????? ${howMany} ??????????????, two: ???? ?????????? ${howMany} ????????????????, few: ???? ?????????? ${howMany} ????????????????, many: ???? ?????????? ${howMany} ??????????????????, other: ???? ?????????? ${howMany} ??????????????????"
    @override
    String result(int howMany) => Intl.plural(howMany,
      name: 'result',
      zero: '???? ???????????? ???? ??????????',
      one: '???? ?????????? ${howMany} ??????????????',
      two: '???? ?????????? ${howMany} ????????????????',
      few: '???? ?????????? ${howMany} ????????????????',
      many: '???? ?????????? ${howMany} ??????????????????',
      other: '???? ?????????? ${howMany} ??????????????????',
      desc: 'null',
    );
      /// Description: ""
    /// Example: "????????????, ???? ?????????? ????????????! (42)"
    @override
    final String secret = Intl.message('????????????, ???? ?????????? ????????????! (42)', name: 'secret', desc: '');
      }
      class _RuMainErrors extends _MainErrors {
      /// Description: ""
    /// Example: "???????????????? ???????????? ???? ??????????????"
    @override
    final String loadingError = Intl.message('???????????????? ???????????? ???? ??????????????', name: 'loadingError', desc: '');
      }
      class _RuMain extends _Main {
      /// Description: ""
    /// Example: "????????????????..."
    @override
    final String loading = Intl.message('????????????????...', name: 'loading', desc: '');
      @override
    final _MainSearch search = _RuMainSearch();
      @override
    final _MainErrors errors = _RuMainErrors();
      /// Description: ""
    /// Example: "??????????????????????????"
    @override
    final String repeat = Intl.message('??????????????????????????', name: 'repeat', desc: '');
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