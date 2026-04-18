import 'package:flutter/material.dart';
import 'package:fondos_app/data/models/items_dropdown_model.dart';
import 'package:fondos_app/gui/views/list_funds/widgets/subscription_notification_dialog.dart';
import 'package:provider/provider.dart';
import '../../../data/models/fund_model.dart';
import '../../../data/repositories/fund_repository.dart';
import 'package:fondos_app/core/providers/user_provider.dart';
import 'package:fondos_app/core/providers/fund_provider.dart';

class FundServiceController {
  late BuildContext context;
  final ValueNotifier<bool> loading = ValueNotifier(false);
  List<ItemsDropdownModel> identificationTypes = [];
  ItemsDropdownModel? selectedFundType;
  List<FundModel> funds = [];
  List<FundModel> fundsFilter = [];
  String querySearch = '';

  //Repository
  final FondoRepository repository = FondoRepositoryImpl();

  //Provider
  late UserProvider _userProvider;
  late FundProvider _fundProvider;

  static final FundServiceController _singleton = FundServiceController._();
  factory FundServiceController(BuildContext context) =>
      _singleton._instance(context);
  FundServiceController._();

  FundServiceController _instance(BuildContext context) {
    _singleton.context = context;
    _singleton._userProvider = context.read<UserProvider>();
    _singleton._fundProvider = context.read<FundProvider>();
    return _singleton;
  }

  void init() async {
    identificationTypes = [
      ItemsDropdownModel(label: 'Todos los tipos', value: 'Todos los tipos'),
      ItemsDropdownModel(label: 'FPV', value: 'FPV'),
      ItemsDropdownModel(label: 'FIC', value: 'FIC'),
    ];
    await loadFunds();
  }

  Future<void> loadFunds() async {
    loading.value = true;
    funds = await repository.getFunds();
    fundsFilter = funds;
    loading.value = false;
  }

  void setFundType(ItemsDropdownModel? type) async {
    selectedFundType = type;
    await _applyFilter();
  }

  Future<void> search(String query) async {
    querySearch = query;
    await _applyFilter();
  }

  Future<void> _applyFilter() async {
    loading.value = true;

    List<FundModel> result = await repository.filterByType(
      selectedFundType?.value ?? 'Todos los tipos',
    );

    if (querySearch.isNotEmpty) {
      result = result
          .where(
            (f) =>
                f.name.toLowerCase().contains(querySearch.toLowerCase()) ||
                f.description.toLowerCase().contains(querySearch.toLowerCase()),
          )
          .toList();
    }

    fundsFilter = result;
    loading.value = false;
  }

  String formatCurrency(double mount) {
    return 'COP \$${mount.toStringAsFixed(0)}';
  }

  Future<void> handleSubscribe(BuildContext context, FundModel fund) async {
    final method = await showSubscriptionNotificationDialog(context, fund);
    if (!context.mounted || method == null) {
      return;
    }
    final err = _userProvider.subscribeToFund(
      catalogFund: fund,
      notificationMethod: method,
      fundProvider: _fundProvider,
    );
    if (!context.mounted) {
      return;
    }
    _showResultSnackBar(
      context,
      err,
      successMessage: 'Suscripción registrada correctamente.',
    );
  }

  Future<void> handleCancelSubscription(
    BuildContext context,
    FundModel fund,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancelar suscripción'),
        content: Text(
          '¿Seguro que deseas cancelar tu suscripción a ${fund.name}? '
          'Se reintegrará el monto mínimo a tu saldo disponible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Sí'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) {
      return;
    }
    final err = _userProvider.cancelSubscription(
      fundId: fund.id,
      fundProvider: _fundProvider,
    );
    if (!context.mounted) {
      return;
    }
    _showResultSnackBar(
      context,
      err,
      successMessage: 'Suscripción cancelada. Saldo actualizado.',
    );
  }

  void _showResultSnackBar(
    BuildContext context,
    String? error, {
    required String successMessage,
  }) {
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red.shade800),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(successMessage)));
    }
  }
}
