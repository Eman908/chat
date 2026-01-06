import 'package:chat/core/routing/routes.dart';
import 'package:chat/presentation/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('Navigate To ${settings.name}');
    }
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Home(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const Scaffold(
              body: Center(child: Text('404 - Page Not Found')),
            );
          },
        );
    }
  }
}
