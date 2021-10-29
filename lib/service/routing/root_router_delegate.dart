import 'dart:async';

import 'package:flutter/material.dart';
import 'package:high_low/domain/main/main_view.dart';
import 'package:high_low/service/di/di.dart';
import 'package:high_low/service/logs/logs.dart';
import 'package:high_low/service/routing/page_builder.dart';
import 'package:high_low/service/routing/route_configuration.dart';
import 'package:high_low/service/routing/routes.dart';

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
    return Navigator(
      key: navigatorKey,
      pages: [
        pageBuilder.buildUnAnimatedPage(const MainView(), name: Routes.root()),
        ...pages,
      ],
      onPopPage: onPopRoute,
    );
  }
}
