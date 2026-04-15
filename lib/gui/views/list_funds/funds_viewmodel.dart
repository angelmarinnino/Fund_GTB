import 'package:flutter/material.dart';
import 'package:fondos_app/core/providers/fund_provider.dart';
import 'package:fondos_app/data/models/items_dropdown_model.dart';
import 'package:provider/provider.dart';
import '../../../data/models/fund_model.dart';
import '../../../data/repositories/fund_repository.dart';

class FundServiceController {
  late BuildContext context;
  final ValueNotifier<bool> loading = ValueNotifier(false);
  List<ItemsDropdownModel> identificationTypes = [];
  ItemsDropdownModel? selectedFundType;
  List<FundModel> funds = [];
  List<FundModel> fundsFilter = [];
  String querySearch = '';
  double saldoDisponible = 500000;

  //Repository
  final FondoRepository repository = FondoRepositoryImpl();

  //Provider
  late FundProvider _fundProvider;

  static final FundServiceController _singleton = FundServiceController._();
  factory FundServiceController(BuildContext context) =>
      _singleton._instance(context);
  FundServiceController._();

  FundServiceController _instance(BuildContext context) {
    _singleton.context = context;
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
}
