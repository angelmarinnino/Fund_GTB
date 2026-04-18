import 'package:flutter/material.dart';
import 'package:fondos_app/core/providers/fund_provider.dart';
import 'package:fondos_app/core/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'disposable_provider.dart';

class AppProviders {
  static List<DisposableProvider> _getDisposableProviders(
    BuildContext context,
  ) {
    return [context.read<FundProvider>(), context.read<UserProvider>()];
  }

  static List<SingleChildWidget> storeProviders = [
    ChangeNotifierProvider(create: (_) => FundProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ];

  static Future<void> disposeAllDisposableProviders(
    BuildContext context,
  ) async {
    await Future.forEach(_getDisposableProviders(context), (
      DisposableProvider provider,
    ) async {
      provider.disposeValues();
    });
  }
}
