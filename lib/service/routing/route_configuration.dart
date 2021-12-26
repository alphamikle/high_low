import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../logs/logs.dart';
import '../types/types.dart';
import 'routes.dart';

part 'route_configuration.g.dart';

@immutable
@JsonSerializable()
class RouteConfiguration {
  const RouteConfiguration({
    required this.initialPath,
    required this.routeName,
    required this.routeParams,
  });

  const RouteConfiguration.empty({
    required this.initialPath,
    required this.routeName,
  }) : routeParams = const RouteParams(
            params: <String, String>{}, query: <String, String>{});

  factory RouteConfiguration.unknown() => RouteConfiguration.empty(
      initialPath: Routes.unknown(), routeName: Routes.unknown());
  factory RouteConfiguration.fromJson(Json json) =>
      _$RouteConfigurationFromJson(json);

  final String initialPath;
  final String routeName;
  final RouteParams routeParams;

  Json toJson() => _$RouteConfigurationToJson(this);

  @override
  String toString() => prettyJson(toJson());
}

@immutable
@JsonSerializable()
class RouteParams {
  const RouteParams({
    required this.params,
    required this.query,
  });

  factory RouteParams.fromJson(Json json) => _$RouteParamsFromJson(json);

  final Json params;
  final Json query;

  Json toJson() => _$RouteParamsToJson(this);
}
