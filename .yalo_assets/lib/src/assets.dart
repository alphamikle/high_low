  import 'package:flutter/services.dart';
  enum Asset {
      _stub,
    enIntl,
ruIntl,

}

final Map<Asset, String> _assetEnumMap = {
Asset.enIntl: 'assets/i18/en_intl.yaml',
Asset.ruIntl: 'assets/i18/ru_intl.yaml',

};

class Assets {
String get notFound1 => notFound1S;
static const String notFound1S = 'assets/images/notFound_1.png';
String get secret8 => secret8S;
static const String secret8S = 'assets/images/secret_8.png';
String get notFound2 => notFound2S;
static const String notFound2S = 'assets/images/notFound_2.png';
String get notFound3 => notFound3S;
static const String notFound3S = 'assets/images/notFound_3.png';
String get notFound4 => notFound4S;
static const String notFound4S = 'assets/images/notFound_4.png';
String get secret2 => secret2S;
static const String secret2S = 'assets/images/secret_2.png';
String get secret3 => secret3S;
static const String secret3S = 'assets/images/secret_3.png';
String get secret1 => secret1S;
static const String secret1S = 'assets/images/secret_1.png';
String get secret4 => secret4S;
static const String secret4S = 'assets/images/secret_4.png';
String get secret5 => secret5S;
static const String secret5S = 'assets/images/secret_5.png';
String get secret7 => secret7S;
static const String secret7S = 'assets/images/secret_7.png';
String get secret6 => secret6S;
static const String secret6S = 'assets/images/secret_6.png';
String get enIntl => enIntlS;
static const String enIntlS = 'assets/i18/en_intl.yaml';
String get ruIntl => ruIntlS;
static const String ruIntlS = 'assets/i18/ru_intl.yaml';
    final Map<Asset, String> _preloadedAssets = Map();
    bool isPreloaded = false;
    Future<bool> preloadAssets() async {
      final List<Future> loaders = [];
      loadAsset(Asset asset) async {        
        final String assetContent = await rootBundle.loadString(_assetEnumMap[asset]!, cache: false);
        _preloadedAssets[asset] = assetContent;
      }
      for (Asset assetEnumField in Asset.values) {
        loaders.add(loadAsset(assetEnumField));
      }
      await Future.wait<void>(loaders);
      isPreloaded = true;
      return isPreloaded;
    }
    String getAssetData(Asset assetEnum) {
      if (!isPreloaded) {
        throw Exception('You should run method "preloadAssets" before accessing data with "getAssetData" method');
      }
      return _preloadedAssets[assetEnum]!;
    }
}