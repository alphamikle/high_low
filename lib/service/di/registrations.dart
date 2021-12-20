import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:high_low/domain/crypto/logic/crypto_provider.dart';
import 'package:high_low/domain/crypto/logic/crypto_provider_web.dart';
import 'package:high_low/domain/main/logic/main_frontend.dart';

import '../../domain/crypto/logic/crypto_provider_native.dart';
import '../routing/default_router_information_parser.dart';
import '../routing/page_builder.dart';
import '../routing/root_router_delegate.dart';
import 'di.dart';

bool _isInitialized = false;

void initDependencies() {
  if (_isInitialized) {
    return;
  }
  _isInitialized = true;
  Di.reg<BackButtonDispatcher>(() => RootBackButtonDispatcher());
  Di.reg<RouteInformationParser<Object>>(() => DefaultRouterInformationParser());
  Di.reg<RouterDelegate<Object>>(() => RootRouterDelegate());
  Di.reg(() => PageBuilder());
  Di.reg(
      () => Dio(
            BaseOptions(
              headers: {
                'Access-Control-Allow-Headers': 'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale,Access-Control-Allow-Origin',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Credentials': true,
                'Access-Control-Allow-Methods': 'GET,POST,OPTIONS',
              },
            ),
          ),
      asBuilder: true);
  Di.reg<CryptoProvider>(() => kIsWeb ? CryptoProviderWeb(Di.get()) : CryptoProviderNative(Di.get()), asBuilder: true);
  Di.reg(() => MainFrontend());
}
