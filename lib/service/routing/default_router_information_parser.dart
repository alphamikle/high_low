import 'package:flutter/cupertino.dart';
import 'package:high_low/service/routing/route_configuration.dart';
import 'package:high_low/service/routing/routes.dart';

class DefaultRouterInformationParser extends RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    return Future.sync(() => Routes.getRouteConfiguration(routeInformation.location ?? Routes.root()));
  }
}
