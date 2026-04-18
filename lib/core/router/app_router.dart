import 'package:fondos_app/gui/views/list_funds/funds_view.dart';
import 'package:go_router/go_router.dart';

/// Application routes.
class AppRoutes {
  AppRoutes._();

  static const String funds = '/funds';
  static const String transactions = '/transactions';

  static String fundDetail(String id) => '/funds/$id';
}

/// App router configuration with auth redirect.
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.funds,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: AppRoutes.funds, builder: (context, state) => FundsView()),
      // GoRoute(
      //   path: AppRoutes.transactions,
      //   builder: (context, state) => const TransactionHistoryView(),
      // ),
    ],
  );
}
