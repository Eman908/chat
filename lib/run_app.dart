import 'package:chat/core/routing/app_routes.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ThemeProvider(),
      builder: (context, child) {
        var provider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          theme: AppTheme.lightTheme,
          themeMode: provider.appTheme,
          darkTheme: AppTheme.darkTheme,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: Routes.home,
        );
      },
    );
  }
}
