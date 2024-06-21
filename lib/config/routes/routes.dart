import 'package:flutter/material.dart';
import 'package:handheld_calculator/config/routes/router_name.dart';
import '../../presentation/calculator/pages/calculator.dart';
import '../../presentation/splash/pages/splash.dart';
class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case RouteName.Handheld_calculator:
        return _materialRoute(const CalculatorScreen());
      case RouteName.SPLASH:
        return _materialRoute(const SplashScreen());
      default:
        return _materialRoute(const SplashScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
