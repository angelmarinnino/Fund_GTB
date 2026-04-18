import 'package:fondos_app/core/providers/fund_provider.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/data/models/transaction_model.dart';
import 'package:fondos_app/data/models/user_model.dart';

import 'disposable_provider.dart';

class UserProvider extends DisposableProvider {
  UserModel _user;
  bool _loading = false;

  UserProvider()
      : _user = UserModel(
          id: 1,
          fullName: 'Usuario',
          email: 'usuario@ejemplo.com',
          balance: 500000,
          funds: const [],
        );

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  bool isSubscribedToFund(int fundId) =>
      _user.funds.any((f) => f.id == fundId);

  FundModel? subscribedFund(int fundId) {
    for (final f in _user.funds) {
      if (f.id == fundId) {
        return f;
      }
    }
    return null;
  }

  /// Para cada fila del listado de [loadFunds]: si ya estás suscrito, devuelve el
  /// [FundModel] guardado en [user.funds] (con transacciones y notificación);
  /// si no, el fondo tal como viene del catálogo.
  FundModel fundForList(FundModel fundCatalog) =>
      subscribedFund(fundCatalog.id) ?? fundCatalog;

  /// Suscripción: resta el **monto mínimo** del saldo en [user] y agrega el fondo
  /// al listado [UserModel.funds]. Actualiza [FundProvider.fund] con la copia suscrita.
  ///
  /// Devuelve `null` si tuvo éxito, o un mensaje de error (saldo insuficiente, etc.).
  String? subscribedToFund({
    required FundModel fundCatalog,
    required SubscriptionNotificationMethod notificationMethod,
    required FundProvider fundProvider,
  }) {
    final minAmount = fundCatalog.minimum.ceil();
    if (_user.balance < minAmount) {
      return 'No tienes saldo suficiente para suscribirte. '
          'Saldo disponible: COP \$${_user.balance.toStringAsFixed(0)}. '
          'Monto mínimo del fondo: COP \$${minAmount.toStringAsFixed(0)}.';
    }
    if (isSubscribedToFund(fundCatalog.id)) {
      return 'Ya estás suscrito a este fondo.';
    }

    final tx = TransactionModel(
      id: DateTime.now().microsecondsSinceEpoch,
      fundName: fundCatalog.name,
      transactionType: TransactionType.subscription,
      amount: fundCatalog.minimum,
      date: DateTime.now(),
      description: _notificationDescription(notificationMethod),
    );

    final fundInCart = fundCatalog.copyWith(
      notificationMethod: notificationMethod,
      transactions: [...fundCatalog.transactions, tx],
    );

    _user = _user.copyWith(
      balance: _user.balance - minAmount,
      funds: [..._user.funds, fundInCart],
    );
    fundProvider.fund = fundInCart;
    notifyListeners();
    return null;
  }

  /// Alias en inglés; delega en [suscribirAFondo].
  String? subscribeToFund({
    required FundModel catalogFund,
    required SubscriptionNotificationMethod notificationMethod,
    required FundProvider fundProvider,
  }) =>
      subscribedToFund(
        fundCatalog: catalogFund,
        notificationMethod: notificationMethod,
        fundProvider: fundProvider,
      );

  String _notificationDescription(SubscriptionNotificationMethod method) {
    switch (method) {
      case SubscriptionNotificationMethod.email:
        return 'Suscripción. Notificaciones por correo electrónico.';
      case SubscriptionNotificationMethod.sms:
        return 'Suscripción. Notificaciones por SMS.';
    }
  }

  /// Devuelve `null` si tuvo éxito, o un mensaje de error.
  String? cancelSubscription({
    required int fundId,
    required FundProvider fundProvider,
  }) {
    final existing = subscribedFund(fundId);
    if (existing == null) {
      return 'No estás suscrito a este fondo.';
    }

    final refund = existing.minimum.ceil();
    _user = _user.copyWith(
      balance: _user.balance + refund,
      funds: _user.funds.where((f) => f.id != fundId).toList(),
    );
    fundProvider.fund = FundModel();
    notifyListeners();
    return null;
  }

  @override
  void disposeValues() {
    _loading = false;
    _user = UserModel();
  }
}
