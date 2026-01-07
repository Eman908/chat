import 'package:chat/core/di/di.dart';
import 'package:chat/core/theme/theme_provider.dart';
import 'package:chat/run_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final provider = getIt<ThemeProvider>();
  provider.loadPreferences();
  runApp(ChangeNotifierProvider.value(value: provider, child: const MyApp()));
}
