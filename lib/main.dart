import 'package:flutter/material.dart';
import 'package:fondos_app/core/providers/index.dart';
import 'package:fondos_app/core/router/app_router.dart';
import 'package:fondos_app/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FundsApp());
}

class FundsApp extends StatelessWidget {
  const FundsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.storeProviders,
      child: MaterialApp.router(
        title: 'Fondos App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        themeMode: ThemeMode.light,
        routerConfig: createAppRouter(),
      ),
    );
  }
}
