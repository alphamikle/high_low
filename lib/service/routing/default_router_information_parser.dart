import 'package:flutter/widgets.dart';

import 'route_configuration.dart';
import 'routes.dart';

class DefaultRouterInformationParser extends RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    return Future.sync(() => Routes.getRouteConfiguration(routeInformation.location ?? Routes.root()));
  }
}
