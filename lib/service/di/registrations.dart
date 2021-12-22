import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../tools/localization_wrapper.dart';
import 'package:yalo_assets/lib.dart';

import '../../domain/crypto/logic/crypto_provider.dart';
import '../../domain/main/logic/main_frontend.dart';
import '../../domain/notification/logic/notification_service.dart';
import '../routing/default_router_information_parser.dart';
import '../routing/page_builder.dart';
import '../routing/root_router_delegate.dart';
import 'di.dart';

bool _isInitialized = false;
bool _isUiInitialized = false;

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
  Di.reg<CryptoProvider>(() => CryptoProvider(Di.get()));
  Di.reg(() => MainFrontend());
  Di.reg(() => Assets());
}

void initUiDependencies(BuildContext context) {
  if (_isUiInitialized) {
    return;
  }
  Di.reg(() => AppTheme(context));
  Di.reg(() => NotificationService(scaffoldMessenger: ScaffoldMessenger.of(context), appTheme: Di.get()));
  Di.reg(() => LocalizationWrapper(context: context));
}
