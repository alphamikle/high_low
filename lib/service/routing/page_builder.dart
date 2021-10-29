import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Pages { material, cupertino, fade, slideRight, noAnimation }

class PageBuilder {
  Page<T> buildMaterialPage<T>(Widget child, {LocalKey? key, String? name}) => MaterialPage<T>(child: child, name: name, key: key);

  Page<T> buildCupertinoPage<T>(Widget child, {LocalKey? key, String? name}) => CupertinoPage<T>(child: child, name: name, key: key);

  Page<T> buildFadePage<T>(Widget child, {LocalKey? key, String? name}) => FadePage<T>(child: child, key: key, name: name);

  Page<T> buildSlideFromRightPage<T>(Widget child, {LocalKey? key, String? name}) => SlidePage<T>(child: child, key: key, name: name);

  Page<T> buildUnAnimatedPage<T>(Widget child, {LocalKey? key, String? name}) => NoAnimationPage<T>(child: child, key: key, name: name);
}

RoutePageBuilder _getDefaultBuilder(Widget child) => (BuildContext context, Animation<double> animation1, Animation<double> animation2) => child;

class FadePage<T> extends Page<T> {
  const FadePage({required this.child, LocalKey? key, String? name}) : super(key: key, name: name);

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    final Tween<double> tween = Tween<double>(begin: 0, end: 1);
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: _getDefaultBuilder(child),
      transitionsBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2, Widget child) => FadeTransition(
        key: name != null ? ValueKey(name) : null,
        opacity: animation1.drive(tween),
        child: child,
      ),
    );
  }
}

class NoAnimationPage<T> extends Page<T> {
  const NoAnimationPage({required this.child, LocalKey? key, String? name}) : super(key: key, name: name);

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => PageRouteBuilder<T>(
        settings: this,
        transitionDuration: const Duration(milliseconds: 0),
        reverseTransitionDuration: const Duration(milliseconds: 0),
        pageBuilder: _getDefaultBuilder(child),
        transitionsBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2, Widget child) => child,
      );
}

class SlidePage<T> extends Page<T> {
  const SlidePage({required this.child, LocalKey? key, String? name}) : super(key: key, name: name);

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    final Tween<Offset> tween = Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0));
    return PageRouteBuilder(
      settings: this,
      pageBuilder: _getDefaultBuilder(child),
      transitionsBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2, Widget child) => SlideTransition(
        position: animation1.drive(tween),
        child: child,
      ),
    );
  }
}
