import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/theme/theme_provider.dart';
import 'package:chat/core/utils/bloc_observer.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/run_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  final provider = getIt<ThemeProvider>();
  provider.loadPreferences();
  SharedPreferences pref = getIt();
  var token = pref.getString(AppConstants.kToken);
  Bloc.observer = MyBlocObserver();
  runApp(
    ChangeNotifierProvider.value(
      value: provider,
      child: MyApp(token: token),
    ),
  );
}
