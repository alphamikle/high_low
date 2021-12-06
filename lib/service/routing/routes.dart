import 'route_configuration.dart';

typedef RouteParamName = String;
typedef RouteParamValue = String;

const String itemCode = 'itemCode';

abstract class Routes {
  static String root() => '/';
  static String item(String itemCode) => '/item/$itemCode';
  static String unknown() => '/404';

  static List<String> names = [
    Routes.root(),
    Routes.item(':$itemCode'),
    Routes.unknown(),
  ];

  static RouteConfiguration getRouteConfiguration(String route) {
    if (route == Routes.root()) {
      return RouteConfiguration.empty(initialPath: route, routeName: Routes.root());
    }
    final Uri routeUri = Uri.parse(route);
    final List<String> routeSubPaths = routeUri.pathSegments;
    if (routeSubPaths.isEmpty) {
      return RouteConfiguration.empty(initialPath: route, routeName: Routes.unknown());
    }
    for (final String routeName in names) {
      final List<String> routeNameSubPaths = routeName.split('/').where((String segment) => segment.isNotEmpty).toList();
      if (routeNameSubPaths.length != routeSubPaths.length) {
        continue;
      }
      bool isTargetName = true;
      final Map<RouteParamName, RouteParamValue> params = {};
      for (int i = 0; i < routeSubPaths.length; i++) {
        final String routeSubPath = routeSubPaths[i];
        final String routeNameSubPath = routeNameSubPaths[i];
        final bool isDynamicSubPath = routeNameSubPath.contains(':');
        if (routeSubPath != routeNameSubPath && !isDynamicSubPath) {
          isTargetName = false;
          break;
        } else if (isDynamicSubPath) {
          params[routeNameSubPath.replaceFirst(':', '')] = routeSubPath;
        }
      }
      if (isTargetName) {
        return RouteConfiguration(initialPath: route, routeName: routeName, routeParams: RouteParams(params: params, query: routeUri.queryParameters));
      }
    }
    return RouteConfiguration.empty(initialPath: route, routeName: Routes.unknown());
  }
}
