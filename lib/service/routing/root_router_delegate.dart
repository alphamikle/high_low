import 'dart:async';

import 'package:flutter/material.dart';
import '../../domain/notification/logic/notification_service.dart';
import '../di/registrations.dart';
import '../theme/app_theme.dart';
import '../tools/localization_wrapper.dart';
import 'package:provider/provider.dart';

import '../../domain/main/ui/main_view.dart';
import '../di/di.dart';
import '../logs/logs.dart';
import 'page_builder.dart';
import 'route_configuration.dart';
import 'routes.dart';

class RootRouterDelegate extends RouterDelegate<RouteConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  RootRouterDelegate() : navigatorKey = GlobalKey();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  PageBuilder get pageBuilder => Di.get();

  final List<Page> pages = [];

  @override
  RouteConfiguration currentConfiguration = RouteConfiguration.empty(initialPath: Routes.root(), routeName: Routes.root());

  bool onPopRoute(Route<dynamic> route, dynamic data) {
    if (route.didPop(data) == false) {
      return false;
    }
    pages.removeLast();
    notifyListeners();
    return true;
  }

  Future<void> mapRouteConfigurationToRouterState(RouteConfiguration configuration) async {
    final String name = configuration.routeName;
    pages.clear();
    if (name == Routes.unknown()) {
      // openUnknownView();
      Logs.warn('TODO: Open Unknown View');
    }
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    Logs.debug('setNewRoutePath: $configuration');
    currentConfiguration = configuration;
    await mapRouteConfigurationToRouterState(configuration);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    initUiDependencies(context);

    return MultiProvider(
      providers: [
        Provider(create: (BuildContext context) => AppTheme(context)),
        Provider.value(value: Di.get<NotificationService>()),
        Provider.value(value: Di.get<LocalizationWrapper>()),
      ],
      builder: (BuildContext context, Widget? child) => Navigator(
        key: navigatorKey,
        pages: [
          pageBuilder.buildUnAnimatedPage(const MainView(), name: Routes.root()),
          ...pages,
        ],
        onPopPage: onPopRoute,
      ),
    );
  }
}
