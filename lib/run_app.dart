import 'package:chat/core/di/di.dart';
import 'package:chat/core/routing/app_routes.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/core/theme/theme_provider.dart';
import 'package:chat/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat/presentation/chat/chat_cubit/chat_cubit.dart';
import 'package:chat/presentation/chat/messages_cubit/messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.token});
  final String? token;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthCubit>()),
        BlocProvider.value(value: getIt<ChatCubit>()),
        BlocProvider.value(value: getIt<MessagesCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: provider.appTheme,
        darkTheme: AppTheme.darkTheme,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: Routes.home,
      ),
    );
  }
}
//token != null ? Routes.home :