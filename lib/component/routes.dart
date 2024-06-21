import 'package:flutter/material.dart';

Route createFadeRouteWidget({Widget? pageNavigate, int? timeMilliseconds}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: timeMilliseconds ?? 1),
    pageBuilder: (context, animation, secondaryAnimation) => pageNavigate ?? const SizedBox(),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

Route createDownToUpRouteWidget({Widget? pageNavigate, int? timeMilliseconds}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: timeMilliseconds ?? 1),
    pageBuilder: (context, animation, secondaryAnimation) => pageNavigate ?? const SizedBox(),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
class CoreRoutes {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  CoreRoutes();

  static final CoreRoutes _instance = CoreRoutes();

  BuildContext? get currentContext => navigatorKey.currentContext;

  static CoreRoutes get instance => _instance;

  String currentRoutes = '';

  Future<dynamic> navigateToRouteString(String routeName, {Object? arguments}) async =>
      navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);

  Future<dynamic> navigateAndRemove(String routeName, {Object? arguments}) async =>
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName,
            (Route<dynamic> route) => false,
        arguments: arguments,
      );

  Future<dynamic> navigateAndReplaceRouteString(String routeName, {Object? arguments}) async =>
      navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);

  dynamic pop({dynamic result}) => navigatorKey.currentState?.pop(result);

  void popUntil(bool Function(Route<dynamic>) predicate) => navigatorKey.currentState?.popUntil(predicate);

  Future<dynamic> navigateAndRemoveRoutes(route,) async =>
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => route),
            (Route<dynamic> route) => false,
      );

  Future<dynamic> navigatorPushRoutes(route,) async =>
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => route),
      );

  Future<dynamic> navigatorPushReplacementRoutes(route,) async =>
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => route),
      );

  Future<dynamic> navigateAndRemoveFade(route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState?.pushAndRemoveUntil(
        createFadeRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond),
            (Route<dynamic> route) => false,
      );

  Future<dynamic> navigatorPushFade(route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState?.push(
        createFadeRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond),
      );

  Future<dynamic> navigatorPushReplacementFade(route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState?.pushReplacement(
        createFadeRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond),
      );

  Future<dynamic> navigateAndRemoveDownToUp(route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState?.pushAndRemoveUntil(
        createDownToUpRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond),
            (Route<dynamic> route) => false,
      );

  Future<dynamic> navigatorPushDownToUp(route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState?.push(
        createDownToUpRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond),
      );

  Future<dynamic> navigatorPushReplacementDownToUp(route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState?.pushReplacement(
        createDownToUpRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond),
      );
}

