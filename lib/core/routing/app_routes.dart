import 'package:chat/core/routing/routes.dart';
import 'package:chat/presentation/auth/login_view.dart';
import 'package:chat/presentation/auth/register_view.dart';
import 'package:chat/presentation/chat/chat_view.dart';
import 'package:chat/presentation/chat/home_view.dart';
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
          builder: (context) => const HomeView(),
        );
      case Routes.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LoginView(),
        );
      case Routes.chat:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ChatView(),
        );
      case Routes.register:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const RegisterView(),
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
