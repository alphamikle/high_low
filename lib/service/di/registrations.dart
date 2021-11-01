import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:high_low/domain/finhub/logic/finhub_provider.dart';
import 'package:high_low/service/di/di.dart';
import 'package:high_low/service/routing/default_router_information_parser.dart';
import 'package:high_low/service/routing/page_builder.dart';
import 'package:high_low/service/routing/root_router_delegate.dart';

void initDependencies() {
  Di.reg<BackButtonDispatcher>(() => RootBackButtonDispatcher());
  Di.reg<RouteInformationParser<Object>>(() => DefaultRouterInformationParser());
  Di.reg<RouterDelegate<Object>>(() => RootRouterDelegate());
  Di.reg(() => PageBuilder());
  Di.reg(() => Dio(), asBuilder: true);
  Di.reg(() => FinhubProvider(Di.get()), asBuilder: true);
}
