import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../domain/finhub/logic/finhub_provider.dart';
import '../routing/default_router_information_parser.dart';
import '../routing/page_builder.dart';
import '../routing/root_router_delegate.dart';
import 'di.dart';

void initDependencies() {
  Di.reg<BackButtonDispatcher>(() => RootBackButtonDispatcher());
  Di.reg<RouteInformationParser<Object>>(() => DefaultRouterInformationParser());
  Di.reg<RouterDelegate<Object>>(() => RootRouterDelegate());
  Di.reg(() => PageBuilder());
  Di.reg(() => Dio(), asBuilder: true);
  Di.reg(() => FinhubProvider(Di.get()), asBuilder: true);
}
